# Track 2 — Secure Edge

This directory contains the Track-2 Secure Edge learning material.

## Document roles

| Document | Purpose |
| --- | --- |
| [README.md](README.md) | Consolidated, reviewed learning notes and navigation. |
| [track-2-secure-edge-live.md](track-2-secure-edge-live.md) | Chronological PoC/transcript-like record. **Append only; never reorganize historical entries.** |
| [sub-topics/](sub-topics/) | Focused sub-topics and use cases derived from the learning journey. |

## Track goal

Build and understand a production-oriented secure EDGE lifecycle using Talos Linux, Kubernetes, hardware-backed identity, outbound connectivity, centralized management, observability, recovery, and fleet-scale architecture.

The learning path follows:

```text
BOX -> TRUST -> CONNECT -> BUILD -> OPERATE -> PROTECT -> RECOVER -> SCALE
```

## Core architecture principles

- EDGE devices may live behind customer NAT/firewalls.
- Management connectivity is initiated outbound from the EDGE.
- Hardware/device identity, network identity, Talos PKI identity, and operational machine identity remain separate concerns.
- Secure Boot, measured boot, TPM-backed identity and remote attestation solve different trust problems.
- Recovery and management paths should remain useful even when Kubernetes workloads fail.
- Prefer open-source/self-managed components; Omni is intentionally excluded.
- Preserve a known-good path before introducing a new network or trust mechanism.
- Every production claim should have observable evidence and a recovery story.

## Current lab baseline

The PoC uses an AWS-hosted control side and a VirtualBox Talos EDGE node. Exact commands, addresses, experiments, failures and recovery checkpoints belong in the [live record](track-2-secure-edge-live.md), not in this consolidated README.

## Learning topics

### Talos at the EDGE

See [sub-topics/](sub-topics/).

Current focused notes include:

- [Talos at EDGE overview](sub-topics/00-topic-1-talos-at-edge.md)
- [Why Talos at EDGE](sub-topics/01-why-talos-at-edge.md)
- [Bootstrap and trust](sub-topics/02-bootstrap-and-trust.md)
- [Connect EDGE to central](sub-topics/03-connect-edge-to-central.md)
- [End-to-end interview card](sub-topics/04-end-to-end-interview-card.md)
- [Interview learning record](sub-topics/interview-1-talos-at-edge.md)

## Trust mental model

Keep these questions separate:

| Concept | Question |
| --- | --- |
| Secure Boot | Is this software allowed to execute? |
| Measured Boot | What was measured during boot? |
| EK | Which TPM is participating in trust establishment? |
| AK | Which TPM-protected key signs attestation evidence? |
| PCR | What measured platform state is being reported? |
| Remote attestation | Can a remote verifier validate fresh platform evidence? |
| Machine certificate | Which approved EDGE may authenticate operationally? |

See [Bootstrap and Trust](sub-topics/02-bootstrap-and-trust.md) for the detailed learning story.

## Documentation rule

The README is intentionally **not** a transcript.

As the PoC progresses:

- append experiments, failures, commands and checkpoints to `track-2-secure-edge-live.md`;
- refine stable conclusions into this README;
- create focused use-case notes under the appropriate sub-topic directory;
- do not rewrite historical content in the live document to make it cleaner.

The live record is evidence of the learning journey. This README is the final consolidated learning material.
