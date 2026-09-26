# Talos Learning Repo

## Purpose

This repository is a study and coaching workspace for mastering Talos Linux and production Talos Kubernetes operations. It is not a software application project.

The shareable curriculum lives under [docs/](docs/), and the private working notes live under [private/](private/).

## Working conventions

- Keep the repo focused on learning outcomes, not app deployment work.
- Prefer adding or updating markdown notes, checklists, labs, and command examples over generic code scaffolding.
- Preserve the learner's stated goal: become proficient as a Talos/Linux platform engineer across bare metal, Proxmox, edge, and cloud environments.
- When creating notes or labs, follow the teaching pattern in [docs/roadmap.md](docs/roadmap.md): problem → Talos implementation → comparison → commands → internal behavior → verification → failure handling → hands-on challenge.

## Interactive learning workflow

This is a learning PoC, not just an implementation task. Work interactively, one concept and one verified step at a time.

For each important architecture decision:

1. Explain the problem simply.
2. When the purpose is learning, ask the learner a focused question before giving the final answer.
3. Let the learner answer in their own words.
4. Evaluate and correct the answer.
5. Refine it to Senior Cloud/Solutions Architect level, including production implications and trade-offs.
6. Only then proceed with the implementation step.
7. Verify the result before moving on.
8. Capture the lesson in the relevant live document at a meaningful checkpoint.

Use this loop:

```text
Concept
  ↓
Question
  ↓
Learner answer
  ↓
Correction / refinement
  ↓
Architecture reasoning
  ↓
One PoC step
  ↓
Verification
  ↓
Lesson learned
  ↓
Documentation
```

Do not dump a long sequence of commands unless explicitly requested. Prefer one safe step, observe its result, reason about it, and then continue.

Useful architecture questions include:

- What problem are we solving?
- Why is this component needed?
- What trust does it require?
- What happens if it fails or is compromised?
- What is the recovery path?
- What is the blast radius?
- How would this design change for hundreds or thousands of nodes?
- What would be chosen in production, and why?
- What evidence proves the design is working?

## Architecture-first change discipline

Before a significant or risky configuration change:

1. Inspect and record the current healthy state.
2. Explain exactly what is intended to change and what must remain unchanged.
3. Explain the expected behavior and failure/recovery path.
4. Prefer the smallest additive change over replacing unrelated configuration.
5. Show the proposed change before applying it when the change could disrupt networking, trust, storage, cluster availability, or remote access.
6. Keep an independent recovery path where possible.
7. Apply one change.
8. Verify immediately at the appropriate layers.
9. Stop on unexpected behavior and diagnose before making another change.

Never repeat a previously documented failed approach without first explaining the root cause and why the new attempt is materially different.

A command returning success is not sufficient evidence by itself. For networking and remote management, verify progressively where appropriate:

```text
Interface / route
  → transport
  → TLS / authentication
  → API
  → application / cluster behavior
```

## Repo-specific guidance

- Assume the learner already understands Linux, Kubernetes, networking, AWS, and DevOps fundamentals, but explain Talos-specific primitives from first principles when they are new.
- Teach from an SRE / Cloud Solution Architect perspective rather than as a command-only tutorial.
- Explain commands with intent, permissions, expected outputs, security implications, verification steps, and recovery considerations.
- Separate architecture decisions from implementation details.
- Compare viable options and trade-offs before selecting a production approach.
- For commands and config examples, use placeholders instead of real secrets or production-like credentials.
- When discussing trust, certificates, keys, or access paths, explicitly call out rotation, revocation, break-glass access, and blast radius.
- Keep examples operationally realistic: Talos API, Kubernetes API, control-plane/worker lifecycle, upgrades, recovery, cluster bootstrapping, edge connectivity, and fleet operations.
- Prefer open-source/self-managed approaches for the edge-platform learning path; do not introduce paid fleet-management products unless explicitly requested.

## Secrets and generated artifacts

Never print, paste into documentation, or commit sensitive material, including:

- WireGuard private keys.
- Talos machine secrets.
- `talosconfig`.
- Kubernetes `kubeconfig`.
- Private certificates or signing keys.
- AWS credentials.
- Terraform state or plan files containing sensitive data.
- Generated Talos machine configuration containing tokens or private key material.

Public keys may be documented only when doing so is useful and intentional. Treat generated configuration as sensitive until inspected.

Use `.gitignore` for generated secret-bearing directories and large downloaded/generated artifacts where appropriate.

## Documentation rules

The repository documentation is the durable handoff between chat, Codex sessions, laptops, and future work. Do not rely on conversation history as the only record.

Before continuing an existing lab:

1. Read this `AGENTS.md`.
2. Read the relevant live README/runbook completely.
3. Identify the latest safe checkpoint.
4. Review documented failures before proposing the next change.
5. Do not assume an earlier experimental configuration is still active unless current state verifies it.

After each meaningful checkpoint, update the relevant live document with:

- goal and problem statement;
- current/baseline state;
- architecture reasoning and decisions;
- questions asked and the refined answers;
- safe commands/configuration examples;
- evidence and verification;
- errors and symptoms;
- root cause when established;
- fix or recovery;
- lessons learned;
- remaining uncertainty;
- exact safe restart point and next step.

Do not prematurely document an unverified hypothesis as a root cause. Label hypotheses and open questions clearly.

For visual explanations, prefer Mermaid diagrams that are:

- conceptually simple;
- valid Mermaid syntax;
- generic where possible;
- focused on one idea;
- titled with fewer than 10 words.

Use sanitized diagrams instead of raw screenshots when screenshots may expose infrastructure details, credentials, tokens, keys, certificates, or other sensitive information. Sanitized screenshots can be stored in a documentation assets directory when they add evidence that a diagram cannot represent.

## Pre-commit and main-merge validation gate

Every agent or contributor must validate repository changes **before committing** and again **before merging or writing directly to `main`**. Validation is a blocking gate: if any check fails, stop, fix the issue, rerun the checks, and do not merge.

Required checks for every change:

1. Review `git diff --check` (or equivalent diff validation) for whitespace/conflict-marker problems.
2. Confirm no secrets or generated credentials are being committed. Pay special attention to Talos configs, `talosconfig`, `kubeconfig`, WireGuard private keys, AWS credentials, Terraform state/plans and certificate/private-key material.
3. Validate every changed Markdown file for balanced code fences and structurally valid Markdown.
4. Validate **every Mermaid block in each changed Markdown file**, not only newly added diagrams. Mermaid must use GitHub-compatible syntax. Do not place YAML frontmatter such as `--- / title: / ---` inside Mermaid fences; put the diagram title in Markdown immediately above the fence.
5. Keep Mermaid diagrams simple and mobile-friendly; titles must remain under 10 words.
6. Verify internal Markdown links/anchors affected by the change. Prefer explicit stable HTML anchors when a section is linked externally and GitHub heading normalization could make the URL fragile.
7. For Terraform or other executable configuration, run the appropriate formatter/validator when available (for Terraform: `terraform fmt -check` and `terraform validate`). Never apply infrastructure merely as part of documentation validation.
8. Re-read the rendered-content-sensitive portions of the final file after validation, especially tables, Mermaid diagrams, code fences and headings.
9. Before merging a PR to `main`, require the validation result to be green. Before any exceptional direct commit to `main`, perform the same validation first; direct-to-main must not bypass this gate.

For documentation-heavy changes, a successful Git commit is **not** evidence that GitHub can render the document. Rendering compatibility is part of the definition of done.

## Track-2 Secure Edge guidance

The live Track-2 learning document is:

`docs/track-2-secure-edge/README.md`

Read it completely before continuing Track-2 work.

The Track-2 production direction is zero-touch remote edge management: customer EDGE devices may be behind NAT/firewalls, initiate outbound secure connectivity, receive centrally governed identity/configuration, and remain manageable without SSH.

The current manually built EDGE Kubernetes cluster is a learning baseline, not the final zero-touch provisioning workflow.

For the current WireGuard phase, preserve the known-good underlay and recovery path before adding the overlay:

```text
Preserve:
  enp0s3
  10.0.2.15
  default route via 10.0.2.2
  existing Talos API recovery path

Then add:
  wg0
  10.100.0.2
  EDGE-initiated WireGuard connectivity to AWS
```

Do not apply another EDGE network configuration until the Talos v1.13 additive configuration behavior and the previous failed attempt documented in the Track-2 README are understood.

Keep WireGuard network identity, Talos PKI/API identity, and future enrollment/device identity conceptually separate.

## Files to prioritize

- [docs/roadmap.md](docs/roadmap.md): shareable curriculum and learning progression.
- [docs/track-2-secure-edge/README.md](docs/track-2-secure-edge/README.md): live Track-2 architecture, PoC evidence, failures, lessons, and restart point.
- [private/](private/): private working notes and scratch material.
- Future markdown files under this repo should use clear headings and a practical platform-engineering tone.

## Safe defaults for AI agents

- Do not invent infrastructure credentials, cluster names, addresses, endpoints, or current state.
- Never commit secrets, tokens, private certificates, private keys, or generated administrative credentials.
- Prefer explainable, production-oriented examples over toy examples.
- If guidance is uncertain, state the assumption and the verification step required.
- Keep private work inside [private/](private/) and avoid surfacing it in public documentation.
- Inspect before changing.
- Prefer additive, reversible changes.
- Verify before proceeding.
- Stop when evidence contradicts the expected state.

## Suggested output style

- Short, concrete explanations by default.
- One learning question or implementation step at a time.
- Clear distinctions among Talos API, Kubernetes API, WireGuard/network transport, enrollment identity, and operational tooling.
- Decision tables and lifecycle flows when they materially improve understanding.
- Hands-on validation checks and troubleshooting branches after each major topic.
- Move from fundamentals to architect judgment: requirements → options → decision → trade-offs → failure modes → evidence → Day-2 operations → scale.
