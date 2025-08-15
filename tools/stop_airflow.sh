#!/bin/bash
echo "🛑 Menghentikan Airflow webserver & scheduler..."
pkill -f "airflow webserver"
pkill -f "airflow scheduler"
echo "✅ Airflow stopped."
