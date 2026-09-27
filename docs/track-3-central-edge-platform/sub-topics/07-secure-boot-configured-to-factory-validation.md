# Secure Boot Configured → Factory Validation

**Status:** Test ownership model established; thresholds and evidence format pending.

## Use case

The station commands a test reboot. EDGE UEFI checks the signed boot artifact, EDGE Talos boots and exposes health. EDGE TPM can quote measured PCR values. The station and validation service compare this evidence with policy and record a result. The provisioning server cannot test firmware enforcement, TPM possession or Talos health solely by testing itself.

| Test | Runs or originates on | Assessed by |
| --- | --- | --- |
| Artifact/version and station policy | Factory infrastructure | Station/validation service |
| Signature enforcement and boot outcome | EDGE UEFI | Station from observed result and firmware state |
| TPM identity and measured boot evidence | EDGE TPM, requested by EDGE-side agent | Verifier under approved policy |
| Talos, SSD and NIC health | EDGE Talos/hardware | Validation service from EDGE observations |

A TPM quote needs a nonce and policy comparison; a quote alone is not proof of an approved boot. A successful Talos API response alone is not proof that Secure Boot was enabled. Record the EDGE-ID, station, artifact version, firmware policy, test times and failures.

**Exit evidence:** signed boot succeeds with Secure Boot enabled, approved identity/measurements and hardware/OS tests pass. The following transitions make the final `ReadyToShip` or `Quarantined` decision.

## To study next

Negative boot test, PCR policy/version changes, offline factory operation, retry limits, evidence retention and repair authorization.

## Architecture closure — 2026-09-27

This sub-topic's responsibility boundary is concluded for the current learning pass. The [consolidated factory workflow](01-factory-provisioning.md) supplies the corrected shared-preparation/per-EDGE sequence. UEFI trust precedes the Secure Boot installation environment; SSD reboot verifies enforcement again. Implementation questions remain in [open-topic.md](../open-topic.md), and no unperformed test is marked successful.
