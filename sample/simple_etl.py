from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import csv
import os

# ----- Fungsi ETL -----
def extract():
    """Mengekstrak data sumber."""
    data = [
        {"name": "Alice", "age": 30},
        {"name": "Bob", "age": 22},
        {"name": "Charlie", "age": 27},
    ]
    return data

def transform(**context):
    """Mengambil data dari XCom, filter, dan mengembalikannya."""
    ti = context['ti']  # 'ti' adalah singkatan dari Task Instance
    data = ti.xcom_pull(task_ids='extract')
    filtered = [d for d in data if d['age'] > 25]
    return filtered

def load(**context):
    """Mengambil data yang sudah ditransformasi dari XCom dan menyimpannya ke CSV."""
    ti = context['ti']
    data = ti.xcom_pull(task_ids='transform')

    # Path hasil
    output_dir = "/home/user/tims-d-eng/tools/run_result"
    os.makedirs(output_dir, exist_ok=True)
    output_path = os.path.join(output_dir, "output.csv")

    with open(output_path, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["name", "age"])
        writer.writeheader()
        writer.writerows(data)

    print(f"✅ Data berhasil disimpan di {output_path}")

# ----- Definisi DAG -----
with DAG(
    dag_id="simple_etl",
    start_date=datetime(2025, 8, 15),
    schedule=None,
    catchup=False,
    tags=['example']
) as dag:

    task_extract = PythonOperator(
        task_id="extract",
        python_callable=extract
    )

    task_transform = PythonOperator(
        task_id="transform",
        python_callable=transform
    )

    task_load = PythonOperator(
        task_id="load",
        python_callable=load
    )

    task_extract >> task_transform >> task_load
