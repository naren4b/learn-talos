# Factory Provisioning to Identity Registered

**Status:** Initial mental model captured; implementation details pending.

## Transition

| From | To | Primary actor | Location |
| --- | --- | --- | --- |
| `FactoryProvisioning` | `IdentityRegistered` | Provisioning server, EDGE TPM and fleet inventory | Factory and central platform |

The provisioning server reads the TPM manufacturer identity, asks the EDGE TPM
to create non-exportable attestation and operational keys, and registers only
their public information against the allocated EDGE-ID.

## Required boundary

Private EK, AK and operational key material must not be copied into fleet
inventory or onto the provisioning server.

## Topics to complete

- EK certificate validation
- AK creation and binding evidence
- Operational certificate issuance
- Rotation, revocation and replacement
