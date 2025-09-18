#!/bin/sh
cd `dirname $0`

# Create a virtual environment to run our code
VENV_NAME="venv"
PYTHON="$VENV_NAME/bin/python"

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_NAME" ]; then
    echo "Creating virtual environment..."
    python3 -m venv $VENV_NAME
    if [ $? -ne 0 ]; then
        echo "Failed to create virtual environment"
        exit 1
    fi
fi

# Install/upgrade pip and PyInstaller
echo "Installing PyInstaller..."
if ! $PYTHON -m pip install --upgrade pip pyinstaller -qq; then
    echo "Failed to install PyInstaller"
    exit 1
fi

# Install module dependencies
echo "Installing module dependencies..."
if ! $PYTHON -m pip install -r requirements.txt -qq; then
    echo "Failed to install module dependencies"
    exit 1
fi

# Clean previous builds
echo "Cleaning previous builds..."
rm -rf dist/ build/ *.spec

# Build the executable
echo "Building executable with PyInstaller..."
$PYTHON -m PyInstaller \
    --onefile \
    --name=main \
    --distpath=dist \
    --workpath=build \
    --specpath=. \
    --add-data="src:src" \
    --hidden-import="src.models.bmp_sensor" \
    src/main.py

if [ $? -ne 0 ]; then
    echo "PyInstaller build failed"
    exit 1
fi

# Create the archive
echo "Creating module archive..."
mkdir -p dist

# Get the absolute path of the current directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create the archive with absolute paths
tar -czf "$SCRIPT_DIR/dist/archive.tar.gz" \
    -C "$SCRIPT_DIR/dist" main \
    -C "$SCRIPT_DIR" build.sh \
    -C "$SCRIPT_DIR" run.sh \
    -C "$SCRIPT_DIR" setup.sh \
    -C "$SCRIPT_DIR" requirements.txt \
    -C "$SCRIPT_DIR" meta.json \
    -C "$SCRIPT_DIR" README.md

if [ $? -ne 0 ]; then
    echo "Failed to create archive"
    exit 1
fi

echo "Build completed successfully: dist/archive.tar.gz"
