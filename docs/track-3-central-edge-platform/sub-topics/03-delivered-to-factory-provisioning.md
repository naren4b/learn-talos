# Delivered to Factory → Factory Provisioning

**Status:** Workflow model established; station implementation and acceptance thresholds pending.

## Use case

A supplier delivers a virgin EDGE. A receiving operator checks its serial number, bill of materials, TPM and firmware capabilities against the approved hardware profile, records custody, and assigns it to an isolated staging station. The EDGE has no fleet membership yet.

| Actor | Already knows | Action |
| --- | --- | --- |
| Operator | Purchase order and shipment manifest | Scans serial, checks physical unit, connects power and staging network |
| Provisioning station | Approved hardware profiles and test policy | Reads hardware/firmware facts from the powered EDGE and checks compatibility |
| Inventory | Expected models and shipment records | Records intake and acceptance/rejection evidence |
| EDGE | OEM firmware, TPM and unprovisioned SSD | Runs only the approved intake/boot environment |

A small lab may use an engineer with USB media and commands. At scale, a line can scan the unit and run a repeatable station workflow with automated gates and manual handling for rejects. Neither model implies that all tests run on the provisioning server: collecting EDGE evidence requires code executing on or firmware responding from the EDGE.

**Exit evidence:** serial and hardware profile matched, station ID and intake time recorded, staging access assigned. Reject or quarantine mismatched units; do not begin identity registration.

## Open design questions

- How is the receiving station authenticated and kept consistent across a pool?
- Which firmware and TPM capabilities are mandatory for each hardware profile?
- What are the physical custody, retry and exception-handling procedures?
