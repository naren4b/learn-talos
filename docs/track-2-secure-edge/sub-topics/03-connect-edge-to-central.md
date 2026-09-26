# Use Case — Connect EDGE to Central

## Problem

The EDGE sits on a customer network behind NAT/firewalls. The architecture should not require the central platform to initiate arbitrary inbound connections to the customer's LAN.

## Mental model

```text
Customer LAN
    |
  EDGE
    |
    | outbound
    v
Internet
    |
    v
Central platform
```

## Underlay and overlay

The customer/site IP path is the **underlay**.

WireGuard can create a private **management overlay** over that path.

```text
Underlay
EDGE private IP → customer NAT → Internet → central endpoint

Overlay
EDGE WG address  <──────────────> central WG address
```

The EDGE initiates the connection, which fits a customer environment where inbound access is restricted.

## WireGuard identity vs application identity

Do not treat network identity as authorization for every application.

```text
EDGE
  |
  | WireGuard peer identity
  v
Secure/private network path
  |
  | application identity/authz where required
  v
Central service
```

WireGuard can authenticate the network peer and protect transport. A central service can independently decide what that EDGE/workload is authorized to do.

## Important design lesson from the PoC

A schema-valid network configuration is not automatically operationally safe.

The Track-2 lab showed that adding networking declaratively can affect the existing management path. Preserve the working underlay/default route and introduce the overlay additively, validating changes before rollout.

## Remember

**EDGE initiates outward. Underlay gets packets there; WireGuard creates the private management overlay.**
