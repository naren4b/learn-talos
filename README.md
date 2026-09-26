# Talos Learning Repository

This repository is a study workspace for becoming a strong Talos Linux and Talos Kubernetes platform engineer.

## Goal

The public curriculum is organized into modular docs under [docs/](docs/). The learning flow follows the teaching pattern:

- problem
- Talos implementation
- comparison with traditional Linux/Kubernetes patterns
- commands and flags
- internal behavior
- verification
- failure handling
- hands-on challenge

## Repo structure

- [docs/](docs/): shareable learning curriculum and roadmap
- [labs/](labs/): reproducible hands-on lab infrastructure and examples
- [AGENTS.md](AGENTS.md): repo-specific guidance for AI agents
- [README.md](README.md): public-facing overview of the workspace
- [scripts/](scripts/): lightweight automation and repo utilities
- [ai/](ai/): AI bundle metadata and reusable repo guidance
- [private/](private/): private internal working area for scratch notes and active drafts

## Privacy and sharing policy

The private working area under [private/](private/) is intentionally excluded from public sharing. It is meant for internal notes, working drafts, and scratch material that may later be reorganized into the public docs.

The public-facing content should stay in the reusable docs and repo guidance, while private scratch material stays isolated in the private folder.

## Core curriculum

The public learning plan is now in [docs/learning-foundations/roadmap.md](docs/learning-foundations/roadmap.md). The original root-level objective content has been folded into the modular roadmap so the repo stays clean and shareable.

## Secure zero-touch edge track

Track 2 studies how a Talos edge appliance can be prepared centrally,
shipped cold, enrolled across the Internet and managed without SSH.

- [Track-2 architecture and phase plan](docs/track-2-secure-edge/README.md)
- [Phase 0 setup](docs/track-2-secure-edge/phase-0-setup.md)
- [Phase 0 AWS Terraform](labs/track-2-secure-edge/aws/phase0-aws.tf)
- [Ubuntu WSL bootstrap](scripts/track-2/setup-wsl.sh)

The implementation uses open-source and self-managed components. It does
not depend on Omni or another paid fleet-management platform.

## Central EDGE platform track

Track 3 designs the central management platform needed to operate 1,000+
customer-premise EDGE sites. It begins with a local FOSS reference
implementation and later maps the same production-grade architecture to AWS.

- [Track-3 central EDGE platform](docs/track-3-central-edge-platform/README.md)

## Working conventions

- Keep the repo focused on learning outcomes rather than application deployment.
- Prefer markdown notes, checklists, and command examples over generic software scaffolding.
- Use placeholders for infrastructure names, certificates, keys, and endpoints.
- Keep examples production-oriented and operationally realistic.
- Distinguish clearly between Talos API, Kubernetes API, and operational tooling.

## Common entry points

- Start with [docs/learning-foundations/roadmap.md](docs/learning-foundations/roadmap.md)
- Review [AGENTS.md](AGENTS.md) for repo guidance
- Use [scripts/](scripts/) for small automation tasks
- Use [ai/bundle.yaml](ai/bundle.yaml) for AI bundle metadata
