# Use Case — Why Talos at EDGE?

## Problem

A remote customer-premise Kubernetes node should not depend on engineers SSHing into a mutable general-purpose Linux server and manually repairing configuration drift.

## Mental model

```text
Traditional server thinking
SSH → modify host → repair drift

Talos appliance thinking
API → desired machine state → replace/reimage failed OS state
```

## Why Talos fits the EDGE model

From the Track-2 design:

- Talos is an **immutable/API-managed OS**.
- Day-to-day management does not depend on SSH.
- Machine/operator cryptographic identity is used for management.
- Failed OS state is preferably replaced/reimaged rather than manually repaired.
- Application persistence should remain independent of disposable OS state.

## Architecture consequence

Removing SSH is not merely a security setting. It changes the operating model:

```text
Engineer
   ↓
Talos API / cryptographic identity
   ↓
EDGE Talos node
   ↓
Kubernetes
```

The architecture therefore needs reliable management connectivity and recovery paths; it cannot assume an engineer will log in and repair the host.

## What Talos does not solve by itself

The source design keeps responsibilities separate:

- UEFI/TPM provide hardware root-of-trust primitives.
- Inventory maps hardware to customer/site/role.
- An attestation system, when required, evaluates TPM/platform evidence.
- The surrounding platform owns policy, approvals and governance.

Do not assume Talos alone is a complete remote hardware-attestation or fleet-management system.

## Remember

**Talos at EDGE = appliance operating model: immutable + API-managed + cryptographic access + no SSH dependency.**
