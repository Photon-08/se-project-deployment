# Use a specific Python version
FROM python:3.9.6-slim-buster

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file first to leverage Docker's caching.
COPY requirements.txt .

# Install project dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port your Flask app listens on. Flask's default is 5000.
EXPOSE 5000

# Set the environment variable for Flask to run in production mode
ENV FLASK_ENV production

# Define the command to run when the container starts. Gunicorn is recommended for production.
CMD ["gunicorn", "--bind=0.0.0.0:5000", "app:app"] # Replace your_app_name with the name of your Flask app file (e.g., main.py) and "app" with the name of your Flask app instance (e.g., app = Flask(__name__))

# Alternatively, for development, you can use the Flask development server (not recommended for production):
# CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]