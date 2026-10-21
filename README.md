<p align="center">
  <img src="assets/logo.png" alt="Tekken Tag Tournament 2 PC Port" width="480">
</p>

# Tekken Tag Tournament 2 PC Port

<div align="center">

[![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011%20x64-blue.svg)](https://github.com/divyprj/tekken-tag-tournament-2-pc-port)
[![Renderer](https://img.shields.io/badge/Renderer-DirectX%2011%20Native-0078D7.svg)](https://github.com/divyprj/tekken-tag-tournament-2-pc-port)
[![Framerate](https://img.shields.io/badge/Framerate-Target%2060%20FPS%20(Hardware%20Dependent)-brightgreen.svg)](https://github.com/divyprj/tekken-tag-tournament-2-pc-port)
[![Release](https://img.shields.io/badge/Release-v0.1.6-orange.svg)](https://github.com/divyprj/tekken-tag-tournament-2-pc-port/releases/tag/v0.1.6)
[![License](https://img.shields.io/badge/License-MIT%20%2F%20Preservation-yellow.svg)](LICENSE)

</div>

> [!IMPORTANT]
> **ZERO PROPRIETARY GAME FILES ARE INCLUDED.** This project does NOT promote piracy, distribute ROMs, or host copyrighted media. You must provide your own legally dumped Xbox 360 game disc image (Title ID: `4E4D0859`).
> *Tekken Tag Tournament 2* is a trademark and copyright of Bandai Namco Entertainment Inc. This repository is an independent open-source distribution wrapper, configuration preset, and packaging automation project created for software preservation and PC interoperability.

---

## Contents

- [Overview](#overview)
- [Core Features](#core-features)
- [System Requirements](#system-requirements)
- [Download and Quick Start](#download-and-quick-start)
- [Technical Architecture](#technical-architecture)
- [Controls and Multiplayer](#controls-and-multiplayer)
- [Strict Anti-Piracy and Fair Use Declaration](#strict-anti-piracy-and-fair-use-declaration)
- [Troubleshooting and Helper Tools](#troubleshooting-and-helper-tools)
- [Credits and Upstream Authors](#credits-and-upstream-authors)
- [Applied Licenses and Third-Party Notices](#applied-licenses-and-third-party-notices)

---

## Overview

**Tekken Tag Tournament 2 PC Port** is an unofficial, native x86_64 DirectX 11 distribution of the acclaimed 2012 fighting game for modern 64-bit Windows systems.

This repository serves as a **curated standalone distribution wrapper, configuration bundle, and packaging automation pipeline** based on the open-source static recompilation port by **Shihab Al-Amri** ([shihabal3amri](https://github.com/shihabal3amri)) and the **XenonRecomp** framework by **hedge-dev** ([hedge-dev](https://github.com/hedge-dev)).

Unlike traditional emulation layers that incur substantial CPU interpreter overhead, the underlying engine executes statically recompiled machine code natively on modern x86_64 processors. Hardware-accelerated DirectX 11 rendering targets smooth 60 FPS gameplay (hardware dependent) with direct XInput polling, on-demand disk shader caching, and full support for both competitive keyboard layouts and modern game controllers.

---

## Core Features

- **Hardware-Accelerated DirectX 11 Pipeline:** Smooth rendering targeting 60 FPS (performance is hardware-dependent) across 1080p, 1440p, and 4K display modes.
- **On-Demand Disk Shader Caching:** Shaders compile on first encounter per stage and persist to `%LOCALAPPDATA%\TTT2Recomp\shadercache\`, ensuring smooth frame pacing on subsequent matches.
- **Complete 59-Fighter Roster Support:** Extracts 42 base disc fighters; integrates Title Update 3 (`data042.bin` through `data053.bin`) to unlock all 17 console DLC fighters and transformations.
- **Multi-Input Competitive Architecture:** Native Tekken 7 keyboard mapping (WASD movement, U/I/J/K combat, O for Tag), native XInput gamepad detection, and DirectInput support.
- **Local Multiplayer Options:** Seamless simultaneous play across two gamepads, one gamepad and one keyboard, or two players on a single keyboard using third-party virtual controller mapping (e.g., x360ce).
- **Zero Proprietary Data Distribution:** Releases distribute strictly runtime binaries, configuration templates, and documentation. All copyrighted game assets are extracted locally by the user from retail media.
- **Isolated User Storage:** Saves, profiles, and shader caches persist cleanly in `%LOCALAPPDATA%\TTT2Recomp\`.

---

## System Requirements

| Specification | Minimum | Recommended |
|---|---|---|
| **Operating System** | Windows 10 (64-bit, Version 1903+) | Windows 10 / 11 (64-bit, latest build) |
| **Processor** | Intel Core i5 (4th Gen) / AMD FX-8350 | Intel Core i5 (10th Gen+) / AMD Ryzen 5 3600+ |
| **Memory** | 8 GB RAM | 16 GB Dual-Channel RAM |
| **Graphics** | NVIDIA GeForce GTX 1050 / AMD Radeon RX 560 | NVIDIA GeForce GTX 1660 / RTX 2060 or higher |
| **DirectX** | Version 11 Feature Level 11_0 | Version 11 Feature Level 11_1 |
| **Storage** | 15 GB available space | 15 GB SSD storage |
| **Input** | Standard USB Keyboard | Xbox Wireless Controller / DualShock 4 / Fight Stick |

---

## Download and Quick Start

### 1. Download the Release Bundle
Download `Tekken_Tag_Tournament_2_PC_v0.1.6_GitHub_Release.zip` from the [Releases Page](https://github.com/divyprj/tekken-tag-tournament-2-pc-port/releases/tag/v0.1.6).

### 2. Extract the Package
Extract the downloaded zip archive to your preferred game directory (for example, `C:\Games\TTT2`).

### 3. Supply Your Legally Dumped Game Disc
Place your legally dumped Xbox 360 disc image in the same directory:
- **Expected Filename:** `Tekken Tag Tournament 2 (USA, Europe).iso`
- **Expected File Size:** Approximately `8,738,846,720 bytes` (8.13 GiB)
- **Title ID:** `4E4D0859`

### 4. Run the Automated Installer
Launch `ttt2_setup.exe` included in the release folder:
- The installer GUI will open automatically.
- Select your ISO file when prompted.
- The installer will unpack the base data containers (`data000.bin` to `data041.bin`) into `game/`, apply Title Update 3 (`data042.bin` to `data053.bin`), and verify container integrity.

### 5. Launch and Play
Double-click `Tekken Tag Tournament 2.exe` to launch the game. Shaders are compiled and cached on demand during the first match of each stage; subsequent matches load precompiled shaders instantly.

For comprehensive setup instructions, see [docs/INSTALL_GUIDE.md](docs/INSTALL_GUIDE.md).

---

## Technical Architecture

> [!NOTE]
> **Upstream Engine vs. Wrapper Distinction:** The C++ source components listed below (`gpu_render.cpp`, `kernel_xam.cpp`, `save_store.cpp`, etc.) reflect the upstream recompilation engine developed by **Shihab Al-Amri** and **hedge-dev**. They exist in the upstream repository, not locally in this repository. This repository provides packaging automation, configuration presets, application branding, and end-user documentation.

For a full breakdown of component boundaries, see [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

| Subsystem | Location | Technical Function |
|---|---|---|
| **Static Recompilation Engine** | `XenonRecomp` (Upstream) | Statically decompiles Xbox 360 PowerPC bytecode into native x86_64 C++ translation units. |
| **DirectX 11 Video Core** | `gpu_render.cpp` (Upstream) | Translates Xbox 360 GPU microcode and shader constants into Direct3D 11 draw commands with on-demand disk caching. |
| **Input Dispatch Engine** | `kernel_xam.cpp` (Upstream) | Intercepts XInput hardware packets and routes keyboard scan codes to game controller registers. |
| **Save and Profile Storage** | `save_store.cpp` (Upstream) | Sandboxes save state and player profiles in `%LOCALAPPDATA%\TTT2Recomp\saves\`. |
| **Asset Extractor** | `ttt2_setup.exe` (Upstream) | Unpacks and decompresses Xbox 360 disc partitions without redistributing copyrighted media. |
| **Packaging & Automation** | `scripts/` (This Repository) | Hardened PowerShell packaging automation enforcing file allowlists and checksum generation. |
| **Diagnostic Utilities** | `tools/` (This Repository) | Standalone maintenance scripts for safe save state backup and resets. |

---

## Controls and Multiplayer

### Player 1 Default (Tekken 7 PC Style)
- **Movement:** `W`, `A`, `S`, `D`
- **Left Punch (1 / LP):** `U`
- **Right Punch (2 / RP):** `I`
- **Left Kick (3 / LK):** `J`
- **Right Kick (4 / RK):** `K`
- **Tag / Partner Switch:** `O`
- **Start / Confirm:** `Enter`
- **Select / Reset:** `Space`

### Player 2 Shared Keyboard (Numeric Keypad)
- **Movement:** Arrow Keys (`Up`, `Down`, `Left`, `Right`)
- **Left Punch (1 / LP):** `Numpad 7`
- **Right Punch (2 / RP):** `Numpad 8`
- **Left Kick (3 / LK):** `Numpad 4`
- **Right Kick (4 / RK):** `Numpad 5`
- **Tag / Partner Switch:** `Numpad 9`

*Note: Because Windows merges physical keyboard inputs into a single hardware queue, simultaneous two-player play on a single keyboard requires a virtual controller tool such as x360ce to map Player 2 to a virtual gamepad.*

### Controller Layout (XInput / Xbox / PlayStation)
- **Movement:** D-Pad or Left Analog Stick
- **Buttons:** `X` (LP), `Y` (RP), `A` (LK), `B` (RK)
- **Tag:** `RB` / `R1`
- **Pause / Menu:** `Start`

For detailed arcade fight stick remapping, Pair Play configuration, and Steam Remote Play guidelines, see [docs/CONTROLS.md](docs/CONTROLS.md) and [docs/MULTIPLAYER.md](docs/MULTIPLAYER.md).

---

## Strict Anti-Piracy and Fair Use Declaration

This project strictly adheres to international copyright legislation, fair use doctrine, and software preservation ethics:

1. **No Copyrighted Files:** This repository and its releases do not contain, host, or link to copyrighted ROMs, ISOs, character models, textures, voice clips, or audio tracks.
2. **No Circumvention:** The translation layer does not bypass DRM or licensing controls; it executes instructions present in the user's legally acquired dump.
3. **Strict Non-Commercial Policy:** This wrapper project is non-commercial, free, and developed purely for interoperability, research, and technical preservation.
4. **No Piracy Links:** Repository maintainers will not provide, host, or link to unauthorized sources of commercial game dumps.

For full legal terms, see [DISCLAIMER.md](DISCLAIMER.md).

---

## Troubleshooting and Helper Tools

All helper scripts are located in the `tools/` directory to keep the root directory clean:

- **Resetting Save Data (`tools/Reset_Save_Data.bat`):**
  If you wish to wipe previous match history, reset character customizations, and start with a fresh player profile, run `tools/Reset_Save_Data.bat`. Your existing data is backed up before clearing.
- **Windows Defender SmartScreen Notice:**
  Because community releases are unsigned, Windows Defender SmartScreen may display an *"Unrecognized app"* prompt. Click **"More info"** and then **"Run anyway"**.
- **Windows 11 Smart App Control:**
  If Smart App Control blocks the application with error `0xc0e90002`, consult official Windows Security settings to adjust SAC mode. *Never run scripts that modify undocumented Code Integrity registry keys.*
- **Shader Cache Reset:**
  If visual artifacts occur after a GPU driver update, delete `%LOCALAPPDATA%\TTT2Recomp\shadercache\` and restart the game.

For further solutions, consult [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md).

---

## Credits and Upstream Authors

This distribution builds upon the foundational achievements of open-source reverse engineers and recompilation pioneers:

- **Shihab Al-Amri ([shihabal3amri](https://github.com/shihabal3amri)):**
  Lead creator and developer of the [Tekken Tag Tournament 2 PC Port](https://github.com/shihabal3amri/tekken-tag-tournament-2-pc). Implemented the native static recompilation architecture, memory patches, asset extraction pipeline (`ttt2_setup.exe`), and DirectX 11 runtime integration.
- **hedge-dev:**
  Creator and maintainer of [XenonRecomp](https://github.com/hedge-dev/XenonRecomp), the open-source Xbox 360 binary recompiler that enables translating PowerPC instructions into native x86_64 C++ code.
- **The Xenia Project Team:**
  Developers of the [Xenia Xbox 360 Emulator](https://github.com/xenia-project/xenia). Their reverse-engineering of the Xbox 360 kernel, audio processing, and GPU microcode provided the essential reference foundation for modern recompilations.
- **Microsoft Corporation:**
  DirectX runtime APIs and Visual C++ Redistributable components.
- **Valve Corporation:**
  Steamworks SDK (`steam_api64.dll`) for peer-to-peer multiplayer interoperability.
- **Bandai Namco Entertainment Inc.:**
  Original developers and copyright holders of *Tekken Tag Tournament 2*. All rights, characters, assets, and game code belong to Bandai Namco Entertainment Inc.

---

## Applied Licenses and Third-Party Notices

- **Repository License:** Distribution wrapper scripts, documentation, and configuration files are distributed under the [MIT License](LICENSE) with a non-commercial software preservation notice.
- **Third-Party Notices:** Complete license texts, upstream credits, and dependency details are documented in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
- **Intellectual Property Notice:** *Tekken Tag Tournament 2* is a registered trademark of Bandai Namco Entertainment Inc. All rights reserved.
