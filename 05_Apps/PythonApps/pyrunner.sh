#!/usr/bin/env bash

# ==========================
# CONFIG
# ==========================
PYTHON_VERSION="3.11.9"
ENV_NAME="py311-env"
REQ_FILE="requirements.txt"

# ==========================
# INPUT
# ==========================
if [ -z "$1" ]; then
    echo "Usage: $0 <python_file.py>"
    exit 1
fi

PY_FILE="$1"

if [ ! -f "$PY_FILE" ]; then
    echo "❌ Python file not found: $PY_FILE"
    exit 1
fi

# ==========================
# LOAD PYENV
# ==========================
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# ==========================
# INSTALL PYTHON IF NEEDED
# ==========================
if ! pyenv versions --bare | grep -q "^$PYTHON_VERSION$"; then
    echo "⬇ Installing Python $PYTHON_VERSION..."
    pyenv install "$PYTHON_VERSION"
else
    echo "✅ Python $PYTHON_VERSION already installed"
fi

# ==========================
# SET LOCAL PYTHON VERSION
# ==========================
pyenv local "$PYTHON_VERSION"

# ==========================
# CREATE VENV
# ==========================
if [ ! -d "$ENV_NAME" ]; then
    echo "🛠 Creating virtual environment: $ENV_NAME"
    python -m venv "$ENV_NAME"
fi

# ==========================
# ACTIVATE ENV
# ==========================
echo "🔌 Activating environment..."
source "$ENV_NAME/bin/activate"

# ==========================
# INSTALL DEPENDENCIES
# ==========================
if [ -f "$REQ_FILE" ]; then
    echo "📦 Installing dependencies from $REQ_FILE"
    pip install --upgrade pip
    pip install -r "$REQ_FILE"
else
    echo "⚠ No requirements.txt found – skipping dependency install"
fi

# ==========================
# RUN SCRIPT
# ==========================
echo "▶ Running Python: $PY_FILE"
python "$PY_FILE"

# ==========================
# DEACTIVATE
# ==========================
echo "🔚 Deactivating environment"
deactivate

echo "✅ Done!"
