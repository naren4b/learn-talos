# Shipment

**Status:** Architecture discussion concluded; implementation acceptance pending.

## Responsibility

Logistics transfers an approved EDGE with its installed SSD to the customer.

## Standard procedure

1. Verify ReadyToShip and serial against shipment authorization.
2. Package and record custody, destination and tamper-evidence details.
3. Record Shipped separately from branch installation or activation.

## Completion evidence

Shipment identity, destination, serial and custody record.

## Failure and recovery

Loss, theft or cancelled delivery triggers blocked activation and credential review; shipment alone grants no site access.

**TODO:<Question>** Define custody controls and lost-shipment response ownership.

See [consolidated factory workflow](01-factory-provisioning.md) and [open questions](../open-topic.md). These are proposed operating requirements, not completed tests.
