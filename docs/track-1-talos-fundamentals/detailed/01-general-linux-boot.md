# General Linux and Talos Boot Comparison

Parent: [Detailed notes](README.md).

The first boot can use USB or the network. Both examples start with a blank SSD and follow installation through the next boot from SSD.

| Scenario | Boot medium | Learning status |
| --- | --- | --- |
| 1.1 | USB | Round 1, current discussion |
| 1.2 | Network | Complete diagram draft for Round 2; learner review pending |
| 1.3 | Network boot across distant sites | Network layout and service roles; learner review pending |

Documents 03 and 04 remain unapproved drafts.

### Notes

**Bootloader**

A bootloader starts the operating system. After BIOS or UEFI initializes the hardware and selects a boot entry, the bootloader loads the Linux kernel into RAM and hands control to it. The boot files can come from USB, SSD or the network.

Its main jobs are:

- **Load the kernel:** Find the selected kernel and start it.
- **Offer a boot menu:** Let you choose an operating system or kernel version, when a menu is configured.
- **Pass kernel parameters:** Supply startup settings, such as the root filesystem location or recovery options supported by the OS.
- **Load initramfs:** Make the early userspace environment available to the kernel. It contains tools and drivers needed during startup, often including those required to find and mount the root filesystem.

Common Linux bootloaders include:

| Bootloader | Description |
| --- | --- |
| **GRUB 2** | Widely used by Linux distributions. Supports boot menus, multiple kernels and starting other operating systems. |
| **systemd-boot** | A small UEFI boot manager. It selects and starts EFI boot entries, including Unified Kernel Images (UKIs). |
| **Syslinux** | A family of bootloaders, including variants for removable media, optical media and PXE network boot. |
| **LILO** | An older Linux bootloader, mainly relevant to legacy systems. |

The usual sequence is:

1. **Power on:** BIOS or UEFI initializes hardware.
2. **Select a boot entry:** Firmware starts a loader from the chosen device or network service.
3. **Choose what to boot:** The loader reads its settings and may show a menu.
4. **Start the kernel:** The loader provides the kernel, initramfs and startup parameters, then hands over control.
5. **Continue startup:** The kernel initializes hardware and starts early userspace, which continues into the operating system.

For a new **Talos v1.14** installation, UEFI systems use **systemd-boot**, while legacy x86_64 BIOS systems use **GRUB**. An upgraded installation can retain its older bootloader.

On the UEFI path, Talos uses a **UKI**, which packages the kernel, initramfs and kernel command line in one EFI executable. A UKI can also be started directly by compatible firmware. The diagrams use “load boot components” as a short description of this process.

Sources: [GNU GRUB](https://www.gnu.org/software/grub/), [GRUB manual](https://www.gnu.org/software/grub/manual/grub/grub.html), [Talos boot loader](https://docs.siderolabs.com/talos/v1.14/platform-specific-installations/bare-metal-platforms/bootloader).

## Scenario 1.1: USB Boot

This example installs a typical Linux distribution from USB onto a blank SSD. Automated installers and other operating systems can differ. Firmware starts the loader; the loader starts the kernel. Secure Boot checks apply when enabled and correctly configured.

### General Linux Installation and Boot

```mermaid
sequenceDiagram
    autonumber
    participant OP as Operator
    participant FW as UEFI Firmware
    participant OS as Linux Environment
    participant SSD as Internal SSD
    Note over OP,SSD: First installation on blank hardware
    OP->>FW: Connect installer USB and power on
    FW->>FW: Initialize hardware
    FW->>OS: Start USB bootloader
    OS->>OS: Load kernel and initramfs
    OS->>OS: Configure network if needed using DHCP or static settings
    OS-->>OP: Show installation interface
    OP->>OS: Choose disk, network and user settings
    OS->>SSD: Install bootloader, kernel and root filesystem
    OS-->>OP: Installation complete
    OP->>FW: Remove USB and reboot
    Note over OP,SSD: Normal boot from SSD
    FW->>FW: Initialize hardware
    FW->>SSD: Read installed bootloader
    SSD-->>FW: Return bootloader
    FW->>OS: Start installed bootloader
    OS->>OS: Load kernel and initramfs
    OS->>SSD: Mount installed root filesystem
    OS->>OS: Start init system and configured services
    OS-->>OP: Login prompt or desktop ready
```

The OS becomes usable without Kubernetes. Kubernetes installation is a separate task in this comparison. Login and SSH availability depend on the distribution and selected services.

Networking supplies an IP address and, as configured, a gateway and DNS. A typical installer uses DHCP or accepts static settings. It matters for downloads and remote access; offline installation from complete local media can proceed without it.

### Talos Single-Node Setup

Here, Talos boots from USB and installs onto a blank SSD. The machine can reach the image registry, and its single control-plane node also runs workloads.

### Talos Installation and Cluster Bootstrap

```mermaid
sequenceDiagram
    participant A as Admin
    participant H as Hardware
    participant T as Talos
    participant D as SSD
    participant R as Registry
    Note over A,R: First installation
    A->>H: 1. Connect Talos USB and Ethernet
    A->>H: 2. Power on
    H->>H: 3. UEFI initializes hardware
    H->>T: 4. Boot Talos from USB
    T->>T: 5. Obtain network settings through DHCP
    T->>T: 6. Enter maintenance mode
    T-->>A: 7. Expose maintenance API
    A->>T: 8. Inspect hardware and disks
    A->>A: 9. Generate secrets and machine configuration
    A->>A: 10. Allow workloads on the control plane
    A->>T: 11. Apply control plane configuration
    T->>R: 12. Fetch Talos installer image
    R-->>T: 13. Return installer image
    T->>D: 14. Install Talos and save configuration
    Note over A,R: Boot installed Talos
    A->>H: 15. Ensure SSD is selected for reboot
    T->>H: 16. Reboot
    H->>D: 17. Load installed boot components
    D-->>H: 18. Return boot components
    H->>T: 19. Start installed Talos
    T->>D: 20. Read saved configuration
    T->>T: 21. Start authenticated Talos API
    Note over A,R: Create Kubernetes cluster once
    A->>T: 22. Run talosctl bootstrap
    T->>T: 23. Bootstrap etcd
    T->>R: 24. Fetch required Kubernetes images
    R-->>T: 25. Return images
    T->>T: 26. Bring up control plane and networking
    A->>T: 27. Retrieve kubeconfig
    A->>A: 28. Check node readiness using kubectl
    Note over A,R: Later boots reuse state without bootstrap
```

### Notes

- **Step 4:** UEFI starts the USB loader, which loads the kernel and initramfs. Talos initially runs in RAM.
- **Step 5:** DHCP supplies the node address and, when configured, gateway and DNS. General Linux also needs these for downloads and remote access.
- **Steps 6–8:** Without machine configuration, Talos exposes its maintenance API. Use `talosctl` to inspect the node and identify the target SSD. This replaces an interactive installation screen; Talos has no ordinary user login or SSH service.
- **Steps 9–11:** Generate cluster secrets and a control-plane machine configuration. It declares the node role, installation disk and installer image, Kubernetes endpoint, networking and cluster trust material. Applying it tells Talos what to install and which cluster to join; controllers use it to configure services and persist the node configuration. Keep the separate `talosconfig` client credentials on the administrator workstation.
- **Step 10:** Permit workloads on this single control-plane node. For v1.14, configure the control-plane scheduling taint through `KubeNodeConfig`; otherwise ordinary workloads can remain unscheduled.
- **Steps 12–14:** Talos downloads an installer container image, not another ISO. The installer writes boot assets and initializes the selected SSD; the node saves configuration for later boots. A general Linux installer usually installs packages and a conventional root filesystem.
- **Steps 15–20:** Set the disk boot order and remove or unmount installation media after the USB environment has booted, following the installation guide. Do this before applying configuration triggers installation and its automatic reboot. Step 15 is a boot requirement, not a last-second manual action. On SSD boot, the loader loads the kernel and initramfs, then Talos reads persisted configuration.
- **Step 21:** The configured API uses mutual TLS. The administrator verifies the server using the Talos CA; the node verifies the client's certificate and proof that it holds the matching private key, then checks its roles. Maintenance access did not require this configured client identity. Applying trusted configuration establishes this change; reboot itself does not create authentication. `--insecure` cannot bypass authentication on the configured API.
- **Steps 22–23:** Run `talosctl bootstrap` once to initialize etcd for this new cluster. Ordinary restarts reuse existing cluster state.
- **Steps 24–28:** Talos manages Kubernetes services. Fetch the required images, establish control-plane services and the selected CNI, retrieve `kubeconfig`, then check node and system-pod readiness. A general Linux installation finishes before any separate Kubernetes setup.

The numbered arrows show dependencies, not exact timing. Image downloads and service startup can overlap. Kubernetes readiness requires working container networking; one node provides no node-level availability redundancy.

Sources: [Talos getting started](https://docs.siderolabs.com/talos/v1.14/getting-started/getting-started), [workloads on control planes](https://docs.siderolabs.com/talos/v1.14/deploy-and-manage-workloads/workloads-on-controlplane).

## Scenario 1.2: Network Boot

For this example, the machine has a blank SSD, supports PXE and connects to the provisioning LAN. DHCP supplies boot information; a boot service supplies a compatible loader and OS boot assets. This example uses PXE/iPXE, not booting across a customer NAT.

“Provisioning Services” includes DHCP, boot files and machine configuration. These services can run on different servers. We will discuss Matchbox and Squid separately.

### General Linux Network Installation and SSD Boot

This is a typical distribution installer flow. Automated installation can replace the operator's selections.

```mermaid
sequenceDiagram
    autonumber
    participant A as Operator
    participant N as Machine
    participant P as Provisioning Services
    participant S as Installation Source
    participant D as SSD
    Note over A,D: Prepare before powering on the blank machine
    A->>P: Prepare DHCP and compatible network loader
    A->>P: Publish installer kernel and initramfs
    A->>S: Publish installation repository
    A->>N: Connect Ethernet and select network boot
    A->>N: Power on
    N->>N: Firmware initializes hardware
    N->>P: Firmware requests DHCP and boot location
    P-->>N: Address and boot server information
    N->>P: Fetch PXE or iPXE loader
    P-->>N: Return loader and boot instructions
    N->>P: Loader requests installer kernel and initramfs
    P-->>N: Return installer boot assets
    N->>N: Loader starts kernel and installer in RAM
    N->>P: Installer configures runtime network
    P-->>N: Return network settings
    N-->>A: Show installation interface
    A->>N: Choose disk and system settings
    N->>S: Request installation content
    S-->>N: Return packages and filesystem content
    N->>D: Install OS and SSD boot components
    N-->>A: Installation complete
    A->>N: Select SSD boot and reboot
    Note over A,D: Normal boot from SSD
    N->>N: Firmware initializes hardware
    N->>D: Read installed loader and boot assets
    D-->>N: Return boot assets
    N->>N: Loader starts kernel and initramfs
    N->>D: Mount installed root filesystem
    N->>N: Start init system and configured services
    N-->>A: Login prompt or desktop ready
```

### Talos Network Installation and Single-Node Kubernetes

In this example, `talos.config` tells Talos where to download its machine configuration. Before boot, prepare a node-specific control-plane configuration and protect its delivery. Without that parameter or another configuration source, Talos enters maintenance mode and the administrator can apply configuration through the API as in scenario 1.1.

```mermaid
sequenceDiagram
    autonumber
    participant A as Admin
    participant N as Machine and Talos
    participant P as Provisioning Services
    participant R as Registry
    participant D as SSD
    Note over A,D: Preparation before first boot
    A->>A: Generate cluster secrets and client credentials
    A->>A: Prepare single node control plane configuration
    A->>P: Publish protected node configuration
    A->>P: Prepare DHCP and compatible network loader
    A->>P: Publish Talos kernel and initramfs
    A->>P: Set boot parameters including configuration URL
    A->>N: Connect Ethernet and select network boot
    A->>N: Power on
    N->>N: Firmware initializes hardware
    N->>P: Firmware requests DHCP and boot location
    P-->>N: Address and boot server information
    N->>P: Fetch PXE or iPXE loader
    P-->>N: Return loader and boot instructions
    N->>P: Loader requests Talos kernel and initramfs
    P-->>N: Return Talos boot assets
    N->>N: Loader starts Talos kernel and initramfs in RAM
    N->>P: Talos configures runtime network
    P-->>N: Return network settings
    N->>P: Fetch machine configuration from configured URL
    P-->>N: Return node control plane configuration
    N->>N: Apply configuration and configured API trust
    N->>R: Fetch Talos installer container image
    R-->>N: Return installer image
    N->>D: Install Talos and persist configuration
    Note over A,D: SSD must take priority on next boot
    N->>N: Reboot with SSD boot priority
    N->>N: Firmware initializes hardware
    N->>D: Read installed loader and boot assets
    D-->>N: Return boot assets
    N->>N: Loader starts installed Talos
    N->>D: Read persisted configuration and state
    N->>N: Configure network and authenticated API
    A->>N: Run talosctl bootstrap once
    N->>N: Initialize etcd for new cluster
    N->>R: Fetch required Kubernetes images
    R-->>N: Return images
    N->>N: Start control plane and selected CNI
    A->>N: Retrieve kubeconfig using client credentials
    A->>A: Check node and system pod readiness
    Note over A,D: Later SSD boots reuse state without bootstrap
```

### Notes

- **Steps 1–6:** Unlike the interactive Linux example, Talos configuration and cluster trust are prepared before this automatic installation. Include the correct installation disk and single-node scheduling configuration. Publish matching architecture/version boot assets and installer image. Generic metal PXE also requires the documented kernel parameters, including `talos.platform=metal`, `slab_nomerge` and `pti=on`.
- **Steps 7–18:** Firmware gets network boot information before an OS exists. The loader downloads kernel and initramfs. Once started, the OS configures its own network; the firmware's DHCP exchange is not the running OS network configuration. USB supplies those initial boot assets locally instead.
- **Steps 19–21:** Talos retrieves and applies machine configuration rather than asking for installer-screen selections. The configuration supplies installation instructions, node role and cluster trust. No maintenance API exchange is needed in this selected automatic path. Configuration retrieval failure must be diagnosed; do not assume installation succeeded.
- **Steps 22–24:** Installation uses a Talos installer container image from the registry and saves configuration to SSD. PXE kernel and initramfs only start the RAM environment; downloading them does not install the SSD.
- **Steps 25–31:** Arrange disk-first boot before the automatic reboot. Firmware loads SSD boot assets; Talos restores persisted configuration and its authenticated API. Both operating systems can boot locally after installation without repeating PXE installation.
- **Steps 32–38:** Authenticate with workstation client credentials, bootstrap the new cluster once, start Kubernetes and its CNI, retrieve Kubernetes credentials, and verify readiness. General Linux does not implicitly create a Kubernetes cluster.

### What Can Go Wrong

- DHCP and a MAC-based configuration lookup do not authenticate the machine. Restrict provisioning access and protect configuration containing secrets. HTTPS requires a certificate chain the booted environment actually trusts.
- These diagrams assume compatible boot assets and working network, storage and registry access. Secure Boot requires a separately prepared trusted boot chain; PXE alone does not establish it.
- Missing DHCP or boot assets prevents the initial network boot. Missing runtime networking prevents configuration or image retrieval. A wrong install disk can overwrite data.
- An authenticated Talos API requires valid trusted client credentials and roles. Losing the administrator's private key cannot be fixed with maintenance-mode flags; recovery depends on separately retained credentials or secrets.
- Detailed security and recovery explanations in documents 03 and 04 remain unapproved drafts. Section 1.3 introduces DHCP, Matchbox, Squid and remote NAT; implementation remains a later discussion.

Sources: [Talos PXE](https://docs.siderolabs.com/talos/v1.14/platform-specific-installations/bare-metal-platforms/pxe), [Talos getting started](https://docs.siderolabs.com/talos/v1.14/getting-started/getting-started), [Talos workloads on control planes](https://docs.siderolabs.com/talos/v1.14/deploy-and-manage-workloads/workloads-on-controlplane), [general Linux example: RHEL network installation](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/interactively_installing_rhel_over_the_network/preparing-a-pxe-installation-source).

## Section 1.3: Network Boot Across Distant Sites

An EDGE can download boot files from NEN miles away. The distance matters for latency, bandwidth and reliability; the first question is how the machine gets onto the network before Talos exists.

### How It Reaches NEN

For a branch behind customer NAT, one possible design is:

1. **Prepare the branch network:** The router already has Internet access. Configure the existing DHCP service to supply the correct network boot information, and provide a local service for the first loader when using PXE chainloading.
2. **Power on the blank EDGE:** Its firmware requests an address and boot information on the branch LAN.
3. **Start iPXE:** Firmware downloads a compatible iPXE loader from the local boot service. Alternatively, use a prepared iPXE USB or supported firmware HTTP boot; the first loader still needs a way to find its boot instructions.
4. **Contact NEN:** iPXE requests its boot script and assets through the branch gateway. These are outbound connections, so ordinary NAT does not require inbound port forwarding. Routing, DNS and firewall policy must allow them.
5. **Start Talos in RAM:** The downloaded kernel and initramfs start Talos, which configures its own networking.
6. **Fetch configuration and install:** Talos retrieves its protected machine configuration, downloads the installer image, and installs to SSD.
7. **Boot from SSD:** Talos restores its saved configuration. Bootstrap the new cluster once and verify Kubernetes readiness, as in section 1.2.

The EDGE's own Talos WireGuard connection cannot carry steps 2–4: Talos has not started yet. A router-to-NEN VPN can be used because the router is already running.

This is a proposed network layout for NEN, not an assumption that every customer network already supports it.

```mermaid
sequenceDiagram
    autonumber
    participant E as EDGE
    participant L as Branch DHCP and Boot Service
    participant G as Branch Gateway
    participant N as NEN Boot and Config Services
    participant R as Image Registry
    E->>L: Firmware requests DHCP and boot information
    L-->>E: Address and local loader location
    E->>L: Download compatible iPXE loader
    L-->>E: Return loader and NEN script location
    E->>G: iPXE requests NEN boot script and assets
    G->>N: Forward outbound requests
    N-->>G: Return boot script and Talos assets
    G-->>E: Deliver responses
    E->>E: Start Talos and configure runtime network
    E->>G: Request protected machine configuration
    G->>N: Forward configuration request
    N-->>G: Return authorized node configuration
    G-->>E: Deliver configuration
    E->>G: Request installer image
    G->>R: Forward registry request
    R-->>G: Return image
    G-->>E: Deliver image
    E->>E: Install to SSD and reboot locally
```

### Who Does What?

| Player | Job | Where it runs | Is it needed? |
| --- | --- | --- | --- |
| **BIOS or UEFI** | Starts the selected network loader | EDGE firmware | Yes, with compatible network-boot support |
| **DHCP** | Supplies an address and network boot information | Branch LAN, or a reachable server through a configured relay | Required for the illustrated PXE path |
| **DHCP relay** | Forwards DHCP requests between a subnet and a DHCP server | Branch router or network device | Only when DHCP is on another routed network |
| **TFTP service** | Supplies the first PXE loader | Usually near the EDGE | Needed for this chainloading example; HTTP boot can use another path |
| **iPXE** | Runs boot instructions and downloads the OS boot assets | EDGE, before Talos | Useful here; other supported loaders can replace it |
| **HTTP or HTTPS boot service** | Serves boot scripts, kernel and initramfs | NEN, a regional server or a branch mirror | A boot-file source is needed |
| **Matchbox** | Matches hardware labels to profiles and produces boot instructions | Usually NEN or a regional provisioning service | Optional; a static iPXE script works for a small lab |
| **Machine configuration service** | Delivers the correct Talos configuration securely | NEN or a trusted provisioning service | Needed for automatic URL-based configuration; API delivery is another path |
| **Image registry** | Supplies Talos installer and Kubernetes images | Central, regional or local | Required image content must be reachable |
| **Squid** | Proxies web requests and can cache eligible content | Branch or regional network | Optional; it reduces some repeated downloads, not the need for DHCP or a loader |
| **Gateway, DNS and firewall** | Provide name resolution, routing and permitted WAN access | Branch network | Needed for this WAN download path |

The names are **iPXE** and **Squid**.

Matchbox does not replace DHCP. Its machine labels, such as MAC addresses, select a profile; they do not prove a trusted EDGE identity. Its authenticated management API is separate from authenticating booting machines.

Squid is not a bootloader or provisioning controller. An ordinary HTTPS CONNECT tunnel keeps the content encrypted, so Squid cannot simply cache the files inside it. For repeated OS downloads, a local file mirror or registry mirror may fit better. Do not cache secret machine configurations as shared public content.

### Notes

- **Local DHCP, central files:** Keep boot discovery at the branch and fetch larger assets from NEN over permitted HTTP/HTTPS connections.
- **Central DHCP over a private network:** A branch relay can reach NEN DHCP through a routed WAN or router VPN. It must be configured in advance; DHCP discovery is not an Internet-wide broadcast.
- **No branch boot service:** A prepared iPXE USB can supply the first loader while the branch's ordinary DHCP supplies networking. A shipped EDGE with Talos already on SSD normally boots locally instead.
- **Customer network restrictions:** Captive portals, unsupported Wi-Fi authentication or blocked downloads can prevent pre-OS boot. This example assumes Ethernet and permitted access to the required endpoints.
- **HTTPS and Secure Boot:** The actual loader must support HTTPS and trust the serving certificate. Every executable in a Secure Boot chain must also satisfy the firmware's trust policy; a downloaded iPXE binary is not automatically trusted.
- **WAN failure:** A cold machine needs its required assets and configuration to continue. Branch mirrors can reduce that dependency. After installation, ordinary SSD boot does not repeat these network installation steps.

Sources: [DHCP and relays: RFC 2131](https://www.rfc-editor.org/rfc/rfc2131), [iPXE project: chainloading](https://ipxe.org/howto/chainloading), [Matchbox](https://matchbox.psdn.io/), [Squid](https://www.squid-cache.org/Intro/), [Squid HTTPS behavior](https://wiki.squid-cache.org/Features/HTTPS), [Talos PXE](https://docs.siderolabs.com/talos/v1.14/platform-specific-installations/bare-metal-platforms/pxe).
