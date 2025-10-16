#!/bin/bash

# Variables
XREMAP_URL="https://github.com/xremap/xremap/releases/download/v0.10.12/xremap-linux-x86_64-wlroots.zip"

INSTALL_DIR="/usr/local/bin"
SERVICE_DIR="$HOME/.config/systemd/user"
CONFIG_DIR="$HOME/.config/xremap"
GROUP_NAME="input"

# 1. Install dependencies
sudo apt update
sudo apt install -y unzip curl

# 2. Download and install xremap
echo "Downloading xremap..."
curl -L -o xremap.zip "$XREMAP_URL"
unzip xremap.zip
sudo mv xremap "$INSTALL_DIR/"
sudo chmod +x "$INSTALL_DIR/xremap"
rm xremap.zip

# 3. Create configuration directory and file
mkdir -p "$CONFIG_DIR"
cat <<EOF > "$CONFIG_DIR/config.yml"
keymap:
  - name: vim-like arrows
    remap:
      Alt_L-h: left
      Alt_L-j: down
      Alt_L-k: up
      Alt_L-l: right
  - name: brightness control
    remap:
      KEY_BRIGHTNESSDOWN:
        launch: ["brightnessctl", "set", "5%-"]
      KEY_BRIGHTNESSUP:
        launch: ["brightnessctl", "set", "5%+"]
modmap:
  - name: Swap CapsLock and LeftCtrl
    remap:
      CapsLock: Control_L
      Control_L: CapsLock
EOF

# 4. Give permission to use /dev/uinput without sudo
echo "Configuring permissions..."

# Make sure the input group exists
if ! getent group "$GROUP_NAME" > /dev/null 2>&1; then
    sudo groupadd "$GROUP_NAME"
fi

# Add current user to input group
# NOTE: User also needs to be added to the video group to get permission to run brightnessctl
sudo usermod -aG "$GROUP_NAME" "$USER"

# Set udev rules
cat <<EOF | sudo tee /etc/udev/rules.d/99-input.rules
KERNEL=="uinput", GROUP="$GROUP_NAME", MODE="0660"
EOF

# 5. Create custom systemd service
echo "Creating systemd service..."
mkdir -p ${SERVICE_DIR}
cat <<EOF | sudo tee "$SERVICE_DIR/xremap.service"
[Unit]
Description=Xremap
After=default.target

[Service]
ExecStart=${INSTALL_DIR}/xremap --watch %h/.config/xremap/config.yml
Restart=always
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=default.target
EOF

# Reload systemd and enable service
sudo systemctl --user enable xremap.service
sudo systemctl --user start xremap.service --now

echo
echo "Installation complete!"
echo "Please reboot your machine"
