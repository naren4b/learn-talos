# CLI and API mental model

## The operating split

In a Talos environment, you usually operate two separate control planes:

1. Talos API for the operating system and node lifecycle
2. Kubernetes API for workloads and cluster resources

This distinction is the foundation of a safe production mental model.

## talosctl

`talosctl` is the operator’s tool for node-level administration. It talks to the Talos control plane, which is exposed by the node or by a control-plane endpoint.

Typical use cases:

- inspect node health
- view logs and service status
- apply machine config
- install or upgrade nodes
- troubleshoot boot or networking problems
- collect diagnostics

### Key concepts

#### Endpoint

The endpoint is the address used to reach the Talos API service. This is usually a node or a reachable IP/host that can be used to interact with the API.

#### Node

The node is the assigned machine the command is targeting. In a multi-node cluster, you often specify both the endpoint and the node.

Example:

```bash
talosctl --endpoints 10.0.0.10 --nodes 10.0.0.11 status
```

This example tells you:

- `--endpoints` identifies the Talos API service endpoint to reach
- `--nodes` identifies the specific node you want to query or manage

The distinction matters because the endpoint is a communication path, while the node is the target machine.

## kubectl

`kubectl` does not manage the Talos OS. It manages Kubernetes objects and cluster-level workload state.

Typical use cases:

- list pods or services
- deploy workloads
- view events
- inspect cluster health
- interact with Kubernetes RBAC, ConfigMaps, Secrets, and Deployments

### Safety point

If a node is unhealthy at the OS layer, `kubectl` may be limited or useless. You may need `talosctl` first to restore node health before Kubernetes workloads can run normally again.

## omnictl

`omnictl` is the control plane for Omni, which adds a higher-level management layer on top of Talos infrastructure.

Typical use cases:

- machine inventory and management
- cluster templates
- fleet-level lifecycle management
- access and authorization management across multiple machines/clusters

Omni is not a replacement for Kubernetes or Talos; it is an additional abstraction layer for organizations operating many machines or clusters.

## Decision table

| Task | Correct CLI | API contacted | Required artifact | Typical authorization |
| --- | --- | --- | --- | --- |
| Check node health | talosctl | Talos API | talosconfig | machine or admin certificate |
| List pods | kubectl | Kubernetes API | kubeconfig | Kubernetes RBAC |
| Install or upgrade node OS | talosctl | Talos API | talosconfig + config | Talos admin identity |
| Read cluster workload objects | kubectl | Kubernetes API | kubeconfig | RBAC role |
| Manage machine fleet and templates | omnictl | Omni API | Omni credentials | Omni auth and policy |
| Troubleshoot kernel or boot state | talosctl | Talos API | talosconfig | Talos admin access |

## Operational rule of thumb

Use the tool that matches the layer you are operating:

- OS and node lifecycle → `talosctl`
- Kubernetes workloads and API objects → `kubectl`
- fleet or multi-cluster management abstraction → `omnictl`

## Why the split matters during incidents

During an incident, a common mistake is to reach for `kubectl` too early. If the problem is actually a node booting incorrectly, a network issue in the host OS, or a broken Talos config, the Kubernetes API may be unavailable or misleading.

Good incident flow:

1. Check whether the issue is at the node layer or cluster layer.
2. Use `talosctl` to inspect node health and OS-level state.
3. If the node is healthy, move to `kubectl` for workload and cluster debugging.
4. Use `omnictl` only when the issue is fleet-level or Omni-managed.

## Verification checklist

Confirm that you can explain:

- why `talosctl` and `kubectl` serve different control planes
- why `--endpoints` and `--nodes` are different concerns
- when `kubectl` loses usefulness during an OS-level outage
- when `omnictl` is necessary and when it is not

## Hands-on challenge

Write a decision tree for the following scenarios:

- kubelet crashes on a worker node
- control-plane API is unreachable but nodes are still online
- a node is stuck in maintenance mode
- a cluster template needs to be updated across many machines

For each scenario, state the likely tool, the likely API, and the next verification step.
