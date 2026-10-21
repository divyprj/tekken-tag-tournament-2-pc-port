# Tekken Tag Tournament 2 PC Port

An unofficial native PC port of Tekken Tag Tournament 2, recompiled from the Xbox 360 release for 64-bit Windows systems.

This project executes original game code directly on x86-64 hardware using a custom DirectX 11 runtime environment. It eliminates the CPU and GPU overhead associated with traditional system emulation, delivering locked 60 FPS gameplay, native 4K resolution support, and minimal input latency.

Modeled after modern static recompilation efforts such as SpartanPort.

---

## Key Features

- Native Execution: Xbox 360 PowerPC instructions statically translated to native x86-64 machine code.
- Hardware-Accelerated Graphics: Custom Direct3D 11 rendering pipeline with full support for 1080p, 1440p, 4K, and ultrawide aspect ratios.
- Fluid Framerates: Locked 60 FPS combat simulation synchronized with display refresh rate.
- Full Roster Unlocked: All 59 combatants available immediately, including console bonus characters and DLC fighters.
- Low-Latency Controls: Direct XInput controller support and native keyboard input with in-game remapping.
- Local and Online Multiplayer: Local 2-player versus, cooperative Pair Play tag matches, and peer-to-peer online play via Steamworks.
- Self-Contained Runtime: Zero external emulator dependencies; all required C++ runtimes and audio libraries bundled locally.

---

## System Requirements

### Minimum Requirements
- Operating System: Windows 10 (64-bit, Version 1909 or higher) or Windows 11
- Processor: Intel Core i5-4460 / AMD FX-8350 or equivalent quad-core processor
- Memory: 8 GB RAM
- Graphics: NVIDIA GeForce GTX 750 Ti / AMD Radeon R7 260X (DirectX 11 compatible, 2 GB VRAM)
- Storage: 19 GB available space

### Recommended Specifications
- Operating System: Windows 11 (64-bit)
- Processor: Intel Core i5-10400 / AMD Ryzen 5 3600 (6 cores, 12 threads)
- Memory: 16 GB Dual-Channel RAM
- Graphics: NVIDIA GeForce GTX 1660 Super / RTX 3050 / AMD Radeon RX 5600 XT (4 GB+ VRAM)
- Input: Xbox Series X|S / Xbox One controller, DualSense, or arcade fightstick

---

## Installation and Quick Start

### Playing Pre-Packaged Releases
1. Download the release archive from the Releases section.
2. Extract the contents to any folder on your PC.
3. Launch `Play_Tekken_Tag_Tournament_2.bat` or `Tekken Tag Tournament 2.exe`.

### Building from Your Own Game Copy
To build the native binary using your legally owned disc image:
1. Extract your Xbox 360 disc image (`Tekken Tag Tournament 2.iso`).
2. Obtain Title Update 3 (`TU_174Q22P_0000008000000.00000000000O2`, Title ID `4E4D0859`).
3. Run the project extractor to unpack the disc containers into the `game/` asset directory.
4. Verify that `tekken.img`, `Default.xex`, and data containers `data000.bin` through `data053.bin` are present in `game/`.
5. Launch `Tekken Tag Tournament 2.exe`.

---

## Controls and Input Configuration

### Default Keyboard Mappings
- D-Pad Up: Up Arrow
- D-Pad Down: Down Arrow
- D-Pad Left: Left Arrow
- D-Pad Right: Right Arrow
- Left Punch (1 / X Button): Z
- Right Punch (2 / Y Button): X
- Left Kick (3 / A Button): A
- Right Kick (4 / B Button): S
- Left Bumper (1+2 / Throw): Q
- Right Bumper (Tag): W
- START: Enter or Space
- BACK: Backspace

### Tekken 7 Style Remapping (WASD + UIJK)
To configure the modern PC fighting game standard:
1. From the main menu, navigate to `OPTIONS > CONTROLLER SETUP`.
2. Highlight `BUTTON SETTINGS` and press Left or Right Arrow to switch from `PAD` to `KEYBOARD`.
3. Select each action on screen and assign your preferred key:
   - Movement: W, A, S, D
   - Punches and Kicks: U, I, J, K
   - Tag: O or Space
4. Save settings. Configurations are stored in `%LOCALAPPDATA%\TTT2Recomp\`.

Refer to `docs/CONTROLS.md` for Hitbox configurations and controller customization details.

---

## Multiplayer Setup

### Two Gamepads
Connect two XInput or DirectInput controllers. Controller 1 controls Player 1; Controller 2 controls Player 2. In `OFFLINE MODE > VS BATTLE`, Player 2 presses START to enter the character select screen.

### Single Shared Keyboard
Using a virtual gamepad feeder such as Keyboard2Xinput or x360ce, the right side of the keyboard (Arrow keys and Numpad) can be mapped to virtual Controller 2, allowing two players to fight on one physical keyboard.

### Cooperative Pair Play
Tekken Tag Tournament 2 supports 2 players on the same team. In VS Battle, choose Pair Play during team selection. Player 1 controls the active character, while Player 2 controls the tag partner.

Refer to `docs/MULTIPLAYER.md` for full multiplayer configuration guides.

---

## Windows 11 Smart App Control

Windows 11 includes Smart App Control (SAC), which blocks newly compiled open-source community binaries lacking commercial enterprise code-signing certificates with code `0xc0e90002`.

### Bypassing the Block
1. Open Windows Security from the Start menu.
2. Navigate to `App & browser control > Smart App Control settings`.
3. Toggle Smart App Control to `Off`.
4. Launch the game.

### Restoring Smart App Control
To restore Smart App Control to evaluation mode without reinstalling Windows:
1. Run `Restore_Smart_App_Control.bat` as administrator.
2. Restart your computer.

Refer to `docs/TROUBLESHOOTING.md` for comprehensive troubleshooting information.

---

## Legal and Fair Use Disclaimer

Tekken Tag Tournament 2 is a registered trademark and intellectual property of Bandai Namco Entertainment Inc.

This repository contains reverse-engineered runtime translation code and documentation intended solely for interoperability, research, and software preservation. This repository does not distribute copyrighted game assets, textures, audio recordings, or proprietary disc images. Users must provide their own legally purchased copy of the game.

---

## Credits and Acknowledgments

- Bandai Namco Entertainment: Original game development and fighting game legacy.
- Shihab Al-Amri: Native static recompilation engine and PC runtime architecture.
- Felipe Prado: SpartanPort reference project architecture and open-source documentation standards.
- Recomp Community: Tooling, shader decompilers, and Xbox 360 reverse engineering research.
