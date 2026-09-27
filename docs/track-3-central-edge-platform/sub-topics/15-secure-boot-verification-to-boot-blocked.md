# Secure Boot Verification to Boot Blocked

**Status:** Planned learning sub-topic.

## Transition

| From | To | Primary actor | Location |
| --- | --- | --- | --- |
| `SecureBootVerification` | `BootBlocked` | EDGE UEFI | Customer EDGE |

UEFI rejects a missing, altered or untrusted signature and prevents Talos from
executing.

## Topics to complete

- Failure evidence visible locally and centrally
- Customer-safe instructions
- Recovery-media and re-provisioning path
- Break-glass authorization without bypassing trust silently
