# Track 1 — Talos Fundamentals

This is the original general Talos learning curriculum.

It covers the foundation required before the secure EDGE deep dive in Track 2:

1. Talos mental model
2. CLI and API understanding
3. Security artifacts and trust relationships
4. Cluster lifecycle
5. Installation patterns
6. Boot and Secure Boot
7. Production security
8. Troubleshooting like an SRE
9. Operations at scale

The detailed curriculum remains in the repository roadmap and should be used as the source learning plan.

## Relationship to Track 2

```text
Track 1 — Talos Fundamentals
        ↓
Understand Talos itself
        ↓
Track 2 — Secure EDGE
        ↓
Apply Talos to a remote customer-premise EDGE architecture
```

Track 1 answers:

> How does Talos work, and how do I build and operate Talos Kubernetes correctly?

Track 2 answers:

> How do I apply those Talos concepts to a secure, remotely managed EDGE appliance?

## Detailed roadmap

See:

`docs/learning-foundations/roadmap.md`

This Track-1 directory exists to keep the repository's track naming and navigation consistent without duplicating the detailed roadmap.

## Pre-lab revision

Review the [detailed boot and trust notes](detailed/README.md) before proceeding: general Linux versus Talos, machine configuration at step 11, authenticated API at step 21, security risks, break-glass and lost-key recovery. Current learning pace: one question at a time.

The [live discussion](conversation-live.md) preserves questions, answers and extra notes. The detailed documents provide topic-focused explanations.

## Fundamentals Reference

Document fundamental, theoretical and basic OS, Talos, booting and security topics in this series. Other tracks should refer to the [fundamentals reference](detailed/README.md) instead of duplicating explanations. Keep detailed notes topic-focused and questions, answers and extra notes in [conversation-live.md](conversation-live.md).

The earlier configuration/authentication and security/recovery drafts are preserved in the live record for later discussion.
