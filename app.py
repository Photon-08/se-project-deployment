from flask import Flask
from backend.config import LocalDevelopmentConfig
from backend.model import db, User, Role
from flask_security import Security, SQLAlchemyUserDatastore
import os


def createApp():
    app = Flask(
        __name__,
        template_folder='./frontend',
        static_folder='./frontend',
        static_url_path='/static/'
    )
    #app = Flask(__name__, template_folder='frontend', static_folder='frontend', static_url_path='/static')

    app.config.from_object(LocalDevelopmentConfig)

    db.init_app(app)
    #flask security
    datastore = SQLAlchemyUserDatastore(db, User, Role)

    app.security = Security(app, datastore=datastore, register_blueprint=False)
    app.app_context().push()
    from backend.api import api
    # flask-restful init
    api.init_app(app)
    return app

app = createApp()
import backend.create_initial_data
import backend.router


#please uncomment this for dev
#if (__name__ == '__main__'):
#    app.run()

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))  # Get port from env or default
    host = "0.0.0.0"  # Listen on all interfaces (important for Cloud Run)
    app.run(debug=True, host=host, port=port)  # Run app with host and port
