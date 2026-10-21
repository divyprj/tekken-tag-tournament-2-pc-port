# Troubleshooting and FAQ Guide

This document provides technical solutions for common configuration, runtime, and hardware compatibility issues with the Tekken Tag Tournament 2 PC Port.

---

## 1. Windows Security: SmartScreen and Smart App Control

Because this port is an open-source community release distributed without a commercial EV code-signing certificate, Windows security features may prompt for user confirmation on first launch.

### A. Windows Defender SmartScreen ("Windows protected your PC")
- **Symptom:** Windows displays a blue SmartScreen prompt preventing the app from starting: *"Microsoft Defender SmartScreen prevented an unrecognized app from starting."*
- **Resolution:**
  1. Click the **"More info"** link on the dialog.
  2. Confirm the application name shows `Tekken Tag Tournament 2.exe` and the publisher is *Unknown publisher*.
  3. Click **"Run anyway"**.
  4. Windows remembers your approval for future launches.

### B. Windows 11 Smart App Control (Error Code 0xc0e90002)
- **Symptom:** Windows displays: *"This command cannot be run due to the error: An Application Control policy has blocked this file."*
- **Cause:** Smart App Control (SAC) is an enterprise-derived feature on Windows 11 that enforces strict Code Integrity policies, blocking unsigned community binaries unless they possess established cloud reputation.
- **Resolution:**
  1. Open the Start menu, type `Windows Security`, and press Enter.
  2. Select `App & browser control` in the left navigation menu.
  3. Click `Smart App Control settings`.
  4. Refer to official Microsoft documentation for adjusting Smart App Control modes (Evaluation or Off).
  5. *Important Safety Notice:* Never execute third-party scripts or registry patches that write to `HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy`. Manipulating Code Integrity keys can corrupt Windows security policies and destabilize your system. Standard Microsoft Defender Antivirus and Firewall protections remain fully active when running community applications.

---

## 2. On-Demand Shader Compilation

### Symptom
During the first 5 to 10 seconds of a match or after entering a newly loaded stage, brief momentary frame-time pauses or stutter occur.

### Cause
The DirectX 11 rendering pipeline compiles GPU compute and pixel shaders on demand upon their first appearance. Compiled binary bytecode is saved to your local disk cache:
`%LOCALAPPDATA%\TTT2Recomp\shadercache\`

### Resolution
This is expected behavior during the first match on any given stage. Once visual effects and stage shaders have rendered once, subsequent matches load precompiled bytecode directly from disk with smooth frame pacing.

---

## 3. Black Screen on Startup

### Symptom
The game window opens but displays only a black screen without advancing to opening screens or menus.

### Common Causes and Fixes
1. **Incomplete Game Data:**
   Verify that the retail data containers (`data000.bin` through `data041.bin`) and `tekken.img` are present in the `game/` folder. For the complete 59-fighter roster, ensure Title Update 3 containers (`data042.bin` through `data053.bin`) are present.
2. **Missing Visual C++ Redistributable:**
   Ensure the 64-bit Visual C++ runtime is installed on your machine. You can download the latest official installer from Microsoft:
   https://aka.ms/vs/17/release/vc_redist.x64.exe
3. **Corrupted Configuration:**
   If graphical settings become corrupted, navigate to `%LOCALAPPDATA%\TTT2Recomp\` and delete `settings.ini`. The game will generate a fresh default configuration on the next launch.

---

## 4. Gamepad and Arcade Stick Detection

### Symptom
Button presses on an attached controller produce no response in-game.

### Solutions
1. **XInput Controllers (Xbox 360, Xbox One, Xbox Series X|S):**
   Connect the controller before launching the game. XInput devices are detected natively by the engine.
2. **PlayStation Controllers (DualShock 4, DualSense):**
   Windows does not map PlayStation controllers to XInput natively. Enable **PlayStation Controller Support** in Steam Settings (Steam Input), or run DS4Windows so the device presents as standard XInput.
3. **Controller Ordering:**
   If flight simulator pedals, virtual audio devices, or multiple joysticks are connected, Windows may assign Player 1 to an unexpected controller slot. Disconnect secondary game devices so your main controller occupies XInput Slot 0.

---

## 5. Two-Player Shared Keyboard Configuration

### Symptom
When two players attempt to play on a single physical keyboard, only Player 1's inputs register or keystrokes conflict.

### Cause
The Windows OS aggregates all physical keyboard inputs into a single hardware message queue. The native game engine treats keyboard input as Player 1 by default.

### Resolution
To enable two-player local combat on a single physical keyboard, use a virtual controller remapper (such as `x360ce` or `Keyboard2Xinput`):
1. Configure the remapping utility to capture Player 2's keys (e.g. numeric keypad: Numpad 7, 8, 4, 5, 9, Enter).
2. Map these keys to **Virtual XInput Controller 2**.
3. In-game, Player 2 presses the mapped Start button to join as Controller 2.

---

## 6. Window Modes and Display Resolution

- **Toggle Fullscreen:** Press `Alt + Enter` at any time to toggle between windowed and borderless fullscreen modes.
- **Internal Resolution:** Navigate to `OPTIONS > DISPLAY SETTINGS` in the main menu to choose internal rendering resolutions (1080p, 1440p, or 4K).

---

## 7. Resetting Save Data and Unlocked Records

### Symptom
You wish to wipe previous match history, reset ghost battle progress, and start with a clean slate.

### Fix
Run `tools\Reset_Save_Data.bat`.
This safe utility backs up your current profile to `%LOCALAPPDATA%\TTT2Recomp\saves_backup\` before clearing the active save directory.
