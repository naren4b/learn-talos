# Use Case — Bootstrap and Trust

## Problem

A device is prepared centrally, shipped cold, and powered on at a customer site. The central platform must decide:

**Is this the expected device, running an acceptable platform, and should it receive operational identity?**

## Mental model

Start with four different questions:

| Item | Simple question | Think of it as |
| --- | --- | --- |
| **EK — Endorsement Key** | Which TPM is this? | TPM's hardware-rooted identity |
| **AK — Attestation Key** | Can this TPM sign trustworthy attestation evidence? | TPM's attestation signing identity |
| **PCR — Platform Configuration Register** | What measured state did this machine boot into? | Tamper-evident measurement summary |
| **Machine certificate** | Is this EDGE allowed to operate now? | Operational identity issued by our platform |

Do **not** treat these as four versions of the same certificate/key. They have different jobs.

## Story: EDGE-347 arrives at a customer site

Imagine we manufactured and registered **EDGE-347** and then shipped it to a customer.

At first boot the central platform should not simply trust:

> "Hello, I am EDGE-347."

Anyone could send that string.

Instead, the trust journey is:

```text
TPM exists in EDGE-347
        |
        +-- EK: hardware-rooted TPM identity
        |
        +-- AK: key used for attestation evidence
        |
        +-- PCRs: measured boot state
                 |
                 v
        Central verifier
                 |
        verifies identity + evidence
                 |
                 v
        Machine certificate
        "EDGE-347 is authorized"
```

The **machine certificate is the outcome of enrollment/authorization**. It is not the EK.

## 1. EK — Endorsement Key

**EK = Endorsement Key.**

The EK belongs to the TPM and is intended to act as a hardware-rooted trust anchor for that TPM.

For the mental model:

```text
EDGE-347
└── TPM
    └── EK
        └── "I am this TPM"
```

Usually the EK has a private portion protected by the TPM. A corresponding EK public key/certificate can participate in establishing trust in the TPM.

### What EK does NOT tell us

Seeing a trusted EK does **not** by itself prove:

- Talos booted correctly
- Secure Boot succeeded
- the expected kernel was measured
- the machine is currently healthy
- EDGE-347 should receive production access

So remember:

**EK helps establish trust in the TPM, not the current boot state.**

## 2. AK — Attestation Key

**AK = Attestation Key.**

The AK is a TPM-protected key used to sign attestation evidence.

Mental model:

```text
TPM
├── EK  -> establish trust in the TPM
└── AK  -> sign attestation evidence
```

The verifier needs assurance that the AK belongs to the TPM it intends to trust. The exact protocol is more nuanced than simply saying "EK signs AK"; keep those concepts separate.

## 3. PCR — Platform Configuration Register

PCRs contain values representing accumulated measurements made during boot.

Think:

```text
Firmware
   ↓ measure
Bootloader
   ↓ measure
Kernel / boot components
   ↓ measure
PCR values
```

PCRs do **not** contain copies of Talos, the kernel, or firmware. They contain cryptographic measurement state.

So:

**EK answers a TPM identity/trust question. PCRs answer a platform-state question.**

## 4. How AK and PCR work together

Suppose AWS asks EDGE-347:

> Prove your current measured state, and prove this response is fresh.

The verifier sends a fresh **nonce**.

The TPM can produce attestation evidence containing relevant PCR state bound to that nonce and signed using an AK.

Conceptually:

```text
Central verifier
      |
      | nonce
      v
EDGE-347 TPM
      |
      | PCR evidence + nonce
      | signed by AK
      v
Central verifier
      |
      +-- verify signature
      +-- verify freshness
      +-- evaluate PCR measurements
```

The nonce helps stop an attacker from simply replaying an old successful attestation response.

## 5. Machine certificate

After enrollment policy succeeds, our platform can issue EDGE-347 an **operational machine certificate**.

```text
TPM trust
   +
Attestation evidence
   +
Enrollment policy
   ↓
Central approval
   ↓
Machine certificate
   ↓
EDGE-347 can authenticate operationally
```

The machine certificate answers:

> **Which authorized EDGE is connecting to my platform?**

It can later be rotated or revoked without changing the TPM's EK.

That separation is important.

## Complete Track-2 mental model

```text
EK
"Which TPM?"
   ↓
AK
"Attestation signing identity"
   ↓
PCR evidence
"What measured state?"
   ↓
Verifier + policy
"Do I trust and authorize it?"
   ↓
Machine certificate
"EDGE-347 may operate"
```

This is intentionally simplified. In real TPM attestation, EK, AK certification/credential activation, measured boot evidence, event logs, verifier policy, and certificate issuance are separate protocol steps.

## Secure Boot vs measured boot

These are also different:

**Secure Boot** controls which signed boot components are allowed to execute according to the configured trust chain.

**Measured Boot** records measurements of boot components into TPM PCRs.

So the useful memory aid is:

**Secure Boot = may it run?**  
**Measured Boot = what was measured while booting?**  
**EK = establish trust in which TPM?**  
**AK = which TPM-protected key signs attestation evidence?**  
**PCR = what measured state is being reported?**  
**Attestation = can I verify that evidence remotely and freshly?**  
**Machine certificate = which approved EDGE may operate?**

## Anti-cloning idea

```text
EDGE-347
TPM-A + SSD
    ↓
hardware-bound trust

Copy SSD
    ↓
Different machine + TPM-B
    ↓
cannot simply reproduce TPM-A's protected keys/proof
```

Where strong anti-cloning is required, do not rely only on exportable private keys stored on disk.

## Architecture judgment

Remote attestation is not automatically required for every EDGE deployment.

The Track-2 design studies increasing levels of trust:

1. Secure Boot
2. TPM-backed keys and measured boot
3. Remote attestation
4. Policy-based issuance of operational identity

The important architecture principle is:

> **Hardware identity, platform-state evidence, and operational authorization are separate concerns.**

Do not collapse all three into one "device certificate."
