# Factory Provisioning → Identity Registered

**Status:** Responsibility and trust model captured; credential protocol pending.

## Use case

An accepted virgin EDGE is connected to an authorized factory station. The station coordinates TPM operations through a trusted booted environment on the EDGE, validates manufacturer evidence under policy, allocates an EDGE-ID and registers public identity information centrally.

| Operation | Executor and location | Evidence returned |
| --- | --- | --- |
| Inspect EK certificate/public identity | TPM/EDGE responds; station verifies issuer and policy | Manufacturer public identity and validation result |
| Create AK and operational key | EDGE TPM via EDGE-side software | Public keys and proof of possession; private keys remain TPM protected |
| Bind EDGE-ID to hardware | Central inventory, requested by station | Inventory record, station and audit metadata |

The station knows approved OEM trust roots, hardware policy, enrollment endpoint and its own scoped station credential. It must not know or store TPM private keys or the central CA/image-signing private keys. A public EK alone does not prove that the caller controls that TPM: design a challenge/proof and validate the AK binding before declaring identity registered. Whether an operational certificate is issued here or after customer enrollment remains a deliberate policy decision.

**Exit evidence:** unique EDGE-ID, verified manufacturer identity under the chosen policy, AK public identity and binding evidence, auditable station action. Failed proof, duplicate serial/EK or unsupported TPM enters quarantine.

## To study next

EK certificate availability and trust roots; AK certification/challenge protocol; enrollment authorization; credential lifecycle, revocation and hardware replacement.
