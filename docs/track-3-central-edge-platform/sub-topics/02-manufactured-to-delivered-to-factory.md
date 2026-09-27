# Supplier Delivery

**Status:** Architecture discussion concluded; implementation acceptance pending.

## Responsibility

Vendor supplies qualified hardware and provenance; factory receiving accepts custody, not fleet membership.

## Standard procedure

1. Match purchase order, serial and approved hardware profile.
2. Inspect packaging, damage and recorded firmware/TPM capabilities; never infer NEN trust from vendor delivery.
3. Record receipt and assign intake ownership; hold mismatches for supplier review.

## Completion evidence

Manifest, serial, receiving operator, condition and hardware profile.

## Failure and recovery

Damaged, mismatched or unverifiable units cannot advance to provisioning.

**TODO:<Question>** Define supplier evidence and hardware qualification thresholds.

See [consolidated factory workflow](01-factory-provisioning.md) and [open questions](../open-topic.md). These are proposed operating requirements, not completed tests.
