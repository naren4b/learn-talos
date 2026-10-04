# Learn Talos

Learn how Talos Linux and Kubernetes work, design a secure platform for 1 to 1,000+ EDGEs, and test those ideas through practical projects.

## Portfolio context

This repository is evidence for the **Enterprise Platform Architecture** pillar of the portfolio. It supports two underlying workstreams: data-centre/Kubernetes platform modernization and multi-region edge fleet management.

The portfolio taxonomy is intentionally broader than this repository: **Enterprise Platform Architecture → AWS Architecture → AI Platform Engineering → Technical Leadership**. This repo stays focused on Talos, Kubernetes, secure edge architecture, fleet lifecycle and hands-on platform labs.

## Three Learning Tracks

| Track | Purpose | Start here |
| --- | --- | --- |
| **1. Theory — Talos & Kubernetes Fundamentals** | Understand OS startup, networking, APIs, configuration, cluster lifecycle and security | [Fundamentals](docs/track-1-talos-fundamentals/README.md) |
| **2. Solution Architecture Stories** | Explore scale, security, fleet management, AI workloads and the software supply chain | [EDGE architecture](docs/track-2-secure-edge/README.md) and [central platform](docs/track-3-central-edge-platform/README.md) |
| **3. Projects & Labs — Learn by Doing** | Build, verify, troubleshoot and operate the EDGE and its control/provisioning platform | [Lab plan](docs/track-4-nen-control-factory-ec2-lab/README.md) |

These are the three learning tracks. Existing folders retain their earlier Track-1 through Track-4 names so document links and historical records remain usable.

## 1. Theory — Talos & Kubernetes Fundamentals

General explanations live here and are referenced by architecture stories and labs.

- [Learning roadmap](docs/learning-foundations/roadmap.md): curriculum and progression.
- [Fundamentals and topic statuses](docs/track-1-talos-fundamentals/README.md): covered, partial and planned topics.
- [Detailed reference index](docs/track-1-talos-fundamentals/detailed/README.md).
- [General Linux versus Talos boot](docs/track-1-talos-fundamentals/detailed/01-general-linux-boot.md): USB, network installation and Kubernetes startup.
- [PXE, iPXE, TFTP and HTTP](docs/learning-foundations/pxe-ipxe-tftp-http.md).
- [CLI/API mental model](docs/learning-foundations/cli-api-mental-model.md) and [security-artifact lifecycle](docs/learning-foundations/security-artifact-lifecycle.md).
- [Live discussion](docs/track-1-talos-fundamentals/conversation-live.md): questions, answers, extra notes and restart hooks.

## 2. Solution Architecture Stories

Apply the fundamentals to realistic requirements, trust boundaries, failure modes, recovery and Day-2 operations.

| Story | Documents | Status |
| --- | --- | --- |
| Secure EDGE lifecycle and remote management | [EDGE architecture](docs/track-2-secure-edge/README.md), [bootstrap and trust](docs/track-2-secure-edge/sub-topics/02-bootstrap-and-trust.md), [EDGE connectivity](docs/track-2-secure-edge/sub-topics/03-connect-edge-to-central.md) | Notes developed; earlier connectivity PoC paused |
| Scale from one EDGE to 1,000+ sites | [Central platform](docs/track-3-central-edge-platform/README.md) and [use-case index](docs/track-3-central-edge-platform/sub-topics/README.md) | Current architecture round concluded; implementation pending |
| Factory preparation, security and supply chain | [Factory provisioning](docs/track-3-central-edge-platform/sub-topics/01-factory-provisioning.md), [certificate ownership](docs/track-3-central-edge-platform/sub-topics/17-nen-trust-and-certificate-issuance.md), [UKI and boot trust](docs/track-3-central-edge-platform/sub-topics/19-uki-secure-boot-and-pcr.md) | Architecture notes available; security validation and broader supply-chain coverage pending |
| Running AI workloads on customer EDGEs | [AI workload story and blog plan](docs/track-2-secure-edge/sub-topics/05-ai-workloads-on-customer-edge.md) | Planned |
| Control and provisioning services | [Services and endpoints](docs/track-3-central-edge-platform/sub-topics/21-data-center-services-and-endpoints.md) | Architecture reference; AWS lab mapping pending |

Unresolved questions remain in the [architecture open topics](docs/track-3-central-edge-platform/open-topic.md). Historical discussions stay in the [EDGE live record](docs/track-2-secure-edge/track-2-secure-edge-live.md) and [central-platform live record](docs/track-3-central-edge-platform/track-3-central-edge-platform-live.md).

## 3. Projects & Labs — Learn by Doing

| Project | Target | Entry point | Status |
| --- | --- | --- | --- |
| **EDGE Fleet Management** | Bare metal is the preferred deployment model. Use EC2 machines for the current lab because physical hardware is unavailable | [Talos on EC2](docs/track-4-nen-control-factory-ec2-lab/track-4b-edge-on-ec2.md) | Next: standalone node, then fleet integration |
| **Data Center Management — AWS Control & Provisioning** | Host the control and provisioning services on AWS; use local WSL/KIND where useful for preparation | [Control/factory plan](docs/track-4-nen-control-factory-ec2-lab/track-4a-control-and-factory.md) and [central service requirements](docs/track-3-central-edge-platform/sub-topics/21-data-center-services-and-endpoints.md) | Planned; AWS topology and service choices to be designed |

The existing control/factory plan contains the earlier local baseline. AWS is now the target for this project; its detailed hosting plan will be revised before deployment.

Start with [Phase 0: baseline and topology](docs/track-4-nen-control-factory-ec2-lab/phase-0-baseline.md), then bring up one Talos EC2 node. Add central services and fleet integration after that baseline is healthy.

Use the [lab index](docs/track-4-nen-control-factory-ec2-lab/README.md), [live lab record](docs/track-4-nen-control-factory-ec2-lab/track-4-nen-lab-live.md) and [lab open questions](docs/track-4-nen-control-factory-ec2-lab/open-topic.md). The new lab is planned; no deployment is claimed. EC2 tests do not establish bare-metal firmware, TPM or factory acceptance behavior.

## How the Documents Connect

1. Read the **fundamental** to understand the mechanism.
2. Follow the **architecture story** to understand the design and trade-offs.
3. Run the **lab** to test behavior and recovery.
4. Record results in the **live document**, then update the focused topic with verified conclusions.

Keep theory reusable, architecture scenario-focused, and labs tied to observable results. Each lab should link to its prerequisite theory and architecture. Use open-topic files for unresolved questions.

## Repository Guide

| Location | Contents |
| --- | --- |
| [docs/](docs/) | Theory, architecture stories, lab instructions and live records |
| [labs/](labs/) | Hands-on infrastructure and examples, including [fundamentals exercises](labs/track-1-talos-fundamentals/README.md) and [earlier AWS Terraform](labs/track-2-secure-edge/aws/phase0-aws.tf) |
| [scripts/](scripts/) | Setup and automation utilities |
| [AGENTS.md](AGENTS.md) | Repository guidance and validation rules |
| [ai/](ai/) | Reusable AI guidance and bundle metadata |

Work one verified step at a time. Use Mermaid for diagrams and placeholders for commands. Keep credentials, private keys, generated configurations and Terraform state out of Git. Private drafts are excluded from public sharing. Prefer open-source, self-managed components for the fleet platform.
