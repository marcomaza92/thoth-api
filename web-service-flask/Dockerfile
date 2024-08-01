# Python base image
FROM python:3.9-slim

# Set work directory in container
WORKDIR /app

# Install curl --> Needed for healthcheck
RUN apt-get update && apt-get install -y curl

# Copy project files to container
COPY . .

# Install dependencies
RUN pip install -r requirements.txt

# Expose port 5000 for Flask app
EXPOSE 5000

# Run Gunicorn
CMD ["sh", "./gunicorn_start.sh"]