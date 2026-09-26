# Topic 1 — Talos at EDGE

## Interview mental model

**Goal:** explain how a customer-premise EDGE can become a trusted Talos/Kubernetes platform without depending on SSH or inbound customer-network access.

```text
Factory
  ↓
Approved Talos boot artifact
  ↓
Customer powers on EDGE
  ↓
Secure Boot / TPM trust
  ↓
Outbound enrollment
  ↓
Operational machine identity
  ↓
Secure management connectivity
  ↓
Talos
  ↓
Kubernetes
  ↓
Customer workload
```

## The story to remember

**BOX → TRUST → CONNECT → BUILD**

### BOX
A prepared appliance is shipped to the customer. Inventory maps the physical device to customer/site/role.

### TRUST
Secure Boot controls what may execute. TPM can protect keys and record boot measurements. Where the threat model requires it, remote attestation can prove acceptable device/software state before operational identity is issued.

### CONNECT
The EDGE is normally behind customer NAT/firewalls. It initiates outbound connectivity rather than requiring inbound SSH. WireGuard can provide a private management overlay.

### BUILD
After trust/enrollment, the EDGE receives operational identity and desired configuration. Talos provides the immutable/API-managed OS foundation and Kubernetes runs the customer workload.

## Four boundaries not to mix up

| Concept | Answers |
|---|---|
| Secure Boot | Is this software allowed to execute? |
| Measured Boot | What participated in boot? |
| Remote Attestation | Can the machine prove an acceptable state remotely? |
| Machine certificate | How does the approved EDGE authenticate during operation? |

## Interview-ready statement

> I would treat the EDGE as an appliance rather than a remotely administered Linux server. The device is prepared centrally, establishes trust at boot, initiates outbound enrollment from the customer network, receives operational identity, and is managed through Talos APIs and secure connectivity rather than SSH.

## Scope boundary

This Topic 1 note intentionally stops at a trusted, connected, running Talos/Kubernetes EDGE.

Separate topics cover Day-2 operations, fleet management at scale, monitoring/observability, and backup/restore.
