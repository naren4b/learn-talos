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
