# Track-3 Open Topics

Questions deliberately parked during architecture learning. Each entry points to its detailed use case. Keep an item open until an official source and, where needed, a lab or physical-device test establish the answer. When resolved, record the conclusion and evidence in the relevant sub-topic and append a dated checkpoint to the [live record](track-3-central-edge-platform-live.md).

## OT-01 — Virgin EDGE TPM identity path

**Status:** Open · **Paused at:** Step 5, `FactoryProvisioning → IdentityRegistered`

**TODO:<Question>** On Talos v1.14.1, can an unconfigured EDGE in maintenance mode expose its TPM EK public key and manufacturer certificate, create or use an AK, and provide a verifiable EK–AK binding through documented Talos API/`talosctl` operations? If not, what controlled factory boot environment or OEM identity handoff performs these operations before Talos installation?

**Known:** Talos v1.14 documents TPM-backed disk encryption and PCR policy. Those features do not establish a factory EK/AK enrollment interface. Do not assume `talosctl --insecure` can perform arbitrary TPM operations.

**Close when:** Supported API or alternative factory environment is selected; EK certificate validation, AK binding/proof, private-key containment and failure handling are demonstrated on real or representative hardware.

**Use case:** [04 — Identity registration](sub-topics/04-factory-provisioning-to-identity-registered.md). **Sources:** [Talos 1.14 disk encryption](https://docs.siderolabs.com/talos/v1.14/configure-your-talos-cluster/storage-and-disk-management/disk-encryption), [Talos CLI reference](https://docs.siderolabs.com/talos/v1.14/reference/cli).

## OT-02 — First-contact device matching

**Status:** Open · **Paused at:** Step 4, factory station

**TODO:<Question>** How does a station associate a scanned physical EDGE with the correct staging IP and job, and authorize first contact before cryptographic device identity is established?

**Close when:** A repeatable intake protocol handles duplicate addresses, swapped cables/ports, simultaneous devices and a mismatched serial without delivering a privileged configuration to the wrong EDGE.

**Use case:** [16 — Factory station](sub-topics/16-factory-provisioning-station.md).

## OT-03 — Talos artifact and initial configuration

**Status:** Open · **Paused at:** `IdentityRegistered → TalosInstalled`

**TODO:<Question>** Which Talos v1.14.1 ISO/PXE asset, installer image, signed UKI and hardware extensions are approved; how are provenance, selected SSD and initial machine configuration verified and delivered without exposing durable secrets?

**Close when:** Versioned artifact manifest, configuration delivery, install-disk guard and partial-install retry are tested.

**Use case:** [05 — Talos installation](sub-topics/05-identity-registered-to-talos-installed.md).

## OT-04 — UEFI trust enrollment and recovery

**Status:** Open · **Scope:** Trust preparation before installation and verification after SSD boot

**TODO:<Question>** How does an authorized factory workflow enroll the required public UEFI Secure Boot trust on the chosen hardware, verify enforcement, rotate/revoke signing trust and recover from a bad enrollment?

**Close when:** Hardware-specific enrollment and negative boot/recovery tests are documented.

**Use case:** [06 — Secure Boot configuration](sub-topics/06-talos-installed-to-secure-boot-configured.md).

## OT-05 — Factory acceptance evidence

**Status:** Open · **Paused at:** `SecureBootConfigured → FactoryValidation`

**TODO:<Question>** Which fresh EDGE-side measurements, firmware state, TPM quote, Talos health, SSD/NIC checks and negative tests must pass before `READY_TO_SHIP`, and what evidence is retained?

**Close when:** A test matrix identifies executor, verifier, acceptance threshold, retry/quarantine rule and stored evidence for each check.

**Use case:** [07 — Factory validation](sub-topics/07-secure-boot-configured-to-factory-validation.md).

## Next revisit

Resume at **OT-01** before treating `IdentityRegistered` as a working factory gate. The concluded lifecycle notes [02–15](sub-topics/README.md) retain their scoped implementation questions; this register tracks cross-cutting blockers and explicit parked decisions.

## OT-06 — Bootstrap and credential persistence

**Status:** Open

**TODO:<Question>** Which NEN bootstrap component runs on installed Talos, how does it use the EDGE-held private key and certificate, how are credentials retained across installation/upgrades, and how does it securely receive site configuration?

**Close when:** Factory issuance through SSD reboot and authorized branch activation is demonstrated, including wrong-site denial and credential recovery.

## OT-07 — VirtualBox Secure Boot lab

**Status:** Open

**TODO:<Question>** What exact VirtualBox firmware, trust enrollment, virtual TPM and signed-media workflow supports our chosen Talos release, and which results require physical hardware validation?

**Close when:** Approved boot, rejected boot and recovery are demonstrated with recorded evidence. See [lab checkpoint](sub-topics/20-pki-and-virtualbox-lab-checkpoint.md).

## Architecture closure — 2026-09-27

The factory topic is concluded at the architecture-learning level. No open item is resolved by that closure. Certificate expiry/renewal, offline behavior, upgrade durability and central capacity questions remain recorded with Steps 8–27 in the live document; detailed operating policies are future implementation work.
