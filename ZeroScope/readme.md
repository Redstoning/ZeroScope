# ZeroScope

Bash-only bug bounty recon + triage tool (authorized scope only).

## Install (Arch/BlackArch)
chmod +x install.sh zeroscope
./install.sh
restart shell

## Run
zeroscope --scope scope.txt --out out --ack I_HAVE_AUTHORIZATION

## Resume
zeroscope --scope scope.txt --out out --resume --ack I_HAVE_AUTHORIZATION