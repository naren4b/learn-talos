# Identity Registered → Talos Installed

**Status:** Physical artifact relationship established; exact Talos version and installation method pending.

## Use case

The factory station selects the approved Talos build for this EDGE hardware profile. The EDGE boots temporary installation media, obtains its machine configuration and installer image according to the chosen Talos workflow, and installs Talos onto its SSD. The station orchestrates, but the installer executes on the EDGE and writes its disk.

```mermaid
flowchart TD
    ISO["Talos ISO: temporary boot"] --> RUN["Talos running on EDGE"]
    RUN --> INS["Installer image/process"]
    INS --> SSD["EDGE SSD: installed Talos"]
    SSD --> UKI["Signed UKI: boot artifact"]
```

The ISO is removable installation media. The installer image is the source used for disk installation. Installed Talos persists on the SSD; a signed UKI, when using the Talos Secure Boot installation path, is a boot artifact of that installation, not a second OS. After installation and reboot, boot comes from SSD. Confirm the selected Talos release, image customization, signing path and UEFI support before specifying exact partitions or commands.

| Check | Location |
| --- | --- |
| Verify approved artifact provenance and profile | Factory station before delivery; EDGE-side validation as designed |
| Run installer and write selected disk | EDGE temporary Talos environment and EDGE SSD |
| Record install result/version/disk identity | EDGE reports; station/inventory record |

**Exit evidence:** correct SSD selected, installation completes, expected Talos version and boot artifact recorded. An installer result alone does not prove secure boot; that is the next transition. Disk selection and failed-install recovery need an explicit test before automation.

## Open questions

Artifact source and signature/checksum policy; extension compatibility; configuration delivery and secret handling; exact Talos Secure Boot artifacts; safe retry after partial disk writes.
