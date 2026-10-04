# PXE, iPXE, TFTP and HTTP

In a common PXE-to-iPXE setup, **TFTP delivers iPXE first; iPXE then fetches the boot script and larger OS files over HTTP or HTTPS.**

This is a common design, not a restriction: iPXE also supports TFTP and other protocols. It can start from removable media or firmware, so TFTP is not always needed.

## The Two Stages

1. **Load iPXE:** Firmware starts network boot. DHCP supplies network settings and boot information. In the traditional PXE chainloading path, TFTP supplies the iPXE executable: commonly `undionly.kpxe` for legacy BIOS or `ipxe.efi` for UEFI.
2. **Load the OS boot files:** iPXE runs in RAM and follows a script. A web server can supply that script and the kernel/initramfs or other supported boot assets using HTTP or HTTPS. iPXE then starts the selected boot target.

The iPXE binary is generally much smaller than the OS assets. Its exact size depends on the build; there is no universal “under 1 MB” guarantee.

When iPXE makes another DHCP request, the server or an embedded script must direct it to the actual boot instructions. Returning the iPXE binary again can create a chainloading loop.

## Traditional PXE and iPXE

| Aspect | Traditional PXE path | Common iPXE path |
| --- | --- | --- |
| First loader | Firmware downloads a network boot program through TFTP | Firmware chainloads iPXE through TFTP, or iPXE starts another way |
| Later downloads | Depend on the selected boot program | Scripts commonly fetch larger files through HTTP/HTTPS |
| Transfer behavior | Basic TFTP acknowledges each data block | HTTP/HTTPS use TCP; throughput depends on the network and server |
| Remote servers | Need suitable network setup | Can fetch web assets across routed networks and the Internet |
| Trust | DHCP and TFTP alone do not authenticate boot files | HTTPS can protect downloads when certificate validation is configured |

## Notes

- **TFTP is not inherently unreliable:** It handles retransmission, but basic block-by-block transfers can be slow on high-latency links. Extensions such as the TFTP windowsize option improve throughput.
- **TFTP is routable:** It uses IP/UDP. Firewall handling and transfer ports need attention. DHCP broadcast discovery is a separate issue and needs a relay to reach another subnet.
- **Modern firmware can differ:** UEFI HTTP boot is another starting path; not every machine must use TFTP.
- **HTTPS is conditional:** The iPXE build needs HTTPS support and suitable certificate trust. HTTP alone does not authenticate downloaded files.
- **Transport trust and Secure Boot differ:** HTTPS protects the download connection. Executable signature checks are a separate part of the boot chain.
- **For Talos:** This note explains delivery before the OS starts. Continue with the [network installation sequence](../track-1-talos-fundamentals/detailed/01-general-linux-boot.md#scenario-12-network-boot) for configuration, SSD installation and Kubernetes startup.

Think of TFTP as the initial delivery vehicle in this setup, and HTTP/HTTPS as the delivery path for the larger boot files.

## References

Technical notes checked against the [iPXE project](https://ipxe.org/):

- [Chainloading iPXE](https://ipxe.org/howto/chainloading)
- [iPXE capabilities](https://ipxe.org/)
- [HTTPS and certificate trust](https://ipxe.org/crypto)
- [TFTP windowsize option — RFC 7440](https://www.rfc-editor.org/rfc/rfc7440)

Next: follow the DHCP exchange and see how the firmware request differs from the subsequent iPXE request.
