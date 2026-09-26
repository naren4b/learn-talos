# Security artifact lifecycle overview

## Why this matters

Talos clusters create a chain of trust across multiple layers: machine identity, cluster identity, Kubernetes identity, and operational access. If you do not understand these artifacts, you cannot securely operate the fleet.

## Core security artifacts

| Artifact | Typical purpose | Trust boundary | Secret sensitivity |
| --- | --- | --- | --- |
| talosconfig | Talos API access from admin or automation | admin to node cluster | High |
| kubeconfig | Kubernetes API access from admin or automation | admin to cluster | High |
| Machine config | Node identity and configuration | node and cluster | Medium to high |
| Secrets bundle | Cluster bootstrap and internal certificate material | cluster bootstrap | Very high |
| Cluster CA | Signs cluster components and certs | cluster trust | High |
| Machine CA | Identifies machines and certs | node trust boundary | High |
| Kubernetes CA | Signs Kubernetes component identities | cluster trust | High |
| etcd CA | Signs etcd peer and client certs | control-plane trust | High |
| Service account keys | Token signing for Kubernetes workloads | cluster trust | Very high |
| Bootstrap tokens | Initial cluster join and bootstrap trust | bootstrap phase | Medium |
| Omni credentials | Fleet management access | Omni boundary | High |

## Artifact lifecycle pattern

Most Talos security artifacts follow a lifecycle like this:

1. Generate material
2. Store it in the correct secret location
3. Distribute to the correct components
4. Rotate on schedule or after exposure
5. Revoke or invalidate stale credentials
6. Verify trust after rotation

## What should be stored in Git

Only low-risk, non-secret configuration should generally be stored in Git. Examples may include:

- versioned machine configuration templates
- non-secret values and conventions
- policy or deployment manifests that are not sensitive

You should not store:

- private keys
- cluster secret bundles
- kubeconfig or talosconfig with private material
- bootstrap secrets
- certificate private keys
- Omni secrets or credentials

## What must never be committed

The standard rule is simple: never commit anything that would allow unauthorized access or identity impersonation.

That includes:

- private keys used by the cluster
- any `talosconfig` carrying private client material
- kubeconfig with client private credentials
- bootstrap or join material that enables cluster membership
- certificates and private keys used by etcd, Kubernetes, or machine identity

## Trust-flow overview

### Administrator to Talos API

An administrator uses a trusted identity to connect to the Talos API. This identity proves that the operator is allowed to manage the node layer.

### Administrator to Kubernetes API

The administrator uses a Kubernetes identity, via kubeconfig or workload identity, to reach the cluster API and operate workloads or cluster resources.

### Machine to Omni

A machine or cluster may authenticate to Omni to receive management, templates, or fleet-level operations. This is a separate trust boundary from the Kubernetes API.

### Kubernetes components to each other

Kubernetes components rely on certificates and service identities to trust each other. This includes control-plane members, kubelets, and internal service-to-service trust.

## Rotation and revocation

Certificates and keys should be rotated before expiration and after suspected compromise. Rotation is not just a certificate task; it is also a trust update task.

Practices to keep in mind:

- rotate CA signing material before it expires
- revoke stale admin access after employee departures
- replace bootstrap material after initial join flow
- rotate highly privileged cluster secrets on a regular cadence
- confirm cluster components can still trust the new material after rotation

## Break-glass access

Break-glass access is an emergency access route reserved for critical incidents. It should be:

- tightly controlled
- documented
- time-bound when possible
- audited
- separate from routine admin access

You should not rely on the same daily admin credential for emergency operations.

## Why kubeconfig and talosconfig are different risks

Both are powerful, but they do not grant the same access.

### talosconfig

This is more node and host-level access. It gives operational control over host OS and node-level functions.

### kubeconfig

This grants Kubernetes API access, meaning workload and cluster control. It does not replace node-level Talos access and is not equivalent in trust model or blast radius.

## Recovery patterns

If you lose access:

- recover the trusted admin identity from a controlled secret store
- re-establish or rotate the cluster CA and admin credentials if needed
- validate that only the required identities remain active
- confirm no stale credentials continue to trust the cluster

## Verification checklist

Before moving on, confirm that you can explain:

- why Talos and Kubernetes identities are separate trust boundaries
- which artifacts are sensitive and which are safe for Git
- how rotation and revocation differ
- why break-glass access must be carefully controlled
- why losing kubeconfig and talosconfig are different operational events

## Hands-on challenge

Create a simple trust matrix showing:

- admin to Talos API
- admin to Kubernetes API
- node to Omni
- etcd to cluster members
- kubelet to control plane

For each trust relationship, list:

- what authenticates the connection
- which secret or cert is involved
- which blast radius exists if the credential is leaked
