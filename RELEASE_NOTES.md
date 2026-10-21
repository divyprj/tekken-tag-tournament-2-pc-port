# Release Notes: Tekken Tag Tournament 2 PC Port (Version 0.1.6)

This release implements a native x86_64 DirectX 11 PC port of Tekken Tag Tournament 2 for modern Windows systems, distributed using the SpartanPort open-source distribution model.

No proprietary game assets or copyrighted containers are bundled in this release. Users must supply their own legally dumped Xbox 360 game disc image (ISO) to extract the game assets.

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
| `Tekken_Tag_Tournament_2_PC_v0.1.6_GitHub_Release.zip` | 31.37 MB | `615C12ED856EF1012B670C431140EDFFC73A8F3CEAC1EB22BBBC8A5A52A62506` |
| `Tekken Tag Tournament 2.exe` | 61.04 MB | `D8AD223398C989D60D2B929DC175C7C54AAE63466CFD6BBCFF032DC81398CC80` |
| `ttt2_setup.exe` | 62.41 MB | `2E7813B0DF639B1BB49B88EC0F30E1EE61572087FD96BED2A87250F6AC14F666` |

---

## Quick Setup Guide for End Users

1. Download `Tekken_Tag_Tournament_2_PC_v0.1.6_GitHub_Release.zip` from the Releases tab.
2. Extract the archive into a folder on your PC (for example, `C:\Games\TTT2`).
3. Obtain your legally dumped Xbox 360 copy: `Tekken Tag Tournament 2 (USA, Europe).iso`.
4. Run `ttt2_setup.exe` and select the ISO file when prompted. The installer will unpack the game files and verify integrity.
5. Launch the game by double-clicking `Tekken Tag Tournament 2.exe`.

---

## Project Leadership and Credits

- **Divyansh Prajapati ([@divyprj](https://github.com/divyprj)):** Project Lead, Release Engineering, Input System Polish, Windows 11 Runtime Integration, and Packaging Architecture.
- **Shihab Al-Amri ([@shihabal3amri](https://github.com/shihabal3amri)):** Static recompilation translation layer and PC runtime foundations.
- **Felipe Prado ([@FelipePrado0](https://github.com/FelipePrado0)):** SpartanPort reference model and open-source documentation standards.
- **Bandai Namco Entertainment Inc.:** Original intellectual property and game creation.

---

## Legal and Strict Anti-Piracy Notice

Tekken Tag Tournament 2 is a trademark and copyright of Bandai Namco Entertainment Inc. This project is a non-commercial, open-source preservation initiative. No proprietary game assets, media files, or copyrighted code are distributed in this repository or its release packages. This project does not promote or endorse piracy. All players must supply assets extracted directly from their own legally dumped retail disc image.
