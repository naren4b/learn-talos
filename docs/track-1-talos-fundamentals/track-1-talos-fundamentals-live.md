# Track 1: Talos Fundamentals Live Discussion

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
