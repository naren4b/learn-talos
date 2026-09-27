# Track-4 Open Questions

Carry forward the [Track-3 register](../track-3-central-edge-platform/open-topic.md); closure of the theory track does not resolve its implementation blockers.

| ID | Question | Close with |
| --- | --- | --- |
| T4-01 | TODO:<Question> How will an EC2 EDGE securely reach local WSL/KIND services? | Chosen topology, authenticated reachability and laptop-offline behavior |
| T4-02 | TODO:<Question> Which AWS account, region, AMI, instance and network fit the lab? | Read-only baseline, current compatibility check and cost plan |
| T4-03 | TODO:<Question> What implements TPM identity enrollment and binding on Talos/EC2? | Supported interface, proof and recovery evidence; inherits OT-01 |
| T4-04 | TODO:<Question> What implements NEN bootstrap, credential persistence and site configuration? | Working integration and denied-authorization tests; inherits OT-06 |
| T4-05 | TODO:<Question> How are NEN-signed UKI, UEFI trust and NitroTPM configured together? | Exact AMI/build procedure and enforcement/recovery tests |
| T4-06 | TODO:<Question> How are factory jobs and upgrade progress persisted across retries? | Restart/retry tests with durable state and observed completion |
| T4-07 | TODO:<Question> How will the PKI lab keys be handled and recovered? | Verify existing artifacts without disclosure; record custody and recovery policy |

Track-3 VirtualBox investigation remains parked as an alternative; EC2 is the selected EDGE environment for this new track.
