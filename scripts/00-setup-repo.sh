#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$ROOT_DIR/ai" "$ROOT_DIR/scripts"

cat > "$ROOT_DIR/README.md" <<'EOF'
# Talos Learning Repository

This repository is a study workspace for becoming a strong Talos Linux and Talos Kubernetes platform engineer.

## Goal

The primary source of truth is [Objective.txt](Objective.txt). It defines the learning path and the expected teaching pattern:

- problem
- Talos implementation
- comparison with traditional Linux/Kubernetes patterns
- commands and flags
- internal behavior
- verification
- failure handling
- hands-on challenge

## Repo structure

- [Objective.txt](Objective.txt): learning curriculum and progression plan
- [AGENTS.md](AGENTS.md): repo-specific guidance for AI agents
- [README.md](README.md): public-facing overview of the workspace
- [scripts/](scripts/): lightweight automation and repo utilities
- [ai/](ai/): AI bundle metadata and reusable repo guidance
- [current-notes](current-notes): private working notes; not for sharing

## Privacy and sharing policy

The file [current-notes](current-notes) is intentionally private and excluded from distribution or public sharing. It is only for internal working memory and can be referenced, reorganized, and expanded from within the repo.

The public-facing content should live in the repo files above, while private scratch material stays isolated in the private note file.

## Working conventions

- Keep the repo focused on learning outcomes rather than application deployment.
- Prefer markdown notes, checklists, and command examples over generic software scaffolding.
- Use placeholders for infrastructure names, certificates, keys, and endpoints.
- Keep examples production-oriented and operationally realistic.
- Distinguish clearly between Talos API, Kubernetes API, and operational tooling.

## Common entry points

- Start with [Objective.txt](Objective.txt)
- Review [AGENTS.md](AGENTS.md) for repo guidance
- Use [scripts/](scripts/) for small automation tasks
- Use [ai/bundle.yaml](ai/bundle.yaml) for AI bundle metadata
EOF

cat > "$ROOT_DIR/ai/bundle.yaml" <<'EOF'
name: talos-learning-bundle
version: 1.0.0
kind: ai-bundle
summary: Talos Linux and Talos Kubernetes learning guidance for platform engineering work.
private_notes:
  - current-notes
public_sources:
  - Objective.txt
  - AGENTS.md
  - README.md
  - scripts/
repo:
  purpose: study-and-coaching-workspace
  goal: become proficient as a Talos/Linux platform engineer across bare metal, Proxmox, and cloud environments
  source_of_truth: Objective.txt
  private_working_file: current-notes
  safe_defaults:
    - do not invent infrastructure credentials or real endpoints
    - never commit secrets, tokens, certificates, or private keys
    - prefer production-oriented examples over toy examples
    - keep private notes out of public sharing flows
  teaching_pattern:
    - problem
    - Talos implementation
    - comparison
    - commands
    - internal behavior
    - verification
    - failure handling
    - hands-on challenge
  focus_areas:
    - Talos architecture
    - cluster lifecycle
    - security artifacts and trust
    - install and upgrade patterns
    - Proxmox, bare metal, and cloud operations
    - incident response and troubleshooting
EOF

chmod +x "$ROOT_DIR/scripts/00-setup-repo.sh"

echo "Repository scaffolding ready."
echo "Public docs: README.md, AGENTS.md, Objective.txt"
echo "Private scratchpad: current-notes"
echo "AI bundle: ai/bundle.yaml"
