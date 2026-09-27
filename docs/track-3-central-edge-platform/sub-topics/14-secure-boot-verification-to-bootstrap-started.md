# Bootstrap Handoff

**Status:** Architecture discussion concluded; implementation acceptance pending.

## Responsibility

Successful signed boot starts installed Talos; NEN activation is a separate integration.

## Standard procedure

1. Load minimum network settings and securely provisioned NEN service trust.
2. Proposed bootstrap software initiates outbound authenticated communication through NAT.
3. NEN checks EDGE identity, lifecycle and site assignment before releasing configuration or secrets.

## Completion evidence

Authenticated contact, authorization decision and later configuration/health acknowledgement.

## Failure and recovery

A trusted boot does not prove branch authorization or application health; denied activation must not reveal site secrets.

**TODO:<Question>** Choose bootstrap software, credential storage, TPM client support and configuration delivery.

See [consolidated factory workflow](01-factory-provisioning.md) and [open questions](../open-topic.md). These are proposed operating requirements, not completed tests.
