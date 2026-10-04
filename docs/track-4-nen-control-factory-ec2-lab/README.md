# Track-4 — NEN Control, Factory and EC2 EDGE Lab

**Status:** Created 2026-09-27; implementation not started.

This is the active practical continuation of [Track-3 architecture](../track-3-central-edge-platform/README.md). Build one complete, testable NEN workflow before expanding it to multiple EDGEs.

## Two lab areas

| Area | Purpose | Initial environment |
| --- | --- | --- |
| Track-4A — NEN Control Data Center & Factory | Identity, inventory, artifacts, provisioning jobs and lifecycle services | Retain Ubuntu WSL + KIND and FOSS as the initial baseline; central hosting and external reachability require Phase 0 confirmation |
| Track-4B — EDGE on EC2 | Talos virtual EDGE, outbound management, activation and lifecycle tests | AWS EC2 using an approved Talos AMI; region, instance, network and storage selected in Phase 0 |

Running the EDGE on EC2 does not imply moving the central platform to EKS. The later AWS-managed central-platform evolution remains a separate future objective. No Omni or paid fleet-management dependency is introduced. AWS resources themselves incur usage charges.

The production architecture remains designed for 1,000+ sites. A small lab demonstrates interactions and failure behavior, not production capacity or independent physical failure domains.

## Phase index

| Phase | Work | Acceptance gate |
| --- | --- | --- |
| [0 — Baseline and topology](phase-0-baseline.md) | Inspect workstation, AWS context, network reachability and costs | Recorded topology, recovery path, pinned versions and resource plan |
| [1 — NEN Control & Factory](track-4a-control-and-factory.md) | Build the minimum central services and factory job | Auditable inventory, trust and approved artifact/configuration workflow |
| [2 — EDGE on EC2](track-4b-edge-on-ec2.md) | Boot Talos and establish secure management | Approved image running with verified recovery and restricted access |
| 3 — Integrated activation | EDGE identity, authorization, configuration and health | Correct EDGE/site succeeds; unauthorized device/site fails |
| 4 — Lifecycle and failures | Reconnect, renewal, upgrade work order and recovery | Durable progress and measured failure/recovery behavior |
| 5 — Boot trust and TPM | Validate exact NEN-signed Talos/EC2 path | Positive, negative and recovery evidence; no capability inferred from AMI launch |
| 6 — Repeatability and scale model | Add EDGEs and exercise load controls | Unique identities, repeatable jobs, bounded concurrency and documented limits |

Phases 3–6 receive focused use-case Markdown files when implementation reaches them. Dependencies may require revisiting an earlier phase; a simulated identity must never be reported as hardware-backed enrollment.

## Document contract

- [Live record](track-4-nen-lab-live.md): append-only commands, outputs, mistakes, fixes and restart points.
- [Open questions](open-topic.md): unresolved choices and inherited blockers.
- Each completed step records intent, verification, failure handling and production implications.
- Use numbered steps and Mermaid for diagrams. Provide one practical command at a time.
- Store no keys, credentials, secret-bearing machine configurations or Terraform state in Git.

## Next Lab: Talos on AWS

[Track-4B](track-4b-edge-on-ec2.md) is the next selected hands-on track. Its first stage brings up standalone Talos on EC2, checks authenticated access and Kubernetes readiness, and learns diagnostics and upgrades. IRSA follows when a workload needs AWS access.

The standalone stage does not depend on deploying NEN control/factory. Keep the central reachability decision for later fleet integration. Track-4A remains planned.

## First step

Begin [Phase 0](phase-0-baseline.md) with read-only workstation and AWS-context discovery. No AWS infrastructure was created as part of establishing this track.

## Pre-lab revision

Review the [detailed boot and trust notes](../track-1-talos-fundamentals/detailed/README.md) before proceeding: general Linux versus Talos, machine configuration at step 11, authenticated API at step 21, security risks, break-glass and lost-key recovery. Current learning pace: one question at a time.
