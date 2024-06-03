#!/bin/bash
# entrypoint.sh

# Initialize the database
airflow db init

# Create an admin user if it doesn't already exist
airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin || echo "Admin user already exists"

# Start the webserver
exec airflow webserver --port 8080
