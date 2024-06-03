from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.odbc.hooks.odbc import OdbcHook
import pendulum
import pandas as pd

def fetch_data():
    # Create an ODBC hook
    odbc_hook = OdbcHook(conn_id='azure_sql_conn')
    
    # SQL query to execute
    sql = "SELECT TOP 1 * FROM [Dimension].[City]"
    
    # Fetch data
    df = odbc_hook.get_pandas_df(sql)
    print(df)

default_args = {
    'owner': 'airflow',
    'start_date': pendulum.today('UTC').add(days=-1),
}

dag = DAG(
    'test_azure_sql_odbc',
    default_args=default_args,
    schedule='@once',  # Updated parameter name
)

fetch_data_task = PythonOperator(
    task_id='fetch_data',
    python_callable=fetch_data,
    dag=dag,
)

fetch_data_task
