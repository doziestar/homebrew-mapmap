#!/bin/bash

# MapMap installation script
# This script detects the operating system and architecture and installs MapMap accordingly.

set -e  # Exit on any error

# URLs for DMGs (these will be dynamically updated in GitHub Actions)
INTEL_DMG_URL="https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_latest_x86.dmg"
ARM_DMG_URL="https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_latest_arm64.dmg"

# Function to install MapMap on macOS
install_macos() {
  echo "Detected macOS"

  # Determine the architecture and set the URL
  if [ "$(uname -m)" = "arm64" ]; then
    ARCH="arm64"
    DMG_URL="$ARM_DMG_URL"
  else
    ARCH="x86"
    DMG_URL="$INTEL_DMG_URL"
  fi

  echo "Downloading MapMap for ${ARCH}..."
  curl -L "${DMG_URL}" -o MapMap.dmg

  echo "Mounting DMG..."
  hdiutil attach MapMap.dmg

  echo "Copying MapMap to Applications..."
  cp -r /Volumes/MapMap/MapMap.app /Applications/

  echo "Cleaning up..."
  hdiutil detach /Volumes/MapMap
  rm MapMap.dmg

  echo "MapMap has been successfully installed! You can find it in your Applications folder."
}

# Function to install MapMap on Windows
install_windows() {
  echo "Detected Windows"

  ARCH="x64"
  MSI_URL="https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_latest_${ARCH}.msi"

  echo "Downloading MapMap for ${ARCH}..."
  curl -L "${MSI_URL}" -o MapMap.msi

  echo "Running installer..."
  msiexec /i MapMap.msi /qn

  echo "Cleaning up..."
  rm MapMap.msi

  echo "MapMap has been successfully installed!"
}

# Function to detect OS and call appropriate installation method
detect_os_and_install() {
  UNAME_OUT="$(uname -s)"
  case "${UNAME_OUT}" in
      Linux*)     OS="Linux";;
      Darwin*)    OS="Mac";;
      CYGWIN*|MINGW*|MSYS*) OS="Windows";;
      *)          OS="UNKNOWN:${UNAME_OUT}"
  esac

  if [ "${OS}" = "Mac" ]; then
    install_macos
  elif [ "${OS}" = "Windows" ]; then
    install_windows
  else
    echo "Unsupported OS: ${OS}"
    exit 1
  fi
}

# Start installation process
detect_os_and_install
