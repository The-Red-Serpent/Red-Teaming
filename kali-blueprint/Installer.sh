
#!/usr/bin/env bash

set -Eeuo pipefail

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
# SYSTEM CHECKS
# ==========================================

if [[ $EUID -eq 0 ]]; then
    echo "Do not run this script as root."
    exit 1
fi

if ! command -v apt-get >/dev/null 2>&1; then
    echo "Kali/Debian with APT is required."
    exit 1
fi

if [[ ! -d "$CONFIG_DIR" ]]; then
    echo "Repository .config directory not found!"
    exit 1
fi

sudo -v

# ==========================================
# UPDATE SYSTEM
# ==========================================

info "Updating package lists..."
sudo apt-get update

# ==========================================
# APT INSTALLATION
# ==========================================

install_packages() {
    local available=()
    local package

    for package in "$@"; do
        if apt-cache show "$package" >/dev/null 2>&1; then
            available+=("$package")
        else
            warn "Package unavailable: $package"
        fi
    done

    if ((${#available[@]})); then
        sudo apt-get install -y --no-install-recommends "${available[@]}"
    fi
}

info "Installing desktop environment..."

install_packages \
    kali-desktop-i3 \
    polybar \
    kate  \
     arandr \
    xclip \
    dbus-x11 \
    fonts-jetbrains-mono \

info "Installing development tools..."

install_packages \
    git curl wget \
    unzip zip p7zip-full \
    build-essential cmake \
    pkg-config libssl-dev \
    ca-certificates \
    python3 python3-pip python3-venv pipx \
    nodejs npm \
    cargo rustc \
    golang-go \
    docker.io docker-compose

info "Installing terminal utilities..."

install_packages \
    zsh tmux neovim \
    jq btop fastfetch \
    lsd tldr \
    fzf ripgrep fd-find \
    tree htop

# ==========================================
# DOCKER
# ==========================================

info "Configuring Docker..."

if command -v docker >/dev/null 2>&1; then
    sudo systemctl enable docker || warn "Could not enable Docker."
    sudo systemctl start docker || warn "Could not start Docker."
fi

# ==========================================
# PIPX
# ==========================================

info "Configuring pipx..."

if command -v pipx >/dev/null 2>&1; then
    pipx ensurepath || true
fi


# ==========================================
# OH MY ZSH
# ==========================================

info "Installing Oh My Zsh..."

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
        || warn "Oh My Zsh installation failed."
fi

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

# ==========================================
# SCRIPT PERMISSIONS
# ==========================================

info "Setting script permissions..."

for directory in polybar rofi; do
    if [[ -d "$CONFIG_HOME/$directory" ]]; then
        find "$CONFIG_HOME/$directory" \
            -maxdepth 1 -type f -name "*.sh" \
            -exec chmod +x {} \;
    fi
done

# ==========================================
# VERIFICATION
# ==========================================

info "Verifying installations..."

COMMANDS=(
    git curl wget
    python3 pipx
    node npm cargo rustc
    docker
    i3 kitty picom polybar rofi
    kate ranger
    zsh tmux nvim
    jq btop fastfetch
)

FAILED=()

for cmd in "${COMMANDS[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        ok "$cmd"
    else
        warn "Missing: $cmd"
        FAILED+=("$cmd")
    fi
done

# ==========================================
# COMPLETION
# ==========================================

echo
echo "======================================"
echo "       KALI BLUEPRINT INSTALLED"
echo "======================================"

echo "Repository : $REPO_DIR"
echo "Configs    : $CONFIG_HOME"
echo "Log        : $LOG_FILE"

if [[ -d "$BACKUP_DIR" ]]; then
    echo "Backup     : $BACKUP_DIR"
fi

if ((${#FAILED[@]})); then
    echo
    echo "Missing commands:"
    printf ' - %s\n' "${FAILED[@]}"
fi

echo
echo "Installation complete!"
echo "Restart i3 to apply configurations."
echo "======================================"
