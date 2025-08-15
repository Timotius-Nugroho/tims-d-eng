set -e

VENV_DIR="etl-venv"

echo "📦 Membuat virtual environment '$VENV_DIR'..."
python3 -m venv "$VENV_DIR"

echo "✅ Virtual environment dibuat."
echo "🔌 Mengaktifkan virtual environment..."
source "$VENV_DIR/bin/activate"