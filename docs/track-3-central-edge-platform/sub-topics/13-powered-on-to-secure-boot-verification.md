# Boot Verification

**Status:** Architecture discussion concluded; implementation acceptance pending.

## Responsibility

EDGE firmware and the signed boot chain verify authorized executable boot components.

## Standard procedure

1. UEFI evaluates the selected EFI bootloader against enrolled allow and revocation policy.
2. The boot chain verifies the signed UKI; UKI packages kernel, initramfs and boot arguments.
3. Measurements extend TPM PCRs separately from signature enforcement.

## Completion evidence

Expected firmware state plus validated boot results; PCR evidence only through an implemented verifier.

## Failure and recovery

Rejected boot components cannot proceed on that path; central timeout alone cannot diagnose Secure Boot failure.

**TODO:<Question>** Test actual firmware enforcement and approved recovery on the chosen hardware.

See [consolidated factory workflow](01-factory-provisioning.md) and [open questions](../open-topic.md). These are proposed operating requirements, not completed tests.
