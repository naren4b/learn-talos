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
- [AGENTS.md](AGENTS.md): repo-specific guidance for AI agents
- [README.md](README.md): public-facing overview of the workspace
- [scripts/](scripts/): lightweight automation and repo utilities
- [ai/](ai/): AI bundle metadata and reusable repo guidance
- [private/](private/): private internal working area for scratch notes and active drafts

## Privacy and sharing policy

The private working area under [private/](private/) is intentionally excluded from public sharing. It is meant for internal notes, working drafts, and scratch material that may later be reorganized into the public docs.

The public-facing content should stay in the reusable docs and repo guidance, while private scratch material stays isolated in the private folder.

## Core curriculum

The public learning plan is now in [docs/roadmap.md](docs/roadmap.md). The original root-level objective content has been folded into the modular roadmap so the repo stays clean and shareable.

## Working conventions

- Keep the repo focused on learning outcomes rather than application deployment.
- Prefer markdown notes, checklists, and command examples over generic software scaffolding.
- Use placeholders for infrastructure names, certificates, keys, and endpoints.
- Keep examples production-oriented and operationally realistic.
- Distinguish clearly between Talos API, Kubernetes API, and operational tooling.

## Common entry points

- Start with [docs/roadmap.md](docs/roadmap.md)
- Review [AGENTS.md](AGENTS.md) for repo guidance
- Use [scripts/](scripts/) for small automation tasks
- Use [ai/bundle.yaml](ai/bundle.yaml) for AI bundle metadata
