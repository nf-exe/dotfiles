#!/bin/bash

echo "🔧 NF's Archcraft Setup Script"
echo "================================"

# Add BlackArch repo
echo "[+] Adding BlackArch repo..."
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh
rm strap.sh

# Fix mirrors
echo "[+] Fixing mirrorlist..."
sudo bash -c 'cat > /etc/pacman.d/mirrorlist << EOF
Server = https://mirror.pkgbuild.com/\$repo/os/\$arch
Server = https://mirrors.kernel.org/archlinux/\$repo/os/\$arch
Server = https://geo.mirror.pkgbuild.com/\$repo/os/\$arch
EOF'
sudo pacman -Syy

# Terminal & Shell
echo "[+] Installing terminal and shell tools..."
sudo pacman -S --needed kitty yazi stow zoxide fzf bat eza btop fastfetch

# Dev tools
echo "[+] Installing dev tools..."
sudo pacman -S --needed git nodejs npm python python-pip gcc gdb

# Cybersec tools
echo "[+] Installing cybersec tools..."
sudo pacman -S --needed nmap sqlmap burpsuite gobuster ffuf john hashcat wireshark-qt gdb ghidra radare2 theharvester tcpdump

# Add user to wireshark group
echo "[+] Adding user to wireshark group..."
sudo usermod -aG wireshark $USER

# Stow dotfiles
echo "[+] Stowing dotfiles..."
cd ~/dotfiles
stow openbox kitty picom rofi dunst gtk nitrogen neofetch ranger zsh

# Apps
sudo pacman -S --needed ferdium-bin visual-studio-code-bin pix

echo "✅ Done! Please log out and back in for group changes to take effect."
