
from airflow import DAG

from airflow.operators.bash import BashOperator
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email': ['airflow@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5)
}
with DAG(
    'tutorial',
    default_args=default_args,
    description='BQ ETL',
    schedule_interval=timedelta(days=1),
    start_date=datetime(2021, 1, 1),
    catchup=False,
    tags=['example'],
    template_searchpath="/opt/scripts"
) as dag:

    # t1, t2 and t3 are examples of tasks created by instantiating operators
    t1 = BashOperator(
        task_id='create table if not exists',
        bash_command='bq query --use_legacy_sql=false < create_statement.sql',
    )

    t2 = BashOperator(
        task_id='execute emp_s1',
        depends_on_past=False,
        bash_command='bq query --use_legacy_sql=false < emp_s1.sql',
        retries=3,
    )

    t3 = BashOperator(
        task_id='execute emp_s3',
        depends_on_past=False,
        bash_command='bq query --use_legacy_sql=false < emp_s2.sql',
        retries=3,
    )

    t4 = BashOperator(
        task_id='execute emp_s4',
        depends_on_past=False,
        bash_command='bq query --use_legacy_sql=false < emp_s3.sql',
        retries=3,
    )

    t5 = BashOperator(
        task_id='execute emp_s5',
        depends_on_past=False,
        bash_command='bq query --use_legacy_sql=false < emp_s4.sql',
        retries=3,
    )
    t6 = BashOperator(
        task_id='execute emp_s6',
        depends_on_past=False,
        bash_command='bq query --use_legacy_sql=false < emp_s5.sql',
        retries=3,
    )
    t1 >> [t2, t3, t4] >> t5 >> t6
