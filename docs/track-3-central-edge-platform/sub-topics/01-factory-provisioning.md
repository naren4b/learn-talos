# Factory Provisioning — Cold Hardware to Customer Power-On

## Purpose

Factory provisioning converts virgin hardware from a supplier into a known,
trusted and tested EDGE that is safe to ship. It does not make the device an
active production EDGE; customer-site enrollment happens after power-on.

This document is the end-to-end overview. Each meaningful arrow in the
lifecycle diagram becomes its own focused sub-topic after that transition is
studied. This keeps identity, installation, Secure Boot, validation, shipping
and customer-site boot responsibilities understandable without losing the
complete journey.

## Locations and responsibilities

| Location | Responsibility |
| --- | --- |
| Supplier site | Manufacture and deliver cold hardware with serial number and TPM |
| Factory staging facility | Inspect, provision and validate the EDGE |
| Inside the EDGE | TPM protects keys, UEFI holds boot trust, and SSD holds installed Talos |
| Central platform | Publish signed artifacts and store fleet public information |
| Customer site | Connect the provisioned EDGE to network and power |

The factory may operate multiple identically configured provisioning servers
in parallel. A provisioning server orchestrates the work, but configuration
changes occur on components inside the EDGE.

## Interaction model

**Factory EDGE Interactions**

```mermaid
sequenceDiagram
    autonumber

    participant SUP as Supplier
    participant PS as Factory Provisioning Server
    participant TPM as EDGE TPM
    participant UEFI as EDGE UEFI
    participant SSD as EDGE SSD
    participant INV as Central Fleet Inventory
    participant CUST as Customer

    SUP->>PS: Deliver virgin EDGE hardware
    PS->>PS: Inspect model, serial and components

    PS->>TPM: Read manufacturer identity
    TPM-->>PS: Return EK public information
    PS->>TPM: Generate AK and operational keys
    TPM-->>PS: Return public keys only
    PS->>INV: Create EDGE-ID and register public identities

    PS->>SSD: Install approved signed Talos
    PS->>UEFI: Enrol Secure Boot public trust
    PS->>SSD: Add minimum bootstrap information

    PS->>UEFI: Request test reboot
    UEFI->>SSD: Read signed Talos boot artifact
    SSD-->>UEFI: Return signed boot artifact
    UEFI->>UEFI: Verify artifact signature
    UEFI->>SSD: Allow Talos to start

    PS->>TPM: Request security evidence
    TPM-->>PS: Return identity and measurement evidence
    PS->>SSD: Check Talos, storage and network health
    SSD-->>PS: Return health results

    PS->>INV: Mark EDGE READY_TO_SHIP
    PS-->>CUST: Ship provisioned EDGE

    CUST->>UEFI: Power on at customer site
    UEFI->>SSD: Verify and start signed Talos
```

## Lifecycle model

**Factory to Customer States**

```mermaid
stateDiagram-v2
    [*] --> Manufactured

    Manufactured --> DeliveredToFactory: Supplier delivers EDGE
    DeliveredToFactory --> FactoryProvisioning: Factory accepts hardware

    FactoryProvisioning --> IdentityRegistered: Register TPM identity
    IdentityRegistered --> TalosInstalled: Install Talos on EDGE SSD
    TalosInstalled --> SecureBootConfigured: Enrol trust in EDGE UEFI
    SecureBootConfigured --> FactoryValidation: Reboot and test EDGE

    FactoryValidation --> ReadyToShip: All tests pass
    FactoryValidation --> Quarantined: Required test fails

    ReadyToShip --> Shipped: Send EDGE to customer
    Shipped --> InstalledAtCustomer: Connect network and power
    InstalledAtCustomer --> PoweredOn: Customer powers on EDGE

    PoweredOn --> SecureBootVerification: UEFI verifies Talos
    SecureBootVerification --> BootstrapStarted: Signature trusted
    SecureBootVerification --> BootBlocked: Signature untrusted
```

## What resides on the EDGE

| EDGE component | Factory activity |
| --- | --- |
| TPM | Read EK public identity; generate non-exportable AK and operational keys |
| UEFI | Enrol the public trust used to verify signed boot software |
| SSD | Install approved Talos and the selected minimum bootstrap information |

Private keys remain protected by the TPM. The central fleet inventory stores
only the required public identities, assignments, versions, evidence and
lifecycle state.

## Factory outcome

```text
Supplier
    ↓ virgin hardware
Factory provisioning environment
    ↓ provisioned and tested hardware
Customer site
    ↓ customer powers on
EDGE UEFI verifies Talos
    ↓
Bootstrap begins
```

Passing factory validation produces `READY_TO_SHIP`. A required test failure
produces `QUARANTINED` and the EDGE must not be shipped.

## Open implementation detail

The exact storage and delivery mechanism for minimum bootstrap information is
not decided yet. First establish the artifact flow among the Talos ISO,
installer, installed Talos and UKI. Only then select how bootstrap information
is safely delivered and retained.
