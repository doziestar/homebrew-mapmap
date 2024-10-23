#!/bin/bash

# MapMap installation script
# This script detects the operating system and architecture and installs MapMap accordingly.

set -e  # Exit on any error

# Default URLs for latest versions (these should be updated in your CI/CD workflow)
ARM_DMG_URL="https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_latest_arm64.dmg"
INTEL_DMG_URL="https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_latest_x86.dmg"
WIN_EXE_URL="https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_latest_win.exe"

# Detect the platform
PLATFORM="unknown"
ARCH="unknown"
if [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macOS"
    ARCH=$(uname -m)
elif [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    PLATFORM="Windows"
else
    echo "Unsupported platform: $OSTYPE"
    exit 1
fi

# Download and install the latest version based on platform and architecture
download_and_install() {
    local url=$1
    local file_name=$2
    echo "Downloading $file_name..."
    
    curl -L -o "$file_name" "$url"

    if [[ $? -ne 0 ]]; then
        echo "Error downloading $file_name"
        exit 1
    fi

    echo "Downloaded $file_name successfully."
    
    if [[ "$PLATFORM" == "macOS" ]]; then
        echo "Mounting DMG..."
        hdiutil attach "$file_name" -nobrowse

        echo "Copying the app to /Applications..."
        cp -r /Volumes/MapMap/MapMap.app /Applications/

        echo "Unmounting DMG..."
        hdiutil detach /Volumes/MapMap

        echo "Cleaning up..."
        rm "$file_name"

        echo "MapMap has been installed successfully!"
    elif [[ "$PLATFORM" == "Windows" ]]; then
        echo "Running the installer..."
        start "$file_name"
    fi
}

# macOS Installation
if [[ "$PLATFORM" == "macOS" ]]; then
    if [[ "$ARCH" == "arm64" ]]; then
        echo "Detected macOS ARM architecture."
        download_and_install "$ARM_DMG_URL" "MapMap_arm64.dmg"
    elif [[ "$ARCH" == "x86_64" ]]; then
        echo "Detected macOS Intel architecture."
        download_and_install "$INTEL_DMG_URL" "MapMap_x86.dmg"
    else
        echo "Unsupported macOS architecture: $ARCH"
        exit 1
    fi

# Windows Installation
elif [[ "$PLATFORM" == "Windows" ]]; then
    echo "Detected Windows platform."
    download_and_install "$WIN_EXE_URL" "MapMap_win.exe"
fi

