# Talos Learning Repo

## Purpose
This repository is a study and coaching workspace for mastering Talos Linux and production Talos Kubernetes operations. It is not a software application project.

The shareable curriculum lives under [docs/](docs/), and the private working notes live under [private/](private/).

## Working conventions
- Keep the repo focused on learning outcomes, not app deployment work.
- Prefer adding or updating markdown notes, checklists, labs, and command examples over generic code scaffolding.
- Preserve the learner's stated goal: become proficient as a Talos/Linux platform engineer across bare metal, Proxmox, and cloud environments.
- When creating notes or labs, follow the teaching pattern in [docs/roadmap.md](docs/roadmap.md): problem → Talos implementation → comparison → commands → internal behavior → verification → failure handling → hands-on challenge.

## Repo-specific guidance
- Assume the user already understands Linux, Kubernetes, networking, and DevOps fundamentals.
- Teach from an SRE / Cloud Solution Architect perspective, not as a beginner tutorial.
- Explain commands with intent, permissions, outputs, security implications, and verification steps.
- For commands and config examples, use placeholders instead of real secrets or production-like credentials.
- When discussing trust, certificates, keys, or access paths, explicitly call out rotation, revocation, break-glass access, and blast radius.
- Keep examples operationally realistic: Talos API, Kubernetes API, control-plane/worker lifecycle, upgrades, recovery, and cluster bootstrapping.

## Files to prioritize
- [docs/roadmap.md](docs/roadmap.md): shareable curriculum and learning progression.
- [private/](private/): private working notes and scratch material.
- Any future markdown files under this repo: use clear headings and a practical, platform-engineering tone.

## Safe defaults for AI agents
- Do not invent infrastructure credentials, cluster names, or real endpoints.
- Never commit secrets, tokens, certificates, or private keys.
- Prefer explainable, production-oriented examples over toy examples.
- If guidance is uncertain, state the assumption and the verification step required.
- Keep private work inside [private/](private/) and avoid surfacing it in public documentation.

## Suggested output style
- Short, concrete explanations.
- Clear distinctions among Talos API, Kubernetes API, and operational tooling.
- Decision tables and lifecycle flows when the concept benefits from them.
- Hands-on labs, validation checks, and troubleshooting branches after each major topic.
