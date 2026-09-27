# Talos Installed to Secure Boot Configured

**Status:** Planned learning sub-topic.

## Transition

| From | To | Primary actor | Location |
| --- | --- | --- | --- |
| `TalosInstalled` | `SecureBootConfigured` | Provisioning server and EDGE UEFI | Factory and EDGE motherboard |

The provisioning server enrols the approved public Secure Boot trust into the
EDGE UEFI. The corresponding private signing key remains protected centrally.

## Topics to complete

- UEFI trust databases and key roles
- Talos UKI signature verification
- Trust enrolment and authorization
- Key rotation, recovery and failure behavior
