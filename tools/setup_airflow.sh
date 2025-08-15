#!/bin/bash
set -e

VENV_DIR="airflow-venv"

echo "📦 Membuat virtual environment '$VENV_DIR'..."
python3 -m venv "$VENV_DIR"

echo "✅ Virtual environment dibuat."

echo "🔌 Mengaktifkan virtual environment..."
source "$VENV_DIR/bin/activate"

echo "⬇️ Menginstall Apache Airflow 2.9.3..."
pip install --upgrade pip
pip install "apache-airflow==2.9.3" \
    --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.9.3/constraints-3.11.txt"

echo "🗄️ Inisialisasi database Airflow..."
airflow db init

echo "👤 Membuat user admin default..."
airflow users create \
    --username admin \
    --password admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com

echo "✅ Setup selesai!"
echo "Gunakan 'start_airflow_webserver.sh' dan 'start_airflow_scheduler.sh' untuk menjalankan Airflow."
