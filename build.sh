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
else
    echo "Virtual environment already exists, checking permissions..."
    # Check if we can write to the venv, if not, recreate it
    if [ ! -w "$VENV_NAME" ]; then
        echo "Virtual environment has permission issues, recreating..."
        sudo rm -rf $VENV_NAME
        python3 -m venv $VENV_NAME
        if [ $? -ne 0 ]; then
            echo "Failed to recreate virtual environment"
            exit 1
        fi
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
    --hidden-import="googleapiclient" \
    --hidden-import="viam" \
    --hidden-import="adafruit_bmp280" \
    --hidden-import="adafruit_bus_device" \
    --hidden-import="board" \
    --hidden-import="busio" \
    src/main.py

if [ $? -ne 0 ]; then
    echo "PyInstaller build failed"
    exit 1
fi

# Create the archive
echo "Creating module archive..."
mkdir -p dist
tar -czf dist/archive.tar.gz \
    -C dist main \
    build.sh \
    run.sh \
    setup.sh \
    requirements.txt \
    meta.json \
    README.md

if [ $? -ne 0 ]; then
    echo "Failed to create archive"
    exit 1
fi

echo "Build completed successfully: dist/archive.tar.gz"
