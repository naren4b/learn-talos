# Ready to Ship

**Status:** Architecture discussion concluded; implementation acceptance pending.

## Responsibility

Validation service approves a specific unit only after its required tests pass.

## Standard procedure

1. Check SSD boot, expected identity, artifact/configuration versions and required hardware/security results.
2. Store evidence against EDGE-ID, station, job and test policy; authorized release owner approves the transition.
3. Remove installation media and transient credentials; record assignment if known. Site assignment may occur later, before branch authorization.

## Completion evidence

Recorded release decision with test results and software profile.

## Failure and recovery

Missing evidence, repair or changed software invalidates release until revalidation.

**TODO:<Question>** Define evidence age limits, release roles and revalidation triggers.

See [consolidated factory workflow](01-factory-provisioning.md) and [open questions](../open-topic.md). These are proposed operating requirements, not completed tests.
