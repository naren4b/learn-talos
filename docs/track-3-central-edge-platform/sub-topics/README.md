# Track-3 sub-topics

Focused learning notes derived from the Track-3 journey belong here. Lifecycle
files may begin as scoped learning outlines; complete their detailed content
only after the requirements, architectural responsibility and relationship to
the central EDGE platform are understood.

## Current sub-topics

- [Factory provisioning overview: cold hardware to customer power-on](01-factory-provisioning.md)

## Lifecycle sub-topic plan

Each meaningful state transition receives a focused sub-topic when that
transition is studied. The overview remains the end-to-end map.

| State change | Sub-topic |
| --- | --- |
| `Manufactured → DeliveredToFactory` | [Supplier delivery and chain of custody](02-manufactured-to-delivered-to-factory.md) |
| `DeliveredToFactory → FactoryProvisioning` | [Factory intake and hardware acceptance](03-delivered-to-factory-provisioning.md) |
| `FactoryProvisioning → IdentityRegistered` | [TPM identity and fleet registration](04-factory-provisioning-to-identity-registered.md) |
| `IdentityRegistered → TalosInstalled` | [Talos artifact selection and installation](05-identity-registered-to-talos-installed.md) |
| `TalosInstalled → SecureBootConfigured` | [UEFI Secure Boot trust provisioning](06-talos-installed-to-secure-boot-configured.md) |
| `SecureBootConfigured → FactoryValidation` | [Factory validation and evidence](07-secure-boot-configured-to-factory-validation.md) |
| `FactoryValidation → ReadyToShip` | [Release approval and ready-to-ship evidence](08-factory-validation-to-ready-to-ship.md) |
| `FactoryValidation → Quarantined` | [Provisioning failure and quarantine](09-factory-validation-to-quarantined.md) |
| `ReadyToShip → Shipped` | [Shipment authorization and chain of custody](10-ready-to-ship-to-shipped.md) |
| `Shipped → InstalledAtCustomer` | [Customer-site installation prerequisites](11-shipped-to-installed-at-customer.md) |
| `InstalledAtCustomer → PoweredOn` | [First customer-site power-on](12-installed-at-customer-to-powered-on.md) |
| `PoweredOn → SecureBootVerification` | [UEFI boot verification](13-powered-on-to-secure-boot-verification.md) |
| `SecureBootVerification → BootstrapStarted` | [Trusted boot to bootstrap handoff](14-secure-boot-verification-to-bootstrap-started.md) |
| `SecureBootVerification → BootBlocked` | [Untrusted boot failure and recovery](15-secure-boot-verification-to-boot-blocked.md) |

Each linked file now exists. Planned sections remain explicitly marked until
the architecture, trust, evidence, failure behavior and recovery path have been
discussed and understood.

## Factory station use case

- [Provisioning station: one EDGE job](16-factory-provisioning-station.md) covers station configuration, known inputs, security boundaries, manual lab versus automated line, and where each test executes.
- Files [03](03-delivered-to-factory-provisioning.md) through [07](07-secure-boot-configured-to-factory-validation.md) now contain the corresponding intake, identity, Talos installation, UEFI trust and validation use cases. Files 02 and 08–15 retain their scoped outlines until studied.
