# Configuration and API Authentication

**Status: Draft, not approved by the learner. Pending discussion.**

Parent: [Detailed notes](README.md). Previous: [Combined boot comparison](01-general-linux-boot.md). Next: [Security and recovery](04-security-break-glass-and-lost-keys.md).

## Common boot foundations

Both systems initialize hardware, start a loader and Linux kernel, use initramfs for early startup, discover devices and start services. Installation prepares persistent storage; subsequent boots reuse that installation. Both need trustworthy artifacts and protected administrative access.

## What differs

| Area | Typical general Linux | Talos in this sequence |
| --- | --- | --- |
| Initial setup | Installer prompts or unattended answer file | Declarative machine configuration through an API |
| OS service management | Commonly systemd and distribution tooling | Talos machined and purpose-built controllers |
| Administration | Local login, SSH or automation as configured | talosctl against the Talos API |
| Intended workload | General applications; Kubernetes optional | Kubernetes-focused operating system |
| Desired settings | Often spread across packages and files | Machine configuration drives supported settings |
| Cluster creation | Separate Kubernetes setup | Talos configures components; bootstrap initializes etcd |
| Trust | Varies by service and distribution | Talos API client certificates and API roles |

Talos API and Kubernetes API are separate. A Kubernetes permission does not automatically grant Talos OS administration. Talos security also does not establish application security.

Sources: [Components](https://docs.siderolabs.com/talos/v1.14/learn-more/components), [Talos RBAC](https://docs.siderolabs.com/talos/v1.14/security/rbac).

## Step 5: Obtain network settings

**One line:** Talos typically requests an IP address, gateway and DNS settings from DHCP so the administrator can reach its API and the node can reach required image services.

DHCP is a network service, often provided by a router or factory server. Talos brings up a supported network interface and requests settings. An address identifies the node on its network; a gateway reaches other networks; DNS resolves registry names. Communication on the same subnet does not inherently require a gateway. DHCP does not prove the device identity or authorize provisioning.

General Linux has the same network-configuration need, usually handled during its installer or normal boot. It was omitted from the earlier simplified diagram and is now shown. A general Linux installer with all packages locally available can work offline. Our Talos example uses remote API configuration and a registry, so it requires the appropriate network reachability. Air-gapped Talos uses reachable local services, not necessarily the Internet. Static or platform-provided boot networking is an alternative when DHCP is unavailable; its exact setup belongs to the lab.

## Step 11: Which configuration?

It is the node's **machine configuration**, conventionally named controlplane.yaml. It describes the intended role, installation and cluster settings. It is not the workstation's talosconfig file.

| Configuration input | Why Talos needs it |
| --- | --- |
| Control-plane role | Select the services this node must run |
| Installation disk and installer image | Select where and what to install |
| Network settings | Establish node and cluster communication |
| Kubernetes endpoint | Identify the cluster API address |
| Talos and Kubernetes trust material | Establish separate administrative and cluster trust |
| Cluster credentials and settings | Configure cooperating Kubernetes components |
| Workload scheduling on control plane | Permit applications on the only node |

A generic ISO cannot know your target disk, cluster identity or desired network. Generated control-plane configuration can contain CA private keys and other credentials. Treat the complete file as a secret, even though some individual settings are public.

For the v1.14 configuration described by the current guide, remove the control-plane NoSchedule taint through KubeNodeConfig. Earlier releases used allowSchedulingOnControlPlanes. Generate configuration for the chosen version rather than mixing schemas.

Source: [Workloads on control planes](https://docs.siderolabs.com/talos/v1.14/deploy-and-manage-workloads/workloads-on-controlplane).

## Step 11: Behind the scenes

1. talosctl submits configuration to the node API.
2. Talos parses and validates it; invalid input can be rejected.
3. On this blank-disk installation path, Talos uses the specified installer and disk.
4. Configuration is persisted for later boots.
5. Talos controllers reconcile supported networking and service settings.
6. Configured trust enables authenticated management; Kubernetes initialization still needs its one-time bootstrap.

Applying configuration is not executing an arbitrary shell script. It expresses desired state. On an already installed node, applying a change does not always reinstall or reboot it: behavior depends on the fields and apply mode. Do not infer installation behavior from every future apply-config call.

Source: [Getting started](https://docs.siderolabs.com/talos/v1.14/getting-started/getting-started).

## Step 21: What changed?

| Property | Unconfigured maintenance mode | Configured Talos API |
| --- | --- | --- |
| Known cluster trust | Not yet established by machine config | Established by applied configuration |
| Caller identity | Maintenance requests lack cluster client authentication | Client certificate and proof of private-key possession |
| Transport | TLS does not by itself establish trusted ownership | Mutual TLS validates both peers |
| Server verification | Ordinary --insecure setup does not perform normal CA validation | talosctl validates server certificate using configured CA trust |
| Permissions | Limited maintenance operations, including initial configuration | API methods restricted by certificate roles |
| Client material | No working cluster talosconfig required | Matching CA trust, client certificate and private key |

Maintenance mode is not unrestricted access to everything. It does not imply arbitrary TPM commands, a shell, or a bypass into an already configured node. The --insecure option cannot disable authentication on the normal configured API.

Source: [Getting started](https://docs.siderolabs.com/talos/v1.14/getting-started/getting-started).

## What talosconfig contains

| Field | Role |
| --- | --- |
| ca | Public CA certificate used to verify the Talos server |
| crt | Client certificate identifying the caller and its roles |
| key | Client private key used to prove possession |
| endpoints | Addresses the workstation contacts |

The CA certificate is public trust material, not the CA signing key. Base64 encoding is not encryption. talosconfig is sensitive because it includes the client private key.

During mutual TLS, the server and client present certificates and demonstrate possession of their corresponding private keys. The private keys are not transmitted. The node then authorizes the requested API operation. A valid certificate with a reader role cannot perform an admin-only operation.

Sources: [talosconfig reference](https://docs.siderolabs.com/talos/v1.14/reference/talosconfig), [RBAC](https://docs.siderolabs.com/talos/v1.14/security/rbac).

## Which CA are we discussing?

Step 21 uses the cluster's **Talos API CA**. It is distinct from the Kubernetes CA, NEN device-identity CA, UEFI boot-signing trust and any disk-encryption key. Merely creating the NEN Root CA in our earlier lab does not configure Talos API authentication.

Read one topic at a time: first understand controlplane.yaml versus talosconfig, then the maintenance-to-authenticated transition, then recovery.
