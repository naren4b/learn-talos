# Recommended lab environment

## Goal

The right lab should make Talos behavior realistic without making the environment so heavy that it slows learning. The goal is to practice real operations, not just see commands in isolation.

## Recommended architecture

### Option 1: Simple local lab

Best for: learning core Talos concepts, bootstrap flow, node lifecycle, and troubleshooting basics.

Suggested components:

- 1 control-plane node
- 1 worker node
- 1 load balancer or VIP endpoint
- 1 management workstation
- one virtual network for cluster traffic

This is enough to practice:

- image deployment
- machine configuration
- bootstrap flow
- node joins
- basic upgrades
- troubleshooting

### Option 2: Proxmox-based lab

Best for: realistic cluster learning with bare-metal-like behavior and multiple nodes.

Suggested components:

- 3 control-plane nodes
- 2 or more worker nodes
- shared network and DNS
- separate management VLAN or subnet
- external load balancer or VIP

This setup is closer to production and helps practice:

- node replacement
- control-plane endpoint design
- upgrade sequencing
- storage and networking issues
- realistic rollback and recovery procedures

### Option 3: Cloud or hybrid lab

Best for: learning edge cases, external exposure, load-balancer design, and cluster operations at a larger scale.

This is useful when you want to practice:

- multi-AZ or multi-region architecture
- private/public API exposure patterns
- bastion and VPN modeling
- automation for repeated cluster deployment

## Core lab assumptions

Your lab should include:

- a management machine with `talosctl`, `kubectl`, and related tooling
- a separate bootstrap and control-plane endpoint strategy
- realistic DNS and certificate assumptions
- a test network that reflects production constraints
- clear distinction between management traffic and workload traffic

## Recommended learning workflow

1. Stand up a small 2-node or 3-node lab.
2. Practice machine config generation and node joins.
3. Validate Talos API and Kubernetes API separation.
4. Introduce an upgrade and rollback exercise.
5. Reproduce a node failure and recover it.
6. Add networking, storage, or security constraints.
7. Scale the lab to a more production-like pattern.

## Why this works

The lab should teach operational thinking, not just syntax. A small lab is enough to experience:

- boot failure and recovery
- node replacement
- certificate rotation issues
- configuration drift and troubleshooting
- API and workload separation

## Verification checklist

A good lab is one where you can answer these questions:

- Can I reach the Talos API and the Kubernetes API separately?
- Can I identify whether a failure belongs to the host OS or the cluster?
- Can I replace a failed node without losing the control-plane story?
- Can I recover from a failed upgrade without guesswork?

## Hands-on challenge

Design a lab plan for a 5-node Talos cluster:

- 3 control-plane nodes
- 2 worker nodes
- one management workstation
- one VIP for the Kubernetes API
- one local DNS or endpoint design

Then document the exact steps you would take to:

- bootstrap the cluster
- validate control-plane readiness
- join workers
- simulate a failed control-plane node
- recover without destroying the cluster
