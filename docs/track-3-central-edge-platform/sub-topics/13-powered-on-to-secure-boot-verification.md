# Powered On to Secure Boot Verification

**Status:** Planned learning sub-topic.

## Transition

| From | To | Primary actor | Location |
| --- | --- | --- | --- |
| `PoweredOn` | `SecureBootVerification` | EDGE UEFI | EDGE motherboard at customer site |

UEFI begins the boot process and verifies the signature of the Talos boot
artifact against the trusted public information enrolled at the factory.

## Topics to complete

- UEFI boot sequence
- Secure Boot trust and signature verification
- Relationship among UKI, UEFI and TPM measurements
- Observable success and failure evidence
