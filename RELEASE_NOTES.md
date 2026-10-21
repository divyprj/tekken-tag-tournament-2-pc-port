# Release Notes: Tekken Tag Tournament 2 PC Port

This document details release history, features, and cryptographic checksums for the Tekken Tag Tournament 2 PC Port distribution wrapper.

---

## Version 0.1.6 (Current Release)

This release implements a standalone distribution package and configuration bundle for the native x86_64 DirectX 11 PC port of *Tekken Tag Tournament 2*, based on the open-source static recompilation port by **Shihab Al-Amri** (`shihabal3amri`) and the **XenonRecomp** framework by **hedge-dev**.

No proprietary game assets or copyrighted containers are bundled in this release. Users must supply their own legally dumped Xbox 360 game disc image (ISO) to extract the game assets.

### Upstream Attribution and Credits
- **Shihab Al-Amri (`shihabal3amri`):** Lead developer of the Tekken Tag Tournament 2 PC Port runtime, memory patching, asset extractor (`ttt2_setup.exe`), and DirectX 11 integration.
- **hedge-dev:** Creator of XenonRecomp, the Xbox 360 static binary recompiler.
- **The Xenia Project:** Foundational reverse engineering of Xbox 360 system calls and GPU microcode.
- **Bandai Namco Entertainment Inc.:** Original creators and copyright owners of *Tekken Tag Tournament 2*.

---

### Features and Improvements in Version 0.1.6

#### 1. Native DirectX 11 Recompilation Engine
- Native x86_64 translation running under DirectX 11 with hardware acceleration.
- Target 60 FPS gameplay (actual performance is hardware-dependent) with smooth frame pacing.
- On-Demand Disk Shader Caching: compiles shaders on first encounter per stage and caches bytecode in `%LOCALAPPDATA%\TTT2Recomp\shadercache\`.
- Complete 59-character roster supported (extracts 42 base disc fighters; applies Title Update 3 for the remaining 17 DLC and bonus fighters).
- Full access to all offline game modes: Practice Mode, Arcade, Ghost Battle, Pair Play, and Tag Survival.

#### 2. Executable Branding and Application Icons
- Embedded custom multi-resolution application icon resource (`ttt2_icon.ico` and `setup_icon.ico`) directly into the Win32 resource (`.rsrc`) section.
- Clean title bar formatting.
- Executable machine code (`.text` section) is unmodified from upstream release.

#### 3. Tekken 7 Keyboard and Multi-Input Architecture
- Player 1 keyboard controls mapped to the competitive Tekken 7 standard:
  - `W` / `A` / `S` / `D`: Directional movement
  - `U`: Left Punch (1 / LP)
  - `I`: Right Punch (2 / RP)
  - `J`: Left Kick (3 / LK)
  - `K`: Right Kick (4 / RK)
  - `O`: Tag / Switch Partner
  - `Enter`: Start / Menu Confirm
  - `Space`: Select / Reset
- Player 2 keyboard layout configured on numeric keypad:
  - Arrow Keys: Directional movement
  - `Numpad 7`: Left Punch (1)
  - `Numpad 8`: Right Punch (2)
  - `Numpad 4`: Left Kick (3)
  - `Numpad 5`: Right Kick (4)
  - `Numpad 9`: Tag
- Multi-controller verified configurations:
  - Two gamepads via native XInput (Player 1 and Player 2).
  - One gamepad and one keyboard.
  - Two players sharing a single physical keyboard via virtual controller mapping software (e.g., x360ce).

#### 4. Save and Profile Maintenance Utilities
- Includes `tools\Reset_Save_Data.bat` to safely back up and reset local player statistics and profiles.

---

### Release Asset Checksums (SHA-256)

#### Historical v0.1.6 Release Package (Pre-Audit Baseline)
- **Archive:** `Tekken_Tag_Tournament_2_PC_v0.1.6_GitHub_Release.zip`
- **Size:** `69,328,683 bytes` (~66.1 MB)
- **SHA-256:** `1BC4C144D015A5BF287F906E10C40A0681DB082D547C7F57BA785970A88B85A6`
*(Note: Contained legacy registry tool `Restore_Smart_App_Control.bat`, which has been permanently removed in post-audit remediation).*

#### Remediated Package (Post-Audit Build)
- **Archive:** `Tekken_Tag_Tournament_2_PC_v0.1.6_GitHub_Release.zip`
- **Size:** `32,948,481 bytes` (~31.4 MB)
- **SHA-256:** `3F769B19E45F341481ED951877FD0AC2B723389BA4CDBF84FBC31B2A0DAFE7C3`
- **Manifest:** Documented in `Distributable_Archives/CHECKSUMS.txt`.
- **Changes:** Removed registry tool, added `THIRD_PARTY_NOTICES.txt`, `DISCLAIMER.txt`, `MULTIPLAYER.txt`, and synchronized documentation with authoritative Markdown sources.

---

## Version 0.1.7 (Upcoming Patch — In Preparation)

A maintenance and security patch addressing findings from the repository supply-chain audit:
- **Security Hardening:** Permanently removed legacy registry modification batch tool (`Restore_Smart_App_Control.bat`) and deprecated hazardous recursive packaging script (`package_release.ps1`).
- **Packaging Hardening:** Hardened `build_github_release_zip.ps1` to enforce strict asset allowlists, throw terminating errors on missing files, reject proprietary game containers, and generate automated checksum manifests (`CHECKSUMS.txt`).
- **Licensing & Provenance:** Separated repository wrapper MIT terms from upstream MIT licenses and established `THIRD_PARTY_NOTICES.md`.
- **Documentation Alignment:** Reconciled shared-keyboard requirements (noting x360ce prerequisite) and replaced locked FPS claims with hardware-dependent targets.

---

## Legal and Strict Anti-Piracy Notice

*Tekken Tag Tournament 2* is a trademark and copyright of Bandai Namco Entertainment Inc. This project is an independent, non-commercial software preservation initiative. No proprietary game assets, media files, or copyrighted code are distributed in this repository or its release packages. All players must supply assets extracted directly from their own legally dumped retail disc image.
