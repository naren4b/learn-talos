# Phase 0 Setup Specification

## 1. Administrator Workstation: Ubuntu on WSL

Use **Ubuntu on WSL 2** as the command-line administration environment.
Keep the PoC repository inside the WSL Linux filesystem, for example
`~/work/track-2-poc`, rather than under `/mnt/c`, for predictable Linux
permissions and better filesystem performance.

VirtualBox remains installed and operated on the Windows host. WSL runs
the administration binaries; it does not host `EDGE-001`.

Minimum host capacity:

| Resource | Minimum | Preferred |
| --- | ---: | ---: |
| CPU | 4 logical CPUs with virtualization enabled | 8 logical CPUs |
| RAM | 8 GiB | 16 GiB or more |
| Free disk | 50 GiB | 100 GiB |
| Network | Stable Internet access | Wired or reliable broadband |

Required binaries:

| Binary | Baseline | Purpose |
| --- | --- | --- |
| Oracle VirtualBox on Windows | 7.2.x base package | Runs `EDGE-001`; Extension Pack is not required. |
| Terraform CLI in WSL | `>= 1.10, < 2.0`; verified with 1.16.3 | Provisions Phase 0 AWS resources. |
| AWS CLI in WSL | v2; verified with 2.36.49 | Uses the `personal` profile and validates AWS access. |
| Git in WSL | Current supported release | Stores reproducible PoC configuration. |
| OpenSSH client in WSL | Ubuntu package | EC2 administration. |
| `talosctl` in WSL | 1.13.4 | Talos API client for Phase 1; match the Talos version. |
| Talos ISO | 1.13.4 `metal-amd64.iso` | Boots `EDGE-001` in Phase 1. |
| `kubectl` | Version compatible with the later Kubernetes version | Phase 1 cluster verification; not used in Phase 0. |

Install the WSL-side tools:

```bash
chmod +x setup-wsl.sh
./setup-wsl.sh
```

Verification from Ubuntu WSL:

```bash
terraform version
aws --version
git --version
ssh -V
talosctl version --client
```

Verify VirtualBox separately from Windows PowerShell:

```powershell
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" --version
```

Configure and validate the named AWS profile:

```bash
aws configure --profile personal
aws sts get-caller-identity --profile personal
```

Never commit AWS credentials, Terraform state, SSH private keys,
`talosconfig`, kubeconfig or generated private keys.

## 2. AWS Control Host

| Item | Specification |
| --- | --- |
| OS | Ubuntu Server 24.04 LTS amd64, resolved through Canonical's public SSM parameter |
| Instance | `t3.medium`: 2 vCPU, 4 GiB RAM |
| Disk | 60 GiB encrypted gp3 |
| Network | Dedicated `10.20.0.0/16` VPC and `10.20.10.0/24` public subnet |
| Stable endpoint | Elastic IP; add DNS after the endpoint is verified |
| Inbound | TCP 22 from administrator `/32`; TCP 443 from configured edge CIDRs |
| Administration | SSH plus AWS Systems Manager Session Manager |
| IMDS | IMDSv2 required; hop limit 1 |
| Detailed monitoring | Enabled |

Installed automatically:

- Docker Engine from Ubuntu (`docker.io`)
- Git
- `curl`, `jq`, `openssl`, `unzip`, CA certificates
- Amazon SSM Agent supplied by the Ubuntu AWS image

The HTTPS reverse proxy is deliberately not installed by Terraform. It
will be introduced and verified separately in Step 0.5.

### Terraform execution

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit admin_cidr and, if needed, region/key path.

terraform fmt -check
terraform init
terraform validate
terraform plan -out phase0.tfplan
terraform apply phase0.tfplan
```

Before applying, confirm the plan creates only the dedicated VPC,
networking, EC2/EIP, security group, key pair and SSM role/profile.

## 3. VirtualBox EDGE-001

| Item | Specification |
| --- | --- |
| VM name | `EDGE-001` |
| Guest | Other Linux (64-bit) |
| CPU | 2 vCPU |
| RAM | 4096 MiB |
| Disk | 32 GiB VDI, dynamically allocated |
| Firmware | EFI enabled |
| NIC 1 | NAT |
| Port forwarding | None |
| Additional NICs | None during Phase 0 |
| Optical media | Talos 1.13.4 `metal-amd64.iso`, attached in Phase 1 |
| SSH | Not installed or exposed |
| Management | Talos API in Phase 1 |

Do not enable bridged networking. VirtualBox NAT allows outbound access
while preventing AWS from routing directly to the EDGE private address.

Create and operate the VM through the VirtualBox Windows GUI for the
first learning cycle. WSL can later call Windows `VBoxManage.exe` if we
decide to automate VM creation, but that is not required for Phase 0.

## 4. Phase 0 Boundaries

- Do not configure Talos trust, PKI or machine configuration yet.
- Do not install Omni or another paid fleet-management platform.
- Do not expose Docker, SSM, databases or CA administration endpoints.
- Do not add inbound ports merely for troubleshooting.
- Record evidence only after each validation succeeds.
