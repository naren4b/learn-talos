# Identity Registered to Talos Installed

**Status:** Next learning sub-topic.

## Transition

| From | To | Primary actor | Location |
| --- | --- | --- | --- |
| `IdentityRegistered` | `TalosInstalled` | Factory provisioning server | Provisioning server and EDGE SSD |

The provisioning server obtains the approved Talos artifact for the hardware
profile, verifies it and installs Talos onto the EDGE SSD.

## Exact restart question

What are the Talos image, ISO, installer and UKI; which artifact is temporary,
which content remains on the SSD, and which artifact UEFI verifies?

## Topics to complete

- Artifact types and their roles
- Artifact source, approval, checksum and signature
- Installation path to the EDGE SSD
- Installation failure and recovery
