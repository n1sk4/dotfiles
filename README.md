<div align="center">

<img width="927" height="433" alt="terminal preview" src="https://github.com/user-attachments/assets/5f89192d-8f83-49b5-a459-d725fb9130bd" />

# 🐧 dotfiles

![OS](https://img.shields.io/badge/OS-Debian%2012%20Bookworm-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![WSL](https://img.shields.io/badge/WSL2-Windows%20Subsystem%20for%20Linux-0078D4?style=for-the-badge&logo=windows&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Starship](https://img.shields.io/badge/Prompt-Starship-DD0B78?style=for-the-badge&logo=starship&logoColor=white)
![Terminal](https://img.shields.io/badge/Terminal-Windows%20Terminal-4D4D4D?style=for-the-badge&logo=windowsterminal&logoColor=white)

My personal terminal setup for WSL2 on Windows, featuring a custom prompt, system info fetch, and a clean minimal aesthetic.

</div>

---

## ✨ What's Included

| Tool | Purpose |
|---|---|
| [Starship](https://starship.rs) | Cross-shell prompt |
| [Fastfetch](https://github.com/fastfetch-cli/fastfetch) | System info display with small Tux penguin logo |
| [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) | Font with full icon support |
| [Homebrew](https://brew.sh) | Package manager for Linux |
| [Rust / Cargo](https://rustup.rs) | Rust toolchain |

---

## 📋 Requirements

- Windows 10/11 with WSL2 enabled
- [Windows Terminal](https://aka.ms/terminal)
- Debian GNU/Linux 12.9 (bookworm) or later
- Internet connection for package downloads

---

## 📁 Scripts

| Script | Purpose |
|---|---|
| `install.sh` | Installs all tools and copies configs on a new machine |
| `export.sh` | Collects all dotfiles and pushes to GitHub |

Make them executable:
```bash
chmod +x ~/dotfiles/install.sh
chmod +x ~/dotfiles/export.sh
```

---

## 🚀 Installation

### 1. Clone dotfiles
```bash
git clone https://github.com/n1sk4/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Run install script
```bash
./install.sh
```

### 3. Install Nerd Font (Windows side)
Download and install **JetBrainsMono Nerd Font** on Windows:
```
https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
```
Extract the zip, select all `.ttf` files → right click → **Install**.

Then set it in Windows Terminal:
- `Ctrl+,` → your Debian profile → Appearance → Font face → `JetBrainsMono Nerd Font`

---

## 🔄 Updating Dotfiles

Whenever you make changes to your setup, run:
```bash
~/dotfiles/export.sh
```

This will automatically collect all configs, package lists and push to GitHub.

---

## 🖥️ System Info

```
OS:     Debian GNU/Linux 12.9 (bookworm) x86_64
Host:   Windows Subsystem for Linux - Debian (2.6.3.0)
Kernel: Linux 6.6.87.2-microsoft-standard-WSL2
Shell:  bash 5.2.15
Term:   Windows Terminal
```

---

<div align="center">

Made with ❤️ by [n1sk4](https://github.com/n1sk4)

</div>