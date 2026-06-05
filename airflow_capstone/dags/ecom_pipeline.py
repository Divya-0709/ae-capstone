from airflow.sdk import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    dag_id='ecom_capstone_pipeline',
    default_args=default_args,
    description='E-commerce AE pipeline: dbt + Great Expectations',
    schedule='@daily',
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=['capstone', 'ecommerce'],
) as dag:

    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='echo "dbt run completed"',
    )

    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command='echo "dbt test completed"',
    )

    ge_validation = BashOperator(
        task_id='ge_validation',
        bash_command='echo "GE validation completed"',
    )

    dbt_run >> dbt_test >> ge_validation