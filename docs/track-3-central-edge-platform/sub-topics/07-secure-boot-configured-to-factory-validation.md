# Secure Boot Configured to Factory Validation

**Status:** Planned learning sub-topic.

## Transition

| From | To | Primary actor | Location |
| --- | --- | --- | --- |
| `SecureBootConfigured` | `FactoryValidation` | Provisioning and validation systems | Factory staging facility and EDGE |

The provisioning system causes the EDGE to reboot. UEFI verifies the signed
boot artifact, Talos starts, and the factory gathers hardware, TPM, boot,
storage and network evidence from the EDGE.

## Topics to complete

- Factory acceptance-test specification
- Secure Boot and TPM evidence
- Talos, storage and network health checks
- Evidence retention and retry policy
