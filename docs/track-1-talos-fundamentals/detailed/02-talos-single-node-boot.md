# Talos Single-Node Boot Sequence

Parent: [Detailed notes](README.md). Previous: [General Linux](01-general-linux-boot.md). Next: [Configuration and authentication](03-configuration-and-api-authentication.md).

Scope: blank bare-metal disk, USB boot, reachable registry, one control-plane node also running workloads. This is the ordinary configuration-driven installation path, not the EC2 AMI or NEN factory identity workflow.

## Talos Installation and Cluster Bootstrap

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

Step numbers preserve our discussion. This is a dependency overview, not an exact service trace: image downloads and service startup can overlap or happen earlier. The loader starts the kernel; the Hardware-to-Talos arrows abbreviate that chain. API authentication follows configured trust, not a security property created by the reboot itself.

The USB environment initially runs in RAM. Remove/unmount installation media after it has booted, following the installation guide, and identify the SSD before configuration triggers installation. Step 15 expresses the boot-device requirement, not a prompt to race the automatic reboot.

Step 22 is a one-time cluster initialization. Do not run bootstrap on ordinary restarts. Step 26 requires functioning container networking. A single node has no node-level availability redundancy.

Sources: [Talos getting started](https://docs.siderolabs.com/talos/v1.14/getting-started/getting-started), [workloads on control planes](https://docs.siderolabs.com/talos/v1.14/deploy-and-manage-workloads/workloads-on-controlplane).
