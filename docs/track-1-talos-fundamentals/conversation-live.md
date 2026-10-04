# Talos Conversation Live

This is a chronological discussion record. Earlier exchanges are summarized in their visible order because a complete verbatim transcript is not available. Dated revision entries below retain the existing live notes. A summary does not imply that the learner approved a topic.

## Earlier Discussion: Fleet Provisioning and Trust

1. **Document structure:** Each use case needed its own Markdown subtopic. The live document was to follow the discussion, while topic files and README indexes were updated as requested.
2. **Provisioning steps:** We numbered the steps and discussed factory networking, USB versus PXE, provisioning stations, jobs and Talos machine configuration.
3. **Diagrams:** All diagrams were to use Mermaid. Mobile layouts should run top-down; laptop layouts could run left-to-right. Broken factory and Talos sequences needed correction.
4. **Research rule:** Check the Internet when unsure; if uncertainty remains, say “NO IDEA”. Use the latest Talos as the working assumption.
5. **TPM identity:** We discussed reading TPM information in maintenance mode. The user supplied OneUptime's TPM article and SideroLabs' disk-encryption guide. Unresolved questions were parked with TODO question tags in open-topic.md rather than treated as solved.
6. **Factory and branch phases:** The discussion separated factory preparation from customer power-on. NEN public trust, EDGE key generation, inventory registration and later site configuration were explored.
7. **Certificates:** We distinguished public certificates from private keys, root CA from issuing CA, certificate signing from proof of possession, and why presenting a certificate alone is insufficient.
8. **Fleet operations:** We continued through data-centre responsibilities, upgrades, operational services and a FOSS implementation using Ubuntu WSL and KIND. Production architecture was not to be simplified just because the lab used KIND.
9. **PKI commands:** Commands were followed one at a time. An encrypted RSA key attempt failed because the passphrase was too short. The user later showed a self-signed NEN Root CA certificate and said the commands were understood.
10. **Boot trust:** We explained UKI, Secure Boot, signing keys and PCRs. The user asked whether certificates and UKI could be prepared without EDGEs present, and what gets written to SSD before shipping.
11. **Factory overview:** The user requested a full block diagram and sequence from preparation through cold hardware modification and testing. The factory provisioning sequence needed a rendering fix.
12. **Track closure and lab:** The theory track was closed and separate practical tracks requested for NEN control/factory and an EC2 EDGE. A SideroLabs security article was supplied for comparison, followed by a request for an audio brief.

Those fleet-specific topics belong in the separate architecture documents. They are retained here as conversation history, not added to the general boot reference.

## Revision Discussion: OS Startup and Talos

1. **Revision before the lab:** The user wanted to revisit doubts slowly, following the session-start rules, and first requested only a comparison of general OS boot and cold-hardware Talos single-node startup.
2. **Broken diagram:** The Talos sequence did not load. The user asked for both diagrams in the detailed directory.
3. **Configuration and authentication:** Questions focused on step 11, what configuration does, and step 21, how the configured API differs from maintenance mode. Security, break-glass and lost-key questions were also raised.
4. **Networking:** The user asked for a one-line explanation of obtaining an address, its purpose and whether general Linux has the same step.
5. **Learning rounds:** USB was Round 1; network boot would follow, then DHCP, Matchbox and Squid, and later remote NAT.
6. **Combined document:** The user requested merging the Linux and Talos boot pages into one comparison. Documents 03 and 04 were explicitly not approved.
7. **Clarity:** The user asked to replace a dense caveat paragraph with clear step explanations.
8. **Scenario structure:** The comparison was organized around USB and network as the first boot medium.

## Detailed Revision Entries

This live document records questions, answers and extra notes from the discussion. Detailed documents explain each topic without the conversation history. Earlier discussions are summarized only where needed for continuity; this is not a verbatim transcript.

## 2026-10-04: PR 3 completion

**Question:** We are trying to make documents based on scenarios: General Linux and Talos Boot Comparison, where USB is the medium and where network is the medium.

**Answer:** The combined detailed document uses scenario 1.1 for USB and scenario 1.2 for network boot. Each compares general Linux with Talos from a blank disk to installed SSD boot. The Talos path continues through single-node Kubernetes initialization and readiness.

**Rule from the user:** The live document follows the chat, including questions, answers and extra notes. Detailed documents stay focused on the topic.

**Question:** Complete PR 3. Describe in bullet points the steps that differ from general Linux. Scenario 1.2 is incomplete; its sequence diagram must be complete.

**Answer:** Scenario 1.2 now contains both complete installation sequences, including preparation, firmware network boot, loader and kernel delivery, runtime networking, installation, reboot and SSD boot. Talos continues through authenticated API access, one-time bootstrap, Kubernetes networking and readiness checks. Numbered bullets explain Talos-specific behavior in both scenarios.

**Earlier question carried forward:** What configuration is applied in USB step 11, why is it needed, and what happens behind the scenes?

**Answer:** The control-plane machine configuration declares the installation disk and image, node role, networking, Kubernetes endpoint and cluster trust material. Talos uses it to install and configure the node, and saves it for subsequent boots. The administrator retains separate client credentials in talosconfig.

**Earlier question carried forward:** What changes when USB step 21 says authenticated API?

**Answer:** Configured trust replaces unauthenticated maintenance access. Mutual TLS verifies server and client identities, including proof of possession of the client's private key; role authorization controls operations. Reboot is not what creates trust, and insecure flags do not bypass configured authentication.

**Extra notes:**

- Diagram arrows express dependencies. Downloads and service startup can overlap.
- USB initially runs Talos in RAM. Prepare SSD boot priority and remove or unmount installation media according to the guide before configuration starts installation and automatic reboot.
- Network boot can fetch configuration through talos.config; without a configuration source, Talos enters maintenance mode.
- DHCP or a MAC address does not establish a trusted machine identity.
- Bootstrap is only for initial cluster creation. Single-node Kubernetes has no node-level availability redundancy.
- Documents 03 and 04 remain unapproved drafts.
- This update completes the requested documentation draft. It does not record learner approval, merge the PR or begin the lab.

Detailed topic: [General Linux and Talos Boot Comparison](detailed/01-general-linux-boot.md).

## 2026-10-04: Writing style

**Feedback:** Use “Notes”, not “Numbered Step Notes”. Keep the writing natural, like a human explanation.

**Response:** Changed both headings to “Notes”, removed repeated labels such as “Talos difference” from the bullets, and simplified the introductory paragraphs. Step references and diagrams are preserved.

## 2026-10-04: Bootloader notes

**Request:** Add the supplied explanation of bootloaders as notes, including their duties, examples and place in the boot process.

**Response:** Added the explanation under “Notes” in the boot comparison. Kept the definition, duties, bootloader table and startup steps. Replaced broad claims about defaults and speed with simpler descriptions, removed the unrelated closing question and generic numbered references, and added official references. Included Talos v1.14's UEFI systemd-boot and UKI path and legacy BIOS GRUB path.

## 2026-10-04: Network boot miles apart

**Question:** Create section 1.3 explaining how an EDGE boots miles away from the network point of view, what is needed, and the roles of iPXE, DHCP, Matchbox and Squid.

**Answer:** Added a branch-to-NEN sequence and a service-role table. The illustrated path uses local DHCP and initial loader delivery, then outbound WAN downloads through the customer's gateway. Central DHCP needs an explicitly configured relay and routed connectivity. Talos's own VPN cannot carry pre-OS boot traffic. Matchbox selects boot profiles; Squid is an optional proxy/cache, not a bootloader. Included alternatives for router VPNs, iPXE USB and already installed SSDs, plus trust and WAN dependencies.

**Status:** Documentation draft added to PR 3. No lab deployment or learner approval recorded.

## 2026-10-04: USB versus network boot

**Question:** Add section 1.4 explaining the differences between network boot and USB boot in Talos OS.

**Answer:** Added a comparison table and notes. USB supplies the initial boot files locally; network boot downloads them and needs networking before Talos starts. Configuration delivery is a separate choice. Both can start in maintenance mode, install the same Talos system to SSD, and use the same Kubernetes bootstrap process. USB alone does not provide an offline installation.

## 2026-10-04: DHCP reference and upgrades

**Request:** Add the DHCP video https://youtu.be/IUOVSIKj6GU, leave a hook to the next topic, and explain Talos upgrades simply for USB and network installations.

**Answer:** Added the video as a user-supplied reference and a short DHCP explanation. Both SSD-installed cases use authenticated API upgrades; neither requires repeating installation media boot. Changing PXE files does not upgrade existing SSD installations. Added upgrade steps and a lead-in to DHCP address assignment and iPXE discovery.

**Reference note:** The video could not be retrieved for review; its content was not summarized or used as technical evidence. Upgrade notes were checked against official Talos v1.14 documentation.

## 2026-10-04: Keep the Reference Lightweight

**Request:** Remove the NEN perspective from this document. Keep it as a general academic reference for how operating systems come to life, especially Talos and the modern stack. Create conversation-live.md for the chronological discussion.

**Response:** Shortened the reference, preserved the complete USB and network sequences, replaced the fleet layout with general network-service notes, and added a compact modern-stack table. The conversation record retains earlier live entries and adds the earlier discussion in order as a summary.

**Next topic:** DHCP address assignment, boot-service discovery and iPXE.

## 2026-10-04: Consolidate Fundamentals

**Request:** Preserve the full contents of documents 03 and 04 in this live record, remove the separate files and update indexes. The series is the reference for fundamental, theoretical and basic OS, Talos, booting and security topics; other documents should link here.

**Response:** The earlier summaries did not contain the complete drafts. Both are retained below, with navigation links adjusted for their new location. Their draft status is historical and does not imply approval of their technical content. Future focused notes will be added to the fundamentals series as the discussion develops.

<a id="archived-03"></a>

## Archived Draft 03

Original file: `03-configuration-and-api-authentication.md`. Full text preserved; headings and relative navigation adapted to this file.

### Configuration and API Authentication

**Status: Draft, not approved by the learner. Pending discussion.**

Parent: [Detailed notes](detailed/README.md). Previous: [Combined boot comparison](detailed/01-general-linux-boot.md). Next: [Security and recovery](#archived-04).

#### Common boot foundations

Both systems initialize hardware, start a loader and Linux kernel, use initramfs for early startup, discover devices and start services. Installation prepares persistent storage; subsequent boots reuse that installation. Both need trustworthy artifacts and protected administrative access.

#### What differs

| Area | Typical general Linux | Talos in this sequence |
| --- | --- | --- |
| Initial setup | Installer prompts or unattended answer file | Declarative machine configuration through an API |
| OS service management | Commonly systemd and distribution tooling | Talos machined and purpose-built controllers |
| Administration | Local login, SSH or automation as configured | talosctl against the Talos API |
| Intended workload | General applications; Kubernetes optional | Kubernetes-focused operating system |
| Desired settings | Often spread across packages and files | Machine configuration drives supported settings |
| Cluster creation | Separate Kubernetes setup | Talos configures components; bootstrap initializes etcd |
| Trust | Varies by service and distribution | Talos API client certificates and API roles |

Talos API and Kubernetes API are separate. A Kubernetes permission does not automatically grant Talos OS administration. Talos security also does not establish application security.

Sources: [Components](https://docs.siderolabs.com/talos/v1.14/learn-more/components), [Talos RBAC](https://docs.siderolabs.com/talos/v1.14/security/rbac).

#### Step 5: Obtain network settings

**One line:** Talos typically requests an IP address, gateway and DNS settings from DHCP so the administrator can reach its API and the node can reach required image services.

DHCP is a network service, often provided by a router or factory server. Talos brings up a supported network interface and requests settings. An address identifies the node on its network; a gateway reaches other networks; DNS resolves registry names. Communication on the same subnet does not inherently require a gateway. DHCP does not prove the device identity or authorize provisioning.

General Linux has the same network-configuration need, usually handled during its installer or normal boot. It was omitted from the earlier simplified diagram and is now shown. A general Linux installer with all packages locally available can work offline. Our Talos example uses remote API configuration and a registry, so it requires the appropriate network reachability. Air-gapped Talos uses reachable local services, not necessarily the Internet. Static or platform-provided boot networking is an alternative when DHCP is unavailable; its exact setup belongs to the lab.

#### Step 11: Which configuration?

It is the node's **machine configuration**, conventionally named controlplane.yaml. It describes the intended role, installation and cluster settings. It is not the workstation's talosconfig file.

| Configuration input | Why Talos needs it |
| --- | --- |
| Control-plane role | Select the services this node must run |
| Installation disk and installer image | Select where and what to install |
| Network settings | Establish node and cluster communication |
| Kubernetes endpoint | Identify the cluster API address |
| Talos and Kubernetes trust material | Establish separate administrative and cluster trust |
| Cluster credentials and settings | Configure cooperating Kubernetes components |
| Workload scheduling on control plane | Permit applications on the only node |

A generic ISO cannot know your target disk, cluster identity or desired network. Generated control-plane configuration can contain CA private keys and other credentials. Treat the complete file as a secret, even though some individual settings are public.

For the v1.14 configuration described by the current guide, remove the control-plane NoSchedule taint through KubeNodeConfig. Earlier releases used allowSchedulingOnControlPlanes. Generate configuration for the chosen version rather than mixing schemas.

Source: [Workloads on control planes](https://docs.siderolabs.com/talos/v1.14/deploy-and-manage-workloads/workloads-on-controlplane).

#### Step 11: Behind the scenes

1. talosctl submits configuration to the node API.
2. Talos parses and validates it; invalid input can be rejected.
3. On this blank-disk installation path, Talos uses the specified installer and disk.
4. Configuration is persisted for later boots.
5. Talos controllers reconcile supported networking and service settings.
6. Configured trust enables authenticated management; Kubernetes initialization still needs its one-time bootstrap.

Applying configuration is not executing an arbitrary shell script. It expresses desired state. On an already installed node, applying a change does not always reinstall or reboot it: behavior depends on the fields and apply mode. Do not infer installation behavior from every future apply-config call.

Source: [Getting started](https://docs.siderolabs.com/talos/v1.14/getting-started/getting-started).

#### Step 21: What changed?

| Property | Unconfigured maintenance mode | Configured Talos API |
| --- | --- | --- |
| Known cluster trust | Not yet established by machine config | Established by applied configuration |
| Caller identity | Maintenance requests lack cluster client authentication | Client certificate and proof of private-key possession |
| Transport | TLS does not by itself establish trusted ownership | Mutual TLS validates both peers |
| Server verification | Ordinary --insecure setup does not perform normal CA validation | talosctl validates server certificate using configured CA trust |
| Permissions | Limited maintenance operations, including initial configuration | API methods restricted by certificate roles |
| Client material | No working cluster talosconfig required | Matching CA trust, client certificate and private key |

Maintenance mode is not unrestricted access to everything. It does not imply arbitrary TPM commands, a shell, or a bypass into an already configured node. The --insecure option cannot disable authentication on the normal configured API.

Source: [Getting started](https://docs.siderolabs.com/talos/v1.14/getting-started/getting-started).

#### What talosconfig contains

| Field | Role |
| --- | --- |
| ca | Public CA certificate used to verify the Talos server |
| crt | Client certificate identifying the caller and its roles |
| key | Client private key used to prove possession |
| endpoints | Addresses the workstation contacts |

The CA certificate is public trust material, not the CA signing key. Base64 encoding is not encryption. talosconfig is sensitive because it includes the client private key.

During mutual TLS, the server and client present certificates and demonstrate possession of their corresponding private keys. The private keys are not transmitted. The node then authorizes the requested API operation. A valid certificate with a reader role cannot perform an admin-only operation.

Sources: [talosconfig reference](https://docs.siderolabs.com/talos/v1.14/reference/talosconfig), [RBAC](https://docs.siderolabs.com/talos/v1.14/security/rbac).

#### Which CA are we discussing?

Step 21 uses the cluster's **Talos API CA**. It is distinct from the Kubernetes CA, NEN device-identity CA, UEFI boot-signing trust and any disk-encryption key. Merely creating the NEN Root CA in our earlier lab does not configure Talos API authentication.

Read one topic at a time: first understand controlplane.yaml versus talosconfig, then the maintenance-to-authenticated transition, then recovery.

<a id="archived-04"></a>

## Archived Draft 04

Original file: `04-security-break-glass-and-lost-keys.md`. Full text preserved; headings and relative navigation adapted to this file.

### Security, Break-Glass and Lost Keys

**Status: Draft, not approved by the learner. Pending discussion.**

Parent: [Detailed notes](detailed/README.md). Previous: [API authentication](#archived-03). Lab: [Track-4](../track-4-nen-control-factory-ec2-lab/README.md).

#### What could compromise security?

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

#### What is break-glass?

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

#### What if I lose my keys?

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

#### Other keys have different consequences

| Key or material | Consequence of loss |
| --- | --- |
| Talos CA signing key backup | Existing access may still work; assess remaining trusted copies and plan controlled recovery/rotation |
| NEN EDGE identity private key | Re-enroll under a new key and certificate after identity verification; a public certificate cannot restore the key |
| Disk-unlock material or TPM state | Without an alternative configured unlock path or recoverable backup, encrypted data may be inaccessible |
| Boot-signing private key | Existing signed images may still boot; signing future images requires planned trust/key rotation |
| NEN Root CA private key | A separate PKI recovery event affecting future subordinate issuance; not solved by replacing talosconfig |

Disk keys, application backups and cluster API credentials serve different purposes. An etcd snapshot does not back up application persistent-volume contents. Plan both cluster-state and application-data restoration.

#### If a credential was stolen

A newly issued credential does not automatically invalidate the stolen one. Talos documents CA rotation as a way to remove trust in leaked client credentials. Plan the transition, refresh affected credentials, remove old trust and verify access. Keep secrets backups aligned with the new CA. Do not improvise a CRL-based revocation flow or assume deleting a local file revokes access.

Source: [CA rotation](https://docs.siderolabs.com/talos/v1.14/security/ca-rotation).

#### Our next learning checkpoint

Explain the difference between controlplane.yaml, talosconfig and kubeconfig before attempting recovery commands. Our NEN TPM enrollment interface and EC2 Secure Boot recovery method remain open implementation questions. These notes establish the concepts; they do not claim a successful recovery test.
