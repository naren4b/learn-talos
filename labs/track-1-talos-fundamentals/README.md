# Track 1 — Talos Fundamentals Labs

These labs support the Track-1 Talos fundamentals curriculum in `docs/roadmap.md`.

The purpose of Track 1 is to understand Talos itself before applying it to the Secure EDGE architecture in Track 2.

## Learning path

```text
Talos mental model
        ↓
Talos API and CLI
        ↓
Machine configuration
        ↓
Cluster bootstrap
        ↓
Security and PKI
        ↓
Networking and storage
        ↓
Lifecycle operations
        ↓
Troubleshooting
```

## Planned labs

| Lab | Fundamental | Goal |
| --- | --- | --- |
| 01 | Talos machine | Boot Talos and identify maintenance vs configured state |
| 02 | talosctl and API | Understand endpoints, nodes, talosconfig and API access |
| 03 | Machine configuration | Generate, inspect, patch and safely apply configuration |
| 04 | Cluster bootstrap | Build a small Talos Kubernetes cluster and bootstrap etcd |
| 05 | Kubernetes access | Retrieve kubeconfig and separate Talos API from Kubernetes API |
| 06 | PKI and credentials | Identify certificates, keys, trust boundaries and sensitive artifacts |
| 07 | Networking | Inspect links, addresses, routes, DNS and Kubernetes networking |
| 08 | Storage | Inspect disks and understand persistent vs disposable state |
| 09 | Lifecycle | Practice health checks, configuration change and upgrade concepts |
| 10 | Troubleshooting | Diagnose failures without SSH using Talos APIs and evidence |

## Lab rules

- Use Ubuntu WSL as the working shell unless a lab explicitly requires another environment.
- Prefer open-source/self-managed Talos capabilities; do not make Omni or another paid fleet manager a dependency.
- Explain the problem and mental model before commands.
- Use one safe, verifiable lab step at a time.
- Identify destructive operations before running them.
- Do not commit `talosconfig`, `kubeconfig`, generated machine secrets, private keys, credentials, Terraform state, or other sensitive/generated artifacts.
- Record important failures and fixes because they are part of the learning journey.
- Keep detailed live learning history safe; concise lab notes and mental models supplement it rather than replacing it.

## Relationship to Track 2

Track 1 answers:

> How does Talos work?

Track 2 applies those fundamentals to:

> How do I build and operate a secure Talos Kubernetes appliance at a remote EDGE site?

Track-2 labs live in:

`labs/track-2-secure-edge/`

## Source learning material

- Track-1 entry: `docs/track-1-talos-fundamentals/README.md`
- Detailed curriculum: `docs/roadmap.md`
- Next track: `docs/track-2-secure-edge/`

Individual lab directories should be created as the corresponding fundamental is studied rather than pre-populating command-heavy exercises before the learning session.
