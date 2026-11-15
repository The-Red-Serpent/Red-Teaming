#!/usr/bin/env bash

set -e

if [[ $EUID -eq 0 ]]; then
    echo "Run as normal user, not root."
    exit 1
fi

# ==========================================
# KALI BLUEPRINT - INSTALLER
# ==========================================

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$REPO_DIR/.config"
CONFIG_HOME="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
LOG_DIR="$HOME/.local/state/kali-blueprint"
LOG_FILE="$LOG_DIR/install.log"

mkdir -p "$LOG_DIR"
exec > >(tee -a "$LOG_FILE") 2>&1

info() { echo -e "\n[+] $*"; }
ok()   { echo "[OK] $*"; }
warn() { echo "[!] $*"; }

trap 'echo "[ERROR] Failed at line $LINENO. Check $LOG_FILE"' ERR
# ==========================================
# COPY GITHUB CONFIGURATIONS
# ==========================================

info "Copying repository configurations..."

mkdir -p "$CONFIG_HOME"

for directory in i3 kitty picom polybar ranger rofi; do

    SOURCE="$CONFIG_DIR/$directory"
    TARGET="$CONFIG_HOME/$directory"

    if [[ ! -d "$SOURCE" ]]; then
        warn "Missing configuration: $directory"
        continue
    fi

    if [[ -d "$TARGET" ]]; then
        mkdir -p "$BACKUP_DIR"
        cp -a "$TARGET" "$BACKUP_DIR/"
        rm -rf "$TARGET"
    fi

    cp -a "$SOURCE" "$TARGET"

    ok "Copied $directory"
done

echo "[+] Updating Kali..."
sudo apt update

echo "[+] Upgrading  Kali..."
sudo apt full-upgrade


echo "[+] Installing dependencies and utilities..."
sudo apt install -y \
    git curl wget unzip zip \
    build-essential cmake \
    python3 python3-pip python3-venv pipx \
    nodejs npm cargo rustc golang-go \
    docker.io docker-compose \
    zsh tmux jq btop fastfetch lsd  ranger fontconfig \
    kate rofi  ripgrep tree seclists kali-desktop-i3 assetfinder

echo "[+] Configuring Docker..."
sudo systemctl enable --now docker

echo "[+] Configuring PATH..."
mkdir -p ~/.local/bin ~/.cargo/bin ~/go/bin

for rc in ~/.bashrc ~/.zshrc; do
    grep -q 'export PATH="$HOME/go/bin' "$rc" 2>/dev/null || \
    echo 'export PATH="$HOME/go/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"' >> "$rc"
done

echo "[+] Installing JetBrainsMono Nerd Font..."
mkdir -p ~/.local/share/fonts/JetBrainsMonoNerd
curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip \
    -o /tmp/JetBrainsMono.zip
unzip -oq /tmp/JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNerd
rm /tmp/JetBrainsMono.zip
fc-cache -f




echo "[+] Installing Cloud Tools..."
sudo apt install -y cloud-enum cloudbrute azurehound s3scanner

echo "[+] Installing Pivoting Tools..."
sudo apt install -y ligolo-ng ligolo-mp sshuttle penelope pwncat

echo "[+] Installing Active Directoty Tools..."
sudo apt install -y bloodhound bloodhound-ce-python ldeep bloodyad snaffler-ng python3-ldapdomaindump
cargo install rusthound-ce
cargo install rusthound
pipx install smbclientng

echo "[+] Installing Recon Tools......"
sudo apt install -y subfinder sublist3r theharvester trufflehog httpx-toolkit gowitness
go install github.com/projectdiscovery/alterx/cmd/alterx@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install github.com/bp0lr/gauplus@latest
go install github.com/Josue87/gotator@latest
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
go install -v github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest
go install github.com/projectdiscovery/tlsx/cmd/tlsx@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install github.com/lc/subjs@latest
go install github.com/BishopFox/jsluice/cmd/jsluice@latest
pipx install git+https://github.com/xnl-h4ck3r/waymore.git




echo
echo "[+] Installation complete!"
echo "[+] Restart your terminal."

