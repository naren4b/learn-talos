# AI Workloads on Customer EDGE

**Status:** Planned learning topic and future blog outline. No AI workload has been deployed or benchmarked.

[Track-2 index](../README.md) · [Talos fundamentals](../../track-1-talos-fundamentals/detailed/README.md)

## Scenario

The customer receives an EDGE with Talos installed. After activation and Kubernetes readiness, they want an approved AI application to run at their site: for example, local document inference or image analysis.

Talos supplies the operating system. Kubernetes runs the application containers. A model-serving process loads model files and handles inference requests.

## From Delivery to Inference

1. **Activate the EDGE:** Verify the site's authorization, node health, networking, storage and Kubernetes readiness. Receiving hardware alone does not make it ready for workloads.
2. **Check capacity:** Select a model that fits the CPU, RAM, storage and any available accelerator. Start with a small CPU inference example; add GPU support as a separate exercise.
3. **Prepare the runtime:** For GPU hardware, qualify the Talos image extensions, container toolkit and Kubernetes device-allocation components against the selected hardware and release.
4. **Deliver approved artifacts:** Provide versioned application images and model files from reachable registries or storage. Check provenance, integrity, model license and customer data policy.
5. **Deploy through Kubernetes:** Use reviewed manifests or Helm, with a dedicated namespace, service account, resource limits, storage and readiness checks. A GitOps agent may pull desired state outbound through customer NAT.
6. **Expose inference locally:** Provide an authenticated application endpoint on the customer LAN. Remote access needs a separately designed route; Talos management connectivity does not automatically publish applications.
7. **Operate and update:** Measure response time, throughput, errors, resource use and storage. Version model/application changes separately from Talos upgrades, and test rollback.

## Responsibilities

| Layer | Responsibility |
| --- | --- |
| Talos | OS, drivers/extensions, node networking and lifecycle |
| Kubernetes | Scheduling, workload isolation, services and storage integration |
| Model server | Model loading, inference and request handling |
| Application | Customer workflow, authentication and data handling |
| Customer/site policy | Who may use the application and where data may go |

## Notes

- A low-memory VM or ordinary EC2 node does not demonstrate GPU inference capacity.
- Local inference can reduce external data transfer; it does not automatically guarantee privacy. Check logs, telemetry, model downloads and application egress.
- Single-node workloads stop during node failure or reboot. Availability requirements may need additional EDGEs.
- WAN-outage operation requires local copies of the required models/images and tested application dependencies.
- Track-2's existing connectivity PoC remains paused. This topic is a planned extension, not a restart of that experiment.

## Lab and Blog Outcome

First demonstrate one approved model answering a request on one customer EDGE. Record image/model versions, hardware, latency, throughput, memory use, access controls and recovery behavior.

The future blog topic is **Running Private AI on a Talos Customer EDGE**. Explain the deployment and measured limits. The reference article uses Omni; our implementation remains self-managed. Its “infinite tokens” headline does not mean unlimited hardware capacity or zero operating cost.

Reference: [Infinite tokens with the Talos Platform](https://www.siderolabs.com/blog/infinite-tokens-with-the-talos-platform/).

Next: choose a small inference use case and its acceptance criteria after the AWS Talos baseline is ready.
