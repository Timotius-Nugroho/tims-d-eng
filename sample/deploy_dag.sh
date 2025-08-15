#!/bin/bash

# Hentikan script kalau ada error
set -e

# Cek argumen
if [ $# -eq 0 ]; then
    echo "❌ Error: Harap berikan path file DAG."
    echo "Usage: $0 /path/to/dag_file.py"
    exit 1
fi

DAG_FILE="$1"
DAGS_FOLDER="$HOME/airflow/dags"

# Pastikan folder dags ada
mkdir -p "$DAGS_FOLDER"

# Cek apakah file ada
if [ ! -f "$DAG_FILE" ]; then
    echo "❌ Error: File '$DAG_FILE' tidak ditemukan."
    exit 1
fi

# Copy file ke folder dags
cp "$DAG_FILE" "$DAGS_FOLDER/"

echo "✅ DAG berhasil di-copy ke $DAGS_FOLDER"
ls -l "$DAGS_FOLDER"
