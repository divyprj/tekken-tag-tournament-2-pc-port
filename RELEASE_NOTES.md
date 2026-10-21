# Release Notes: Tekken Tag Tournament 2 PC Port (Version 0.1.6)

This release implements a standalone distribution package and configuration bundle for the native x86_64 DirectX 11 PC port of Tekken Tag Tournament 2, based on the open-source static recompilation port by Shihab Al-Amri (shihabal3amri) and the XenonRecomp framework.

No proprietary game assets or copyrighted containers are bundled in this release. Users must supply their own legally dumped Xbox 360 game disc image (ISO) to extract the game assets.

---

## Credits and Upstream Attribution

Full credit and gratitude to the open-source developers who built the underlying recompilation technology and port:

- **Shihab Al-Amri (shihabal3amri):** Lead developer of the Tekken Tag Tournament 2 PC Port project, memory patching, and DirectX 11 runtime integration.
- **hedge-dev:** Creator of XenonRecomp, the Xbox 360 static binary recompiler.
- **The Xenia Project:** Pioneers of Xbox 360 emulation and reverse engineering.
- **Bandai Namco Entertainment Inc.:** Original creators and copyright holders of Tekken Tag Tournament 2.

---

## What Is New in Version 0.1.6

### 1. Native DirectX 11 Execution Engine
- Full x86_64 native translation running under DirectX 11.
- Stable, locked 60 FPS performance without frame-pacing stutter.
- All 59 characters unlocked including console DLC and bonus fighters.
- Full access to all stages, Practice Mode, Arcade, Ghost Battle, Pair Play, and Tag Survival.

### 2. Professional Window Branding and Application Icon
- Clean window title bar formatted as "TEKKEN TAG TOURNAMENT 2" (recompilation tag stripped).
- High-resolution multi-scale PE icon resource embedded directly into the executable (sizes from 16x16 to 256x256).

### 3. Tekken 7 Keyboard and Multi-Input Architecture
- Player 1 keyboard controls mapped to the competitive Tekken 7 standard:
  - W / A / S / D: Directional movement
  - U: Left Punch (1 / LP)
  - I: Right Punch (2 / RP)
  - J: Left Kick (3 / LK)
  - K: Right Kick (4 / RK)
  - O: Tag / Switch Partner
  - Enter: Start / Menu Confirm
  - Space: Select / Reset
- Player 2 local keyboard layout enabled on the numeric keypad:
  - Arrow Keys: Directional movement
  - Numpad 7: Left Punch (1)
  - Numpad 8: Right Punch (2)
  - Numpad 4: Left Kick (3)
  - Numpad 5: Right Kick (4)
  - Numpad 9: Tag
- Simultaneous 2-player gameplay verified on:
  - Two controllers (XInput Player 1 and Player 2)
  - One controller (Player 1) and one keyboard (Player 2)
  - One keyboard (Player 1) and one controller (Player 2)
  - Single shared keyboard across two players

### 4. Windows 11 Smart App Control and Save Reset Utilities
- Includes `tools\Restore_Smart_App_Control.bat` to resolve error code `0xc0e90002` if Windows Smart App Control blocks unsigned custom native binaries.
- Includes `tools\Reset_Save_Data.bat` to reset local played statistics, match history, and start with a clean slate.

---

## Release Asset Checksums (SHA-256)

| File | Size | SHA-256 Checksum |
|---|---|---|
| `Tekken_Tag_Tournament_2_PC_v0.1.6_GitHub_Release.zip` | 31.41 MB | `1BC4C144D015A5BF287F906E10C40A0681DB082D547C7F57BA785970A88B85A6` |
| `Tekken Tag Tournament 2.exe` | 61.04 MB | `D8AD223398C989D60D2B929DC175C7C54AAE63466CFD6BBCFF032DC81398CC80` |
| `ttt2_setup.exe` | 62.45 MB | `068B5CFCB4B5406284CED3D8927737EE8617836F1F8B4865A7AA6462D1AD18E5` |

---

## Quick Setup Guide for End Users

1. Download `Tekken_Tag_Tournament_2_PC_v0.1.6_GitHub_Release.zip` from the Releases tab.
2. Extract the archive into a folder on your PC (for example, `C:\Games\TTT2`).
3. Obtain your legally dumped Xbox 360 copy: `Tekken Tag Tournament 2 (USA, Europe).iso`.
4. Run `ttt2_setup.exe` and select the ISO file when prompted. The installer will unpack the game files and verify integrity.
5. Launch the game by double-clicking `Tekken Tag Tournament 2.exe`.

---

## Legal and Strict Anti-Piracy Notice

Tekken Tag Tournament 2 is a trademark and copyright of Bandai Namco Entertainment Inc. This project is a non-commercial, open-source preservation initiative. No proprietary game assets, media files, or copyrighted code are distributed in this repository or its release packages. This project does not promote or endorse piracy. All players must supply assets extracted directly from their own legally dumped retail disc image.
