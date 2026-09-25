# Use Case — Bootstrap and Trust

## Problem

A device is prepared centrally, shipped cold, and powered on at a customer site. The central platform must decide:

**Is this the expected device, running an acceptable platform, and should it receive operational identity?**

## Mental model

```text
Factory knowledge
      +
Runtime cryptographic proof
      ↓
Central verification
      ↓
Operational identity
```

## Trust chain

```text
Approved boot artifact
      ↓
Secure Boot
      ↓
TPM measurements
      ↓
Outbound enrollment
      ↓
Optional remote attestation
      ↓
Verify device + state
      ↓
Issue operational machine identity
```

## Keep these concepts separate

### Secure Boot
Controls whether software in the configured trust chain may execute.

### TPM
Provides hardware-backed cryptographic capabilities, can protect keys, and stores PCR measurement state.

### PCR
Represents accumulated measured-boot state. It does not contain copies of the firmware/kernel.

### Remote Attestation
Lets a remote verifier evaluate signed evidence about device/platform state. A fresh nonce helps prevent replay of previously captured evidence.

### Operational machine certificate
Authenticates the approved EDGE during normal operation. It does not have to be the same identity as the TPM endorsement or attestation identity.

## Anti-cloning idea

```text
EDGE-347
TPM-A + SSD
    ↓
hardware-bound identity

Clone SSD into TPM-B
    ↓
cannot simply reproduce TPM-A proof
```

Where strong anti-cloning is required, do not rely only on exportable private keys stored on disk.

## Architecture judgment

Remote attestation is not automatically required for every EDGE.

The Track-2 design uses three increasing trust levels:

1. Secure Boot
2. TPM-backed protection
3. Remote attestation

Introduce Level 3 when physical risk, anti-cloning, secret-release policy or compliance requirements justify the additional infrastructure.

## Remember

**Secure Boot = may it run?  
Measured Boot = what ran?  
Attestation = prove it remotely.  
Certificate = who am I operationally?**
