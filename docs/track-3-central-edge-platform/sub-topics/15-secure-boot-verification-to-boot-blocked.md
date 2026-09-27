# Blocked Boot

**Status:** Architecture discussion concluded; implementation acceptance pending.

## Responsibility

An untrusted or revoked boot component is rejected by the boot verification chain.

## Standard procedure

1. Record local firmware/boot evidence through the available console or technician.
2. Keep central status as unreachable or unknown unless reliable diagnostics establish the cause.
3. Use authorized signed recovery media and documented trust repair; revalidate before release.

## Completion evidence

Diagnostic evidence and a successful approved recovery test.

## Failure and recovery

Do not silently disable Secure Boot to restore service; any exceptional recovery requires explicit authorization and audit.

**TODO:<Question>** Define signed recovery media, authorized operators and branch support procedures.

See [consolidated factory workflow](01-factory-provisioning.md) and [open questions](../open-topic.md). These are proposed operating requirements, not completed tests.
