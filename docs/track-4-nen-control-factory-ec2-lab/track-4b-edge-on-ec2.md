# Track-4B — Talos on AWS EC2

**Status:** Selected as the next lab. Planning only; no instance launched for this track.

## Purpose

Use a Talos EC2 instance as the NEN EDGE role for enrollment, outbound connectivity, configuration, health, upgrade and recovery exercises.

## AWS Lab First

Start with one Talos node on EC2. Learn its boot, configuration, authenticated APIs and lifecycle before connecting it to the fleet platform. This stage can proceed without completing the NEN control/factory services.

| Stage | Work | Status | Evidence to collect |
| --- | --- | --- | --- |
| 0 | Read-only workstation and AWS account/region baseline | Next | Tool versions, identity and resource inventory |
| 1 | Choose AMI, architecture, instance and EBS | Planned | Pinned version, provenance, capacity and cost estimate |
| 2 | Define VPC, subnet, routes, DNS, security groups and access path | Planned | Non-overlapping CIDRs and restricted API reachability |
| 3 | Deliver machine configuration through protected EC2 user data | Planned | Configuration retrieved and authenticated Talos API available |
| 4 | Bootstrap once, retrieve kubeconfig and verify networking | Planned | Node, control-plane and system-pod readiness |
| 5 | Inspect services, logs, storage and restart behavior | Planned | Repeatable diagnostics and persisted state |
| 6 | Test a supported OS upgrade and recovery procedure | Planned | Version/health checks and documented recovery |
| 7 | Add AWS workload identity when an application needs it | Later | Allowed and denied AWS API requests from test Pods |
| 8 | Remove lab resources | Planned | No unintended EC2, EBS or network resources left |

### Notes

- This is self-managed Talos Kubernetes on EC2, not EKS.
- A single node is a learning baseline. The official AWS guide's multi-AZ control plane is a separate availability exercise.
- Document how the AWS platform reads instance metadata and user data. Protect secret-bearing configuration and keep it out of Git.
- Select API access deliberately; do not copy publicly open tutorial rules into our lab.
- For a disconnected or private route, provide the necessary registry, DNS and time-service reachability.
- IRSA is a later workload exercise, not a prerequisite for boot. It needs an OIDC issuer/discovery setup, IAM trust and policies, projected tokens and the chosen token-injection mechanism.
- Keep general OS and Talos explanations in [Track-1 fundamentals](../track-1-talos-fundamentals/detailed/README.md).
- This is a lab plan; no infrastructure has been provisioned.

### References

- [Talos AWS installation](https://docs.siderolabs.com/talos/v1.14/platform-specific-installations/cloud-platforms/aws)
- [Talos AWS platform behavior](https://docs.siderolabs.com/talos/v1.14/learn-more/talos-platform-configuration)
- [IRSA on self-managed Talos](https://docs.siderolabs.com/talos/v1.14/security/iam-roles-for-service-accounts)

## Fleet Integration Later

Continue after the standalone AWS baseline is healthy and the central endpoint is reachable.

## Numbered implementation sequence

1. Verify a current official Talos AWS artifact source and pin the chosen AMI/build for the selected region and CPU architecture.
2. Define instance, EBS, network, security groups and recovery access in reproducible infrastructure configuration.
3. Launch one EDGE with securely handled machine configuration; do not place generated secrets in Git.
4. Verify Talos boot/version and restricted administrative access independently of NEN activation.
5. Establish the selected EDGE-initiated connection to the reachable NEN endpoint.
6. Integrate device credentials, private-key proof and site authorization through the chosen NEN component.
7. Verify configuration application and separate platform/application health.
8. Exercise reconnect and one controlled upgrade before adding a second EDGE.
9. Validate the exact Secure Boot and NitroTPM path with positive, negative and recovery tests.

## Boundaries

EC2 uses a Talos AMI and EBS root volume in place of the physical USB/SSD factory flow. EC2 supports UEFI Secure Boot and NitroTPM under documented prerequisites, but our exact NEN-signed Talos workflow is unverified. A successful normal Talos boot proves neither feature.

NitroTPM state is not included in EBS snapshots; restoring an image must not be assumed to restore TPM-bound identity or unlock capability. Design recovery before relying on those bindings.

## Acceptance evidence

Pinned artifact, instance/volume ownership, recovery method, actual connectivity and authenticated NEN results, plus explicit untested security properties. A private-subnet outbound-NAT test is required before claiming the branch NAT scenario is demonstrated.

## Sources to revisit before implementation

- [Talos Image Factory AWS artifacts](https://github.com/siderolabs/image-factory/blob/main/docs/api.md)
- [AWS NitroTPM prerequisites](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enable-nitrotpm-prerequisites.html)
- [AWS Secure Boot prerequisites](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/launch-instance-with-uefi-sb.html)

No instance type, AMI ID or price is frozen by this planning document.
