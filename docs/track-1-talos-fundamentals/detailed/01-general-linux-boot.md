# General Linux Boot Sequence

Parent: [Detailed notes](README.md). Compare: [Talos sequence](02-talos-single-node-boot.md).

Scope: a typical Linux distribution installed from USB onto a blank SSD. Automated installers and other operating systems can differ. Firmware starts the loader; the loader starts the kernel. Secure Boot checks apply when enabled and correctly configured.

## General Linux Installation and Boot

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
