# Topic 1 — End-to-End Interview Card

## Scenario

Design a secure Kubernetes EDGE appliance that is prepared centrally, shipped to a customer, powered on behind NAT/firewalls, and operated without SSH.

## Whiteboard flow

```text
[Factory]
   |
   | approved Talos artifact + inventory binding
   v
[EDGE hardware]
   |
   | Secure Boot / TPM
   v
[Customer power-on]
   |
   | outbound enrollment
   v
[Central verifier / identity]
   |
   | approve + issue operational identity
   v
[Secure connectivity]
   |
   | private management path
   v
[Talos]
   |
   v
[Kubernetes]
   |
   v
[Customer workload]
```

## How to explain it

### 1. Start with the requirement
The EDGE is remote, may be physically outside our control, and sits behind a customer firewall. We want zero/minimal-touch bootstrap and no SSH dependency.

### 2. Establish trust
Use an approved boot artifact and Secure Boot. TPM-backed capabilities can strengthen key protection and measured boot. If the threat model requires proof of runtime platform state, add remote attestation.

### 3. Bind device to inventory
Factory inventory identifies the expected asset/customer/site/hardware profile. Runtime cryptographic proof is checked against that expected identity.

### 4. Establish connectivity
The EDGE initiates outbound connectivity. A WireGuard overlay can provide the private management path without exposing SSH into the customer LAN.

### 5. Issue operational identity
After verification, issue the identity needed for normal management rather than treating factory/TPM identity and operational credentials as the same thing.

### 6. Run Talos and Kubernetes
Talos provides the immutable/API-managed OS model; Kubernetes hosts the customer workload.

## Failure questions to expect

**What if the SSD is cloned?**  
A hardware-bound TPM identity should not simply move with the cloned disk.

**What if the boot artifact changes?**  
Secure/Measured Boot state changes. If attestation is used, approved measurements/policy must be coordinated with upgrades.

**What if inbound access is blocked?**  
The design relies on EDGE-initiated outbound connectivity rather than inbound SSH.

**Does Secure Boot prove the device is healthy to the data center?**  
No. Secure Boot is local enforcement. Remote attestation is the separate mechanism for remotely evaluating measured state.

**Does WireGuard replace application authentication?**  
No. It can secure/authenticate the network path; application authorization can remain independent.

## Five things to remember

1. **Appliance, not SSH-managed server.**
2. **Factory knowledge + runtime proof → trusted identity.**
3. **Secure Boot, TPM and attestation solve different problems.**
4. **EDGE initiates outbound connectivity; WireGuard can form the management overlay.**
5. **Stop Topic 1 at a trusted, connected, running Talos/Kubernetes EDGE.**

## Next topic

**Topic 2 — Day-2 Operations:** configuration change, upgrade, troubleshooting, maintenance and recovery after the EDGE is running.
