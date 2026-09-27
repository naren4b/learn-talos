# First Power On

**Status:** Architecture discussion concluded; implementation acceptance pending.

## Responsibility

The branch operator powers on an already installed EDGE.

## Standard procedure

1. Start from the internal SSD; no customer-side OS installation is expected.
2. Provide usable bootstrap networking, DNS and time synchronization as required by the selected design.
3. Track boot separately from outbound management connectivity and application readiness.

## Completion evidence

Local boot outcome and, when reachable, authenticated status.

## Failure and recovery

No network means activation waits; it does not itself establish that local boot failed.

**TODO:<Question>** Define static-network sites, time bootstrap, proxy/firewall requirements and offline startup policy.

See [consolidated factory workflow](01-factory-provisioning.md) and [open questions](../open-topic.md). These are proposed operating requirements, not completed tests.
