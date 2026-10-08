#!/usr/bin/env bash
set -euo pipefail

ARDUINO_VERSION="2.3.10"
ARCH="Linux_64bit"        # use Linux_ARM64 on arm64 runners

cd /tmp
curl -fsSL -o arduino-ide.zip \
  "https://downloads.arduino.cc/arduino-ide/arduino-ide_${ARDUINO_VERSION}_${ARCH}.zip"

sudo mkdir -p /opt/arduino-ide
sudo unzip -q arduino-ide.zip -d /opt/arduino-ide
rm arduino-ide.zip

# Find the extracted AppImage and unpack it (no FUSE in containers)
cd /opt/arduino-ide
APPIMAGE=$(find . -maxdepth 1 -iname "*.AppImage" | head -n1)
sudo chmod +x "$APPIMAGE"
sudo "$APPIMAGE" --appimage-extract >/dev/null
sudo rm "$APPIMAGE"

# Expose a launcher on PATH
sudo ln -sf /opt/arduino-ide/squashfs-root/arduino-ide /usr/local/bin/arduino-ide

echo "Arduino IDE ${ARDUINO_VERSION} installed. Launch with: arduino-ide"