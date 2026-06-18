#!/bin/bash
# RHA FX CODE - Termux Setup Script
# Works like OpenCode - simple and clean

set -e

echo "=========================================="
echo "  RHA FX CODE - Termux Setup"
echo "  Open Source AI Coding Agent"
echo "=========================================="
echo ""

# Step 1: Update packages
echo "[01] Updating packages..."
pkg update -y && pkg upgrade -y

# Step 2: Install proot-distro
echo "[02] Installing proot-distro..."
pkg install proot-distro -y

# Step 3: Setup storage
echo "[03] Setting up storage..."
termux-setup-storage

# Step 4: Install Ubuntu
echo "[04] Installing Ubuntu..."
proot-distro install ubuntu

# Step 5: Login and setup Ubuntu
echo "[05] Setting up Ubuntu..."
proot-distro login ubuntu -- bash -c '
apt update && apt upgrade -y
apt install curl -y
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs
'

# Step 6: Download RHA FX CODE
echo "[06] Downloading RHA FX CODE..."
cd ~/AIProjects 2>/dev/null || mkdir -p ~/AIProjects && cd ~/AIProjects
curl -L https://github.com/haiderfxbot-ai/rha-fxcode/releases/download/v1.0.1/rha-fxcode-linux-arm64 -o rha-fxcode
chmod +x rha-fxcode

# Step 7: Install globally
echo "[07] Installing globally..."
mkdir -p ~/.local/bin
cp rha-fxcode ~/.local/bin/rha-fxcode
chmod +x ~/.local/bin/rha-fxcode

# Step 8: Setup PATH
echo "[08] Setting up PATH..."
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# Step 9: Create config
echo "[09] Creating config..."
mkdir -p ~/.rha-fxcode/commands
cat > ~/.rha-fxcode/.rha-fxcode.json << 'CONFIG'
{
  "provider": {
    "name": "groq",
    "model": "llama-3.3-70b-versatile"
  },
  "tui": {
    "theme": "rha-fxcode"
  }
}
CONFIG

# Step 10: Set API Key
echo "[10] API Key setup..."
echo "Get FREE Groq API Key at: https://console.groq.com/keys"
echo -n "Enter your Groq API Key: "
read -r GROQ_KEY
echo "export GROQ_API_KEY=\"$GROQ_KEY\"" >> ~/.bashrc

echo ""
echo "=========================================="
echo "  INSTALLATION COMPLETE!"
echo "=========================================="
echo ""
echo "To run RHA FX CODE:"
echo "  source ~/.bashrc"
echo "  rha-fxcode"
echo ""
