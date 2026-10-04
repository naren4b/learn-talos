# Talos Detailed Learning Notes

**Round 1: USB boot, configuration and API trust.** Revision checkpoint: 2026-10-04. Revisit fundamentals before starting the lab, one topic at a time.

| Order | Topic |
| --- | --- |
| 1 | [General Linux and Talos boot comparison](01-general-linux-boot.md): scenario 1.1 USB, scenario 1.2 network, section 1.3 distant sites, section 1.4 USB versus network boot |
| 3 | [Common behavior, differences, steps 11 and 21](03-configuration-and-api-authentication.md), **unapproved draft** |
| 4 | [Security, break-glass and lost keys](04-security-break-glass-and-lost-keys.md), **unapproved draft** |

[Parent: Track-1](../README.md) · [Lab: Track-4](../../track-4-nen-control-factory-ec2-lab/README.md)

The four sequences compare typical Linux installation with Talos installation and Kubernetes initialization. They are not equivalent endpoints: general Linux is ready before any separate Kubernetes installation.

Technical references use Talos v1.14 documentation checked on 2026-10-04. Pin and recheck the actual release before executing a lab. No infrastructure or credentials were changed.

## Agreed next rounds

| Round | Scope | Timing |
| --- | --- | --- |
| 1 | USB boot, machine configuration, API trust, security and recovery | Current revision |
| 2 | Network boot and how its artifact flow differs from USB | After Round 1 questions are clear |
| 3 | DHCP, Matchbox and Squid responsibilities and whether each is needed | After network boot fundamentals |
| 4 | Remote sites behind NAT and EDGE-initiated management | After provisioning services |

Proceed one concept and one question at a time. These are learning topics, not a decision to deploy every named component. Practical lab work resumes after the prerequisite doubts are resolved.

Scenario 1.2 now includes the complete network installation sequences as a review draft. Teaching still proceeds one question at a time; completion of the draft does not imply learner approval.

Questions, answers and extra notes belong in the [live discussion](../track-1-talos-fundamentals-live.md). Detailed pages remain focused on their topics.

Section 1.3 introduces the branch-to-NEN boot path and DHCP, iPXE, Matchbox and Squid responsibilities. It is a review draft; practical setup remains pending.
