# Stage 1: Build dependencies
FROM python:3.9-slim-buster AS builder

WORKDIR /app

COPY req.txt .
RUN pip install -r req.txt --no-cache-dir

# Stage 2: Create final image
FROM python:3.9-slim-buster

WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /app/requirements.txt .  # Copy only the requirements
COPY --from=builder /app/.venv /app/.venv
COPY . .  # Copy your application code

# Activate the virtual environment if you created one
# RUN source .venv/bin/activate

# Set environment variables if needed
# ENV ...

CMD ["python", "app.py"]
