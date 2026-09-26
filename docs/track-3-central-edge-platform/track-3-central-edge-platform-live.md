# Track-3 — Central Management Platform for 1,000+ EDGE Sites — Live Record

This file is the chronological, transcript-like record for Track-3.

**Append-only rule:** after creation, never rewrite, reorder, restructure or
clean up historical entries. Record corrections and changed understanding as
new dated checkpoints.

---

## 2026-09-26 — Track-3 creation and context switch

### Decision

Create a separate Track-3 for the central management platform that will
control and operate 1,000+ EDGE sites on customer premises.

Track-2 and Track-3 have different viewpoints:

- Track-2 asks how an EDGE is built, trusted, connected and managed securely.
- Track-3 asks how the central platform enrolls, governs, observes and operates
  the fleet at scale.

Track-2 is paused, not completed. Point 24, Container Strategy, remains
unfinished. Track-2 will resume after Track-3A so that the central platform
responsibilities are understood before the EDGE-side journey continues.

### Track split

```text
Track-3 — Central Management Platform for 1,000+ EDGE Sites

├── Track-3A — FOSS reference implementation
│   └── Local Ubuntu WSL + KIND
│
└── Track-3B — AWS production implementation
    └── Amazon EKS + appropriate AWS managed services
```

Track-3A is implemented locally, but the architecture and theory remain
production-grade for 1,000+ EDGE sites. KIND is only the hands-on environment;
it is not permission to simplify production requirements, failure modes,
security boundaries, availability, recovery or Day-2 operational reasoning.

### Initial component direction

The FOSS direction discussed includes KIND/Kubernetes, Cilium, Hubble, Gateway
API, Argo CD, PostgreSQL, OpenBao, Prometheus, Grafana OSS, Loki,
OpenTelemetry, Tempo, Harbor, Trivy, Syft, Cosign, Kyverno and k6 OSS.

OpenBao is preferred over current HashiCorp Vault for the strict FOSS reference
path. This list is not an installation checklist. Requirements and architecture
come first; components are added incrementally only when their responsibilities
and trade-offs justify them.

### Safe start point

Begin Track-3A with requirements and architecture for the production-scale
central platform. Define capabilities, trust boundaries, data flows, failure
domains, recovery objectives, evidence and scale assumptions before installing
KIND or any platform component.
