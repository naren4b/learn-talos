# Secure Boot Verification to Bootstrap Started

**Status:** Planned learning sub-topic.

## Transition

| From | To | Primary actor | Location |
| --- | --- | --- | --- |
| `SecureBootVerification` | `BootstrapStarted` | EDGE UEFI and Talos | Customer EDGE |

UEFI accepts the signed artifact, transfers execution to Talos, and the trusted
customer-site bootstrap path begins.

## Topics to complete

- UEFI-to-UKI execution handoff
- Talos startup state
- Minimum bootstrap information and its storage
- Transition to central enrollment
