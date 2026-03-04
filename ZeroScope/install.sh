#!/usr/bin/env bash
set -euo pipefail

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm base-devel git go nmap jq curl unzip inetutils dnsutils ripgrep

if ! command -v ffuf >/dev/null 2>&1; then
  if command -v yay >/dev/null 2>&1; then
    yay -S --noconfirm ffuf || true
  fi
fi

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

mkdir -p "$HOME/.local/bin"
cp -f ./zeroscope "$HOME/.local/bin/zeroscope"
chmod +x "$HOME/.local/bin/zeroscope"

grep -q 'export PATH="\$HOME/.local/bin:\$PATH"' "$HOME/.zshrc" 2>/dev/null || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
grep -q 'export PATH="\$HOME/go/bin:\$PATH"' "$HOME/.zshrc" 2>/dev/null || echo 'export PATH="$HOME/go/bin:$PATH"' >> "$HOME/.zshrc"

echo "Installed. Restart your shell, then run: zeroscope -h"