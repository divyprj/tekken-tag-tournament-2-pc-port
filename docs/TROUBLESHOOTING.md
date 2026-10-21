# Troubleshooting and FAQ Guide

This document provides technical solutions for common configuration and operational issues with the Tekken Tag Tournament 2 PC port.

---

## 1. Windows 11 Smart App Control (Code 0xc0e90002)

### Symptom
When attempting to launch the executable, Windows displays:
"This command cannot be run due to the error: An Application Control policy has blocked this file."

### Cause
Windows 11 includes an enterprise-derived feature called Smart App Control (SAC). SAC enforces kernel-level Code Integrity policies that block newly extracted, unsigned open-source binaries lacking a commercial Microsoft enterprise certificate.

### Resolution
1. Open the Start menu, type `Windows Security`, and press Enter.
2. Click `App & browser control` in the left navigation sidebar.
3. Click the `Smart App Control settings` link.
4. Set the toggle to `Off`. Confirm the Windows User Account Control prompt.
5. Standard Microsoft Defender Antivirus, Firewall, and Real-Time Protection remain fully active and functional.

### Re-Enabling Smart App Control without Reinstalling Windows
Microsoft states in their UI that disabling Smart App Control requires an operating system reinstall to re-enable. This restriction applies only to the user interface toggle. To restore Smart App Control to Evaluation Mode:
1. Right-click `Restore_Smart_App_Control.bat` and select `Run as administrator`.
2. This script writes `VerifiedAndReputablePolicyState = 2` to `HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy`.
3. Restart your computer. Smart App Control will be active upon reboot.

---

## 2. Initial Shader Compilation Stutter

### Symptom
During the very first 5 to 10 seconds of a match or after selecting a new stage, the framerate briefly drops or stutters.

### Cause
The native port compiles DirectX 11 compute and pixel shaders asynchronously on the first encounter. Compiled binary shaders are saved to your local disk cache.

### Resolution
This behavior is completely normal during the first run of any stage. Once a stage and its character visual effects have loaded once, compiled shaders are loaded instantly from `%LOCALAPPDATA%\TTT2Recomp\shadercache\` on subsequent matches with zero stutter.

---

## 3. Black Screen on Startup

### Symptom
The game window opens but displays only a black frame without progressing to the opening logos.

### Common Causes and Fixes
1. Missing Game Data:
   Verify that all 54 data containers (`data000.bin` through `data053.bin`) and `tekken.img` exist in the `game/` folder.
2. Missing Visual C++ Runtimes:
   Ensure `msvcp140.dll` and `vcruntime140.dll` are present in the root folder alongside the executable.
3. Corrupted User Cache:
   If settings become corrupted, navigate to `%LOCALAPPDATA%\TTT2Recomp\` and delete `settings.ini`. The game will generate a fresh default configuration on next boot.

---

## 4. Gamepad Not Detected

### Symptom
Buttons on an attached gamepad produce no response in-game.

### Fixes
1. Ensure the controller is connected before launching the executable.
2. For PlayStation DualShock 4 or DualSense controllers, run DS4Windows or enable PlayStation Controller Support in Steam Settings to ensure the device is presented as standard XInput.
3. If multiple gamepads or flight sim pedals are connected, disconnect secondary peripheral devices to ensure Player 1 is assigned to XInput Port 0.

---

## 5. Window Mode and Resolution Adjustment

To toggle between windowed mode and fullscreen at any time:
- Press `Alt + Enter` on your keyboard.
- Or navigate to `OPTIONS > DISPLAY SETTINGS` in the main menu to select your display mode (Windowed, Borderless Fullscreen, Exclusive Fullscreen) and internal rendering resolution (1080p, 1440p, 4K).
