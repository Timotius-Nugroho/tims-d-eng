#!/bin/bash
# Jalankan Airflow scheduler & webserver bersamaan
# venv: airflow-venv

# Aktifkan virtual environment
source airflow-venv/bin/activate

# Pastikan database sudah diinisialisasi
airflow db init

# Jalankan scheduler di background
nohup airflow scheduler > scheduler.log 2>&1 &

# Jalankan webserver di background di port 3000
nohup airflow webserver --port 3000 > webserver.log 2>&1 &

echo "Airflow scheduler dan webserver sudah berjalan."
echo "Scheduler log: $(pwd)/scheduler.log"
echo "Webserver log: $(pwd)/webserver.log"

# Cek proses yang sedang berjalan
ps aux | grep airflow
