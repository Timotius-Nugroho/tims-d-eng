#!/bin/bash
set -e

VENV_DIR="airflow-venv"

# Aktifkan venv
if [ ! -d "$VENV_DIR" ]; then
    echo "❌ Virtual environment '$VENV_DIR' tidak ditemukan."
    echo "Jalankan setup terlebih dahulu."
    exit 1
fi
source "$VENV_DIR/bin/activate"

echo "⏳ Menjalankan Airflow Scheduler..."
airflow scheduler
