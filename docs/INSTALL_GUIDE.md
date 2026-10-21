# Installation and Setup Guide

This guide walks you through setting up the Tekken Tag Tournament 2 PC Port using the standalone distribution wrapper and your legally owned game disc dump.

---

## Prerequisites

1. **Operating System:** Windows 10 (64-bit, Version 1903+) or Windows 11 (64-bit).
2. **Graphics Hardware:** DirectX 11 compatible GPU (NVIDIA GeForce GTX 1050 / AMD Radeon RX 560 or newer).
3. **Runtime Dependencies:** Microsoft Visual C++ 2015-2022 Redistributable (x64). If missing, install from:
   https://aka.ms/vs/17/release/vc_redist.x64.exe
4. **Legally Sourced Game Disc Dump:**
   - A 1:1 dump of your retail Xbox 360 game disc in ISO format:
     `Tekken Tag Tournament 2 (USA, Europe).iso`
   - **Title ID:** `4E4D0859`
   - **Expected Size:** Approximately `8,738,846,720 bytes` (8.13 GiB)
5. **Storage:** At least 15 GB of free space on an NTFS drive (SSD recommended).

---

## Step-by-Step Installation

### Step 1: Extract the Release Package
Extract the release zip file (`Tekken_Tag_Tournament_2_PC_v0.1.6_GitHub_Release.zip`) into your preferred folder (e.g., `C:\Games\TTT2`).

The folder should contain:
- `Tekken Tag Tournament 2.exe` (Main game executable)
- `ttt2_setup.exe` (Asset extractor and installer)
- `settings.ini` (Default configuration)
- Runtime DLLs (`msvcp140.dll`, `vcruntime140.dll`, `steam_api64.dll`, etc.)
- `tools/` directory containing `Reset_Save_Data.bat`
- Documentation files

### Step 2: Supply Your Game Dump
Place your `Tekken Tag Tournament 2 (USA, Europe).iso` file into the game directory or keep note of its location.

### Step 3: Run the Setup Utility
1. Double-click `ttt2_setup.exe`.
2. When prompted, select your `Tekken Tag Tournament 2 (USA, Europe).iso` file.
3. The extractor will unpack the Xbox 360 disc containers into the `game/` subdirectory.
4. **Character Roster and Updates:**
   - Standard retail disc extraction unpacks the base 42 fighters (`data000.bin` to `data041.bin`).
   - To unlock the complete 59-fighter roster (including all 17 console DLC and transformation characters), Title Update 3 (`data042.bin` through `data053.bin`) is processed and applied by the setup utility.
5. Wait for the extraction progress bar to finish.

### Step 4: First Launch & Shader Caching
1. Double-click `Tekken Tag Tournament 2.exe` to launch the game.
2. **On-Demand Disk Shader Caching:** On the first match of each stage, DirectX 11 compute and pixel shaders are compiled as visual effects appear and saved to:
   `%LOCALAPPDATA%\TTT2Recomp\shadercache\`
   This may cause minor momentary pauses during the first 10-30 seconds of a new stage. Subsequent launches and matches load precompiled bytecode from disk instantly with smooth frame pacing.

---

## Windows Security and SmartScreen Notice

Because this is an open-source community port without an expensive commercial code-signing certificate:

- **Windows Defender SmartScreen:**
  Windows may display a blue warning: *"Windows protected your PC — Microsoft Defender SmartScreen prevented an unrecognized app from starting."*
  - This is standard behavior for newly released, unsigned community executables.
  - To proceed safely: Click **"More info"**, verify the publisher says *Unknown publisher*, and click **"Run anyway"**.
- **Windows 11 Smart App Control (SAC):**
  - Smart App Control is an enterprise-derived feature that strictly blocks all unsigned binaries on some Windows 11 installations.
  - If your system has Smart App Control set to "On" and blocks the game with error `0xc0e90002`:
    1. Open **Windows Security** from the Start menu.
    2. Go to **App & browser control** > **Smart App Control settings**.
    3. You can set the mode to **Evaluation** or **Off** in accordance with official Microsoft documentation.
    4. *Never* run third-party scripts that modify Windows registry Code Integrity keys. Standard Windows Defender real-time antivirus protection remains fully active.

---

## Maintenance and Save Data

- User settings, profile progress, and custom button layouts are saved in `%LOCALAPPDATA%\TTT2Recomp\`.
- To completely reset match history, ranks, and custom profiles back to factory defaults, run:
  `tools\Reset_Save_Data.bat`
