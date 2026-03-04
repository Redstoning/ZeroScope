# ZeroScope

Bash-only bug bounty recon + triage tool (authorized scope only).



---

## What it does

ZeroScope chains common recon utilities into a single workflow:

- Subdomain enumeration (subfinder)
- DNS resolution (dnsx)
- HTTP probing + tech detection (httpx)
- URL harvesting (gau + waybackurls)
- Crawling (katana)
- Parameter URL extraction (ripgrep)
- Content discovery (ffuf)
- Template-based findings (nuclei)
- Quick service/port awareness (nmap)
- Ranking + Markdown reporting (jq + awk)

---

## Install (Arch / BlackArch)

### Recommended install

```bash
git clone https://github.com/redstoning/zeroscope.git
cd zeroscope
chmod +x install.sh zeroscope
./install.sh
