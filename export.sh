#!/bin/bash

# =============================================================================
#  n1sk4/dotfiles - export.sh
#  Collects all dotfiles and package lists into the dotfiles repo
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()    { echo -e "${CYAN}==>${NC} $1"; }
success(){ echo -e "${GREEN}✔${NC} $1"; }
warn()   { echo -e "${YELLOW}⚠${NC} $1"; }

echo ""
echo -e "${CYAN}  Exporting dotfiles to $DOTFILES_DIR${NC}"
echo ""

# -----------------------------------------------------------------------------
# 1. Shell config
# -----------------------------------------------------------------------------
log "Copying .bashrc..."
cp "$HOME/.bashrc" "$DOTFILES_DIR/.bashrc"
success ".bashrc exported"

# -----------------------------------------------------------------------------
# 2. Starship config
# -----------------------------------------------------------------------------
if [ -f "$HOME/.config/starship.toml" ]; then
    log "Copying starship.toml..."
    cp "$HOME/.config/starship.toml" "$DOTFILES_DIR/starship.toml"
    success "starship.toml exported"
else
    warn "No starship.toml found, skipping"
fi

# -----------------------------------------------------------------------------
# 3. Fastfetch config
# -----------------------------------------------------------------------------
if [ -d "$HOME/.config/fastfetch" ]; then
    log "Copying fastfetch config..."
    cp -r "$HOME/.config/fastfetch" "$DOTFILES_DIR/fastfetch"
    success "fastfetch config exported"
else
    warn "No fastfetch config found, skipping"
fi

# -----------------------------------------------------------------------------
# 4. APT packages
# -----------------------------------------------------------------------------
log "Exporting APT packages..."
dpkg --get-selections > "$DOTFILES_DIR/packages-apt.txt"
success "packages-apt.txt exported"

# -----------------------------------------------------------------------------
# 5. Homebrew packages
# -----------------------------------------------------------------------------
if command -v brew &>/dev/null; then
    log "Exporting Brewfile..."
    brew bundle dump --file="$DOTFILES_DIR/Brewfile" --force
    success "Brewfile exported"
else
    warn "Homebrew not found, skipping"
fi

# -----------------------------------------------------------------------------
# 6. Cargo packages
# -----------------------------------------------------------------------------
if command -v cargo &>/dev/null; then
    log "Exporting Cargo packages..."
    cargo install --list > "$DOTFILES_DIR/packages-cargo.txt"
    success "packages-cargo.txt exported"
else
    warn "Cargo not found, skipping"
fi