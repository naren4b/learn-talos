# Track-4 — NEN Lab Live Record

**Append only:** preserve commands, evidence, errors, corrections and restart points in chronological order.

## 2026-09-27 — Track creation and handoff

The user requested closing the current track and creating a practical lab track covering:

1. NEN Control Data Center & Factory.
2. EDGE on EC2.

Track-3 is concluded as the current architecture-learning record, not a completed production implementation. Track-4 becomes the active practical continuation.

### Baseline

- NEN architecture covers 1,000+ branch sites, with one or more EDGEs per site.
- Control/factory initial baseline remains FOSS on Ubuntu WSL/KIND; cloud-to-local reachability must be decided first.
- EDGE environment is now EC2 for this lab. VirtualBox remains an alternative, not the active target.
- PKI lab: root certificate details inspected; issuing-CA CSR command understood, but signing/chain verification still pending.
- TPM identity interface, NEN bootstrap integration and NEN-signed Talos on EC2 remain unverified.
- No existing AWS resource or local deployment is assumed active.
- No AWS resources were provisioned during track creation.

### Decisions and evidence boundaries

A Talos EC2 EDGE can exercise the fleet role. Normal AMI launch does not prove Secure Boot, TPM key protection or physical factory acceptance. Lab results and production security claims remain separate.

The previous Track-3A implementation intent continues here as Track-4A. The future AWS-managed central platform is not implicitly selected by moving the EDGE to EC2. Track-2 remains paused.

### Exact safe restart point

Begin [Phase 0](phase-0-baseline.md): one read-only workstation baseline step, then verify AWS context and choose a reachable central endpoint topology before creating resources.

Use [README](README.md) for phase navigation and [open questions](open-topic.md) for blockers.

## 2026-10-04 — AWS Lab Selected Next

The user selected the AWS lab as the next practical track. Track-4B already exists and now starts with standalone Talos on EC2. Fleet activation and control/factory integration follow after a healthy baseline and reachable central endpoint.

IRSA is a later workload-identity exercise. Customer EDGE AI inference is recorded as a planned Track-2 topic. No instance, network or workload was deployed.

Restart with read-only workstation discovery and AWS identity/region verification. Do not assume earlier Track-2 resources are active or reusable.

## 2026-10-04 — Three Learning Tracks

**Request:** Organize the repository README around (1) Talos and Kubernetes theory, (2) solution architecture stories covering scale, security, fleets, AI and supply chain, and (3) projects and labs. Preserve connectivity among documents.

**Decision:** The [root README](../../README.md) is the navigation hub. Existing directory names remain to preserve links and history. Theory is referenced by architecture stories; labs reference both and record their results in live files.

**Project direction:** Bare metal remains preferred for EDGEs, with EC2 used for this lab because physical hardware is unavailable. The data-center control and provisioning project now targets AWS. The older WSL/KIND control plan remains a preparation reference; AWS topology and service choices need revision before deployment. No AWS platform or instance selection is implied by this navigation update.

**Next:** Continue the standalone Talos EC2 baseline, then design AWS control/provisioning and integrate the fleet. Earlier Track-2 connectivity work stays paused. No infrastructure was changed.
