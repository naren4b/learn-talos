# Security, Break-Glass and Lost Keys

**Status: Draft, not approved by the learner. Pending discussion.**

Parent: [Detailed notes](README.md). Previous: [API authentication](03-configuration-and-api-authentication.md). Lab: [Track-4](../../track-4-nen-control-factory-ec2-lab/README.md).

## What could compromise security?

| Failure | Consequence | Control |
| --- | --- | --- |
| Untrusted host reaches maintenance API | Attacker applies the initial machine configuration | Isolated staging network and restricted reachability |
| Secret-bearing configuration leaks | Cluster trust or administrative credentials exposed | Encrypt backups and tightly control access |
| Admin workstation is compromised | Attacker uses available credentials | Protect workstation and issue least-privilege credentials |
| Privileged workload or excessive host access | Application compromise can reach host resources | Pod security, restricted mounts and network policy |
| Vulnerable OS or runtime remains deployed | Known flaws remain exploitable | Qualified updates and security-advisory response |
| Storage or firmware is tampered with | Data disclosure or altered boot | Tested encryption, boot trust and physical controls |

A public API does not automatically bypass mutual TLS, but unnecessary exposure increases attack surface. Secure Boot does not validate every future API request. No SSH does not make credentials, workloads or hardware immune to compromise.

Sources: [Security checklist](https://docs.siderolabs.com/talos/v1.14/security/talos-security-checklist), [maintenance exposure](https://docs.siderolabs.com/talos/v1.14/getting-started/getting-started).

## What is break-glass?

**Break-glass is a prepared emergency access and recovery procedure used when normal administration fails.** It is an operational arrangement, not a Talos master password.

Example: your daily laptop is lost, but an authorized custodian can retrieve a protected recovery credential from a separate store, access the management network, and issue replacement credentials.

Proposed NEN procedure:

1. Declare the incident and identify the affected trust system.
2. Authorize emergency access and record who uses it.
3. Retrieve the protected recovery material through an independent access path.
4. Restore only the access needed for repair.
5. Verify the result and contain any exposed credentials.
6. Return recovery material to controlled custody and review the incident.

Keep emergency access usable during the failure it is intended to solve. A recovery secret stored only inside the inaccessible cluster is insufficient. Test expiry, retrieval and management-network access periodically.

Break-glass does not mean silently disabling Secure Boot, wiping STATE or making the maintenance API public. Do not treat booting a USB as a guaranteed non-destructive authentication bypass. Recovery depends on firmware policy, storage access, encryption and the selected Talos version.

## What if I lose my keys?

First distinguish **lost** from **possibly stolen**. Losing your local file does not normally stop the running cluster. Theft requires containment as well as replacement.

| What is lost? | Recovery direction |
| --- | --- |
| Local talosconfig only | Restore a protected copy, or use another valid Talos admin credential to issue a replacement |
| All client credentials, but original secrets bundle retained | Generate a new talosconfig using the original bundle |
| Client credentials and bundle, but original control-plane config retained | Its Talos API CA signing material can support credential regeneration |
| kubeconfig only, Talos admin access retained | Retrieve a new kubeconfig through Talos |
| All usable management credentials and all recoverable signing material | No universal password reset; assess authorized recovery or rebuild from tested backups |

These credential recovery methods are documented in [certificate management](https://docs.siderolabs.com/talos/v1.14/security/cert-management). Protect any extracted signer material; no extraction or recovery command is being run here.

Generating unrelated new secrets will not authenticate to the existing node. Keeping only a public certificate cannot recreate its private key.

## Other keys have different consequences

| Key or material | Consequence of loss |
| --- | --- |
| Talos CA signing key backup | Existing access may still work; assess remaining trusted copies and plan controlled recovery/rotation |
| NEN EDGE identity private key | Re-enroll under a new key and certificate after identity verification; a public certificate cannot restore the key |
| Disk-unlock material or TPM state | Without an alternative configured unlock path or recoverable backup, encrypted data may be inaccessible |
| Boot-signing private key | Existing signed images may still boot; signing future images requires planned trust/key rotation |
| NEN Root CA private key | A separate PKI recovery event affecting future subordinate issuance; not solved by replacing talosconfig |

Disk keys, application backups and cluster API credentials serve different purposes. An etcd snapshot does not back up application persistent-volume contents. Plan both cluster-state and application-data restoration.

## If a credential was stolen

A newly issued credential does not automatically invalidate the stolen one. Talos documents CA rotation as a way to remove trust in leaked client credentials. Plan the transition, refresh affected credentials, remove old trust and verify access. Keep secrets backups aligned with the new CA. Do not improvise a CRL-based revocation flow or assume deleting a local file revokes access.

Source: [CA rotation](https://docs.siderolabs.com/talos/v1.14/security/ca-rotation).

## Our next learning checkpoint

Explain the difference between controlplane.yaml, talosconfig and kubeconfig before attempting recovery commands. Our NEN TPM enrollment interface and EC2 Secure Boot recovery method remain open implementation questions. These notes establish the concepts; they do not claim a successful recovery test.
