# Phase 0 — Baseline and Topology

**Status:** Pending. First execution step of Track-4.

## Problem

An EC2 EDGE must reach NEN services, while the proposed control lab runs locally in WSL/KIND. A localhost endpoint is insufficient for that path. Resolve connectivity and recovery before creating dependent services.

## Numbered sequence

1. Record available workstation resources and installed container runtime, KIND, kubectl, AWS CLI, Terraform and talosctl versions using read-only checks.
2. Verify the intended AWS account/profile and region; do not assume Track-2 resources still exist or are reusable.
3. Inventory existing lab resources and assign separate Track-4 names/tags to avoid unintended changes.
4. Choose a reachable NEN endpoint design. Compare a controlled gateway/tunnel to local KIND against hosting the FOSS control lab on reachable infrastructure. Record authentication, TLS termination, routes and laptop-offline behavior.
5. Select EC2 AMI provenance, architecture, instance type, EBS size and recovery access. Recheck the current Talos release and pin the approved lab version; v1.14.1 is only the inherited reference.
6. Decide whether the first EDGE uses a private subnet with NAT or a simpler lab route. If not behind NAT, explicitly record that branch-NAT behavior is not tested.
7. Estimate EC2, EBS, public IPv4, NAT, transfer and other selected resource charges using current pricing. Define stop/cleanup ownership.
8. Record the plan and safe next command before provisioning.

## Acceptance evidence

A sanitized baseline, approved resource/network plan, endpoint reachability design, known recovery path and explicit lab limitations. No infrastructure apply is part of documentation validation.

## Failure handling

Stop on account ambiguity, unreachable control endpoints or missing recovery paths. Diagnose the failing layer before adding services. Do not expose Talos or Kubernetes administrative APIs broadly to obtain connectivity.

Next: [Control and Factory](track-4a-control-and-factory.md), coordinated with [EC2 EDGE](track-4b-edge-on-ec2.md).
