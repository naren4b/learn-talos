# Track-4A — NEN Control Data Center & Factory

**Status:** Planned implementation; FOSS baseline on Ubuntu WSL/KIND.

## Responsibilities

| Capability | First lab outcome |
| --- | --- |
| Inventory | Unique EDGE-ID, site assignment, lifecycle and desired/reported state |
| PKI | Separate device/service issuance and protected signer custody |
| Artifact supply | Approved Talos AMI/installer metadata, versions and digests |
| Factory job | Profile, identity-enrollment status, configuration and acceptance evidence |
| Enrollment and authorization | Verify identity and restrict configuration to the assigned site |
| Fleet control | Durable work order and observed completion |
| Audit and health | Attributable actions and separate connection/platform/application state |

Choose the smallest justified FOSS services after Phase 0. Track-3's candidates remain candidates; installing the whole list is not the first step. NEN-specific bootstrap, enrollment and controller integrations must be identified explicitly.

## Numbered implementation sequence

1. Establish the chosen runtime, persistence and externally reachable authenticated endpoint.
2. Resume the PKI lab: verify the issuing-CA CSR, issue its certificate with correct constraints and verify the chain. The root certificate was inspected previously; no issuing-CA certificate is yet confirmed.
3. Establish inventory and authorized station identity.
4. Register approved boot/install artifacts and a versioned job profile.
5. Execute one job against one EC2 EDGE; record each result under an operation ID.
6. Test mismatched identity, wrong-site authorization and partial/retried jobs.
7. Add telemetry and recovery evidence before expanding the fleet.

EC2 image preparation and instance launch represent the cloud factory path. They do not reproduce USB insertion, physical receiving or motherboard enrollment. Keep identity CA, boot signing, PCR signing and cluster API trust separate.

## Acceptance gate

One auditable job progresses from expected device to approved lab device. Failure cannot silently promote a device. If TPM enrollment is simulated, the result is explicitly a software-identity lab and does not close the hardware security gate.

See [open questions](open-topic.md) and [Track-3 service map](../track-3-central-edge-platform/sub-topics/21-data-center-services-and-endpoints.md).
