# Use the official Apache Airflow image as a base
FROM apache/airflow:2.5.0

# Install necessary packages
USER root

# Install ODBC driver for SQL Server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Switch back to the airflow user to install Python packages
USER airflow

# Install necessary Python packages
RUN pip install apache-airflow[azure] apache-airflow[google] pyodbc pandas

# Copy entrypoint script
COPY --chown=airflow:airflow entrypoint.sh /entrypoint.sh

# Ensure the script is executable
USER root
RUN chmod +x /entrypoint.sh

USER airflow

# Expose web server port
EXPOSE 8080

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
