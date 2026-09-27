# PKI and VirtualBox Lab Checkpoint

**Status:** PKI commands understood; root certificate details inspected by the user. Secure Boot VM lab not started.

## PKI evidence

| Artifact | Recorded state |
| --- | --- |
| Root private key | Encrypted RSA key creation acknowledged after correcting short-passphrase error |
| Root certificate | User displayed subject/issuer NEN Root CA and validity 2026-09-27 to 2036-09-24 |
| Device Issuing CA private key | Creation acknowledged |
| Issuing CA CSR | Command supplied and understood; independent validation not shown |
| Issuing CA certificate | Not issued in this session |
| EDGE certificate | Not created in this lab |

Commands and exact user output remain in the [append-only live record](../track-3-central-edge-platform-live.md). Resume by checking the CSR, preparing CA constraints, signing the issuing CA certificate and verifying its chain, one command at a time. Private keys and passphrases must not be committed.

## Proposed VirtualBox procedure

1. Verify the chosen VirtualBox version exposes the required firmware, Secure Boot trust enrollment and TPM behavior.
2. Prepare shared NEN-signed boot media and a reachable matching installer registry.
3. Create a disposable EDGE VM with UEFI, virtual SSD and suitable networking.
4. Enroll approved public boot trust and boot the approved installation environment.
5. Apply lab configuration and install onto the explicitly selected virtual SSD.
6. Remove installation media, reboot and inspect Secure Boot and Talos state.
7. Perform controlled rejection and recovery tests; record results.

These are planning steps, not validated VirtualBox commands. Shared certificate/build preparation needs no EDGE. Per-VM trust enrollment, installation and tests repeat for every VM.

KIND supports central-service exercises; it does not establish UEFI or TPM enforcement. A VM result also does not qualify production physical hardware.

**TODO:<Question>** Which exact VirtualBox firmware/TPM settings and enrollment method reproduce the required Talos Secure Boot behavior?
