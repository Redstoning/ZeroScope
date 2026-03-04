#!/usr/bin/env bash
set -euo pipefail

echo "[*] ZeroScope installer (Arch/BlackArch)"

if ! command -v pacman >/dev/null 2>&1; then
  echo "[!] This installer is intended for Arch/BlackArch (pacman not found)."
  echo "    Install dependencies manually or adapt this script."
  exit 1
fi

echo "[*] Updating system packages..."
sudo pacman -Syu --noconfirm

echo "[*] Installing base dependencies..."
sudo pacman -S --noconfirm \
  base-devel git go \
  nmap jq curl unzip \
  inetutils dnsutils ripgrep

echo "[*] Installing ffuf..."
if command -v ffuf >/dev/null 2>&1; then
  echo "[*] ffuf already installed"
else
  if command -v yay >/dev/null 2>&1; then
    yay -S --noconfirm ffuf || true
  else
    echo "[!] yay not found. Attempting pacman install for ffuf..."
    sudo pacman -S --noconfirm ffuf || true
    if ! command -v ffuf >/dev/null 2>&1; then
      echo "[!] ffuf not installed. Install it via AUR (yay) or your repo packaging."
    fi
  fi
fi

echo "[*] Installing Go-based recon tools..."
export GOBIN="$HOME/go/bin"
export PATH="$HOME/go/bin:$PATH"
mkdir -p "$HOME/go/bin"

go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/waybackurls@latest

echo "[*] Installing ZeroScope into ~/.local/bin ..."
mkdir -p "$HOME/.local/bin"
cp -f ./zeroscope "$HOME/.local/bin/zeroscope"
chmod +x "$HOME/.local/bin/zeroscope"

echo "[*] Ensuring PATH includes ~/.local/bin and ~/go/bin ..."
if [[ -f "$HOME/.zshrc" ]]; then
  grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
  grep -q 'export PATH="$HOME/go/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null || echo 'export PATH="$HOME/go/bin:$PATH"' >> "$HOME/.zshrc"
fi

if [[ -f "$HOME/.bashrc" ]]; then
  grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
  grep -q 'export PATH="$HOME/go/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null || echo 'export PATH="$HOME/go/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo
echo "[+] Install complete."
echo "    Restart your shell or run:"
echo '    export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"'
echo
echo "    Then run:"
echo "    zeroscope"