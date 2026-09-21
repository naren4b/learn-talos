#!/usr/bin/env bash
set -euo pipefail

TALOS_VERSION="v1.13.4"

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg git jq openssh-client unzip

# HashiCorp Terraform repository.
curl -fsSL https://apt.releases.hashicorp.com/gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(. /etc/os-release && echo "$VERSION_CODENAME") main" \
  | sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null
sudo apt-get update
sudo apt-get install -y terraform

# AWS CLI v2 for Linux x86_64.
work_dir="$(mktemp -d)"
trap 'rm -rf "$work_dir"' EXIT
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
  -o "$work_dir/awscliv2.zip"
unzip -q "$work_dir/awscliv2.zip" -d "$work_dir"
sudo "$work_dir/aws/install" --update

# talosctl must match the Talos Linux version used by EDGE-001.
curl -fsSL \
  "https://github.com/siderolabs/talos/releases/download/${TALOS_VERSION}/talosctl-linux-amd64" \
  -o "$work_dir/talosctl"
sudo install -m 0755 "$work_dir/talosctl" /usr/local/bin/talosctl

echo
echo "Installed versions:"
terraform version
aws --version
git --version
ssh -V
talosctl version --client
