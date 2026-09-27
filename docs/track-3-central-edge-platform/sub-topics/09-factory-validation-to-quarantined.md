# Quarantine

**Status:** Architecture discussion concluded; implementation acceptance pending.

## Responsibility

A required failure blocks shipment and branch activation approval.

## Standard procedure

1. Record failed gate and last completed stage; isolate the unit and preserve diagnostics.
2. Assign an investigation owner; revoke or suspend credentials as required by the failure.
3. Repair or reprovision under authorization, then repeat affected gates before a new release decision.

## Completion evidence

Failure record, custody and repair/retest outcome.

## Failure and recovery

Do not manually override a failed security gate; supplier return or disposal needs an approved data/credential handling procedure.

**TODO:<Question>** Define retry limits, isolation enforcement and return/disposal procedure.

See [consolidated factory workflow](01-factory-provisioning.md) and [open questions](../open-topic.md). These are proposed operating requirements, not completed tests.
