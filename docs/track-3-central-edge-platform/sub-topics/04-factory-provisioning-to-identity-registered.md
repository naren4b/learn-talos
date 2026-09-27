# Factory Provisioning → Identity Registered

**Status:** Architecture hypothesis only; Step 5 implementation parked pending TPM API verification.

## Use case

An accepted virgin EDGE is connected to an authorized factory station. The station would coordinate TPM operations through a suitable trusted EDGE-side environment (not yet selected), validates manufacturer evidence under policy, allocates an EDGE-ID and registers public identity information centrally.

| Operation | Executor and location | Evidence returned |
| --- | --- | --- |
| Inspect EK certificate/public identity | TPM/EDGE responds; station verifies issuer and policy | Manufacturer public identity and validation result |
| Create AK and operational key | EDGE TPM via EDGE-side software | Public keys and proof of possession; private keys remain TPM protected |
| Bind EDGE-ID to hardware | Central inventory, requested by station | Inventory record, station and audit metadata |

The station knows approved OEM trust roots, hardware policy, enrollment endpoint and its own scoped station credential. It must not know or store TPM private keys or the central CA/image-signing private keys. A public EK alone does not prove that the caller controls that TPM: design a challenge/proof and validate the AK binding before declaring identity registered. The agreed teaching model issues the operational certificate at the factory; lifetime, activation authorization and the concrete enrollment interface remain open.

**Exit evidence:** unique EDGE-ID, verified manufacturer identity under the chosen policy, AK public identity and binding evidence, auditable station action. Failed proof, duplicate serial/EK or unsupported TPM enters quarantine.

## Parked Step 5

**TODO:<Question>** On Talos v1.14.1, can an unconfigured EDGE in maintenance mode expose its TPM EK public key and manufacturer certificate, create or use an AK, and provide a verifiable EK–AK binding through documented Talos API/`talosctl` operations? If not, what controlled factory boot environment or OEM identity handoff performs these operations before Talos installation? Verify with official documentation/source and a physical TPM PoC before selecting the workflow.

Talos TPM-backed disk encryption and TPM detection do not establish factory EK/AK enrollment. Do not assume `talosctl --insecure` can read EK credentials or perform arbitrary TPM operations.

## To study next

EK certificate availability and trust roots; AK certification/challenge protocol; enrollment authorization; credential lifecycle, revocation and hardware replacement.

## Architecture closure — 2026-09-27

This sub-topic's responsibility boundary is concluded for the current learning pass. The [consolidated factory workflow](01-factory-provisioning.md) supplies the corrected shared-preparation/per-EDGE sequence. UEFI trust precedes the Secure Boot installation environment; SSD reboot verifies enforcement again. Implementation questions remain in [open-topic.md](../open-topic.md), and no unperformed test is marked successful.
