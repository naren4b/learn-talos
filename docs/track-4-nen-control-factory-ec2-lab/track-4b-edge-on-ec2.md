# Track-4B — EDGE on EC2

**Status:** Planned; no instance launched for this track.

## Purpose

Use a Talos EC2 instance as the NEN EDGE role for enrollment, outbound connectivity, configuration, health, upgrade and recovery exercises.

## Numbered implementation sequence

1. Verify a current official Talos AWS artifact source and pin the chosen AMI/build for the selected region and CPU architecture.
2. Define instance, EBS, network, security groups and recovery access in reproducible infrastructure configuration.
3. Launch one EDGE with securely handled machine configuration; do not place generated secrets in Git.
4. Verify Talos boot/version and restricted administrative access independently of NEN activation.
5. Establish the selected EDGE-initiated connection to the reachable NEN endpoint.
6. Integrate device credentials, private-key proof and site authorization through the chosen NEN component.
7. Verify configuration application and separate platform/application health.
8. Exercise reconnect and one controlled upgrade before adding a second EDGE.
9. Validate the exact Secure Boot and NitroTPM path with positive, negative and recovery tests.

## Boundaries

EC2 uses a Talos AMI and EBS root volume in place of the physical USB/SSD factory flow. EC2 supports UEFI Secure Boot and NitroTPM under documented prerequisites, but our exact NEN-signed Talos workflow is unverified. A successful normal Talos boot proves neither feature.

NitroTPM state is not included in EBS snapshots; restoring an image must not be assumed to restore TPM-bound identity or unlock capability. Design recovery before relying on those bindings.

## Acceptance evidence

Pinned artifact, instance/volume ownership, recovery method, actual connectivity and authenticated NEN results, plus explicit untested security properties. A private-subnet outbound-NAT test is required before claiming the branch NAT scenario is demonstrated.

## Sources to revisit before implementation

- [Talos Image Factory AWS artifacts](https://github.com/siderolabs/image-factory/blob/main/docs/api.md)
- [AWS NitroTPM prerequisites](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enable-nitrotpm-prerequisites.html)
- [AWS Secure Boot prerequisites](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/launch-instance-with-uefi-sb.html)

No instance type, AMI ID or price is frozen by this planning document.
