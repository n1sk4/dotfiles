#!/bin/bash

# =============================================================================
#  n1sk4/dotfiles - install.sh
#  Automates the full terminal setup for Debian WSL2
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log()    { echo -e "${CYAN}==>${NC} $1"; }
success(){ echo -e "${GREEN}✔${NC} $1"; }
warn()   { echo -e "${YELLOW}⚠${NC} $1"; }
error()  { echo -e "${RED}✘${NC} $1"; exit 1; }

echo ""
echo -e "${CYAN}"
echo "  ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗"
echo "  ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝"
echo "  ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗"
echo "  ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║"
echo "  ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║"
echo "  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝"
echo -e "${NC}"
echo -e "  ${CYAN}n1sk4/dotfiles${NC} — automated setup for Debian WSL2"
echo ""

# -----------------------------------------------------------------------------
# 1. APT update
# -----------------------------------------------------------------------------
log "Updating apt packages..."
sudo apt update -y && sudo apt upgrade -y
success "APT updated"

# -----------------------------------------------------------------------------
# 2. Install Homebrew
# -----------------------------------------------------------------------------
if ! command -v brew &>/dev/null; then
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    success "Homebrew installed"
else
    success "Homebrew already installed"
fi

# -----------------------------------------------------------------------------
# 3. Install Brew packages from Brewfile
# -----------------------------------------------------------------------------
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    log "Installing Brew packages..."
    brew bundle install --file="$DOTFILES_DIR/Brewfile"
    success "Brew packages installed"
else
    warn "No Brewfile found, skipping"
fi

# -----------------------------------------------------------------------------
# 4. Install APT packages
# -----------------------------------------------------------------------------
if [ -f "$DOTFILES_DIR/packages-apt.txt" ]; then
    log "Installing APT packages..."
    sudo dpkg --set-selections < "$DOTFILES_DIR/packages-apt.txt"
    sudo apt-get dselect-upgrade -y
    success "APT packages installed"
else
    warn "No packages-apt.txt found, skipping"
fi

# -----------------------------------------------------------------------------
# 5. Install Fastfetch
# -----------------------------------------------------------------------------
if ! command -v fastfetch &>/dev/null; then
    log "Installing Fastfetch..."
    wget -q https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb -O /tmp/fastfetch.deb
    sudo apt install -y /tmp/fastfetch.deb
    rm /tmp/fastfetch.deb
    success "Fastfetch installed"
else
    success "Fastfetch already installed"
fi

# -----------------------------------------------------------------------------
# 6. Install Rust & Starship
# -----------------------------------------------------------------------------
if ! command -v cargo &>/dev/null; then
    log "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    success "Rust installed"
else
    success "Rust already installed"
fi

if ! command -v starship &>/dev/null; then
    log "Installing Starship..."
    cargo install starship
    success "Starship installed"
else
    success "Starship already installed"
fi

# -----------------------------------------------------------------------------
# 7. Copy configs
# -----------------------------------------------------------------------------
log "Copying config files..."

cp "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
success ".bashrc copied"

mkdir -p "$HOME/.config"

if [ -f "$DOTFILES_DIR/starship.toml" ]; then
    cp "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
    success "starship.toml copied"
fi

if [ -d "$DOTFILES_DIR/fastfetch" ]; then
    cp -r "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch"
    success "fastfetch config copied"
fi

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo ""
echo -e "${GREEN}✔ All done! Open a new terminal to see your setup.${NC}"
echo ""
echo -e "${YELLOW}⚠ Don't forget to install JetBrainsMono Nerd Font on Windows:${NC}"
echo "  https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
echo "  Then set it in Windows Terminal → your Debian profile → Appearance → Font face"
echo ""