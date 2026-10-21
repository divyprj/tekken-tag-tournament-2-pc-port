# System Architecture and Component Separation

This document explains the technical architecture of the Tekken Tag Tournament 2 PC Port, delineating the exact boundaries between the **upstream compiled recompilation engine** and **this repository's distribution wrapper components**.

---

## 1. Architectural Overview & Boundaries

```
┌────────────────────────────────────────────────────────────────────────┐
│                        UPSTREAM ENGINE ARCHITECTURE                    │
│                 (shihabal3amri/tekken-tag-tournament-2-pc)             │
├──────────────────────────┬─────────────────────────────────────────────┤
│ XenonRecomp              │ • Static binary recompilation framework     │
│ (hedge-dev)              │ • PowerPC instruction translation to x86_64 │
├──────────────────────────┼─────────────────────────────────────────────┤
│ Recompiled Core Engine   │ • Direct3D 11 rendering backend             │
│ (Shihab Al-Amri)         │   (upstream: port/src/runtime/kernel/       │
│                          │    gpu_render.cpp)                          │
│                          │ • Input dispatch & XInput polling           │
│                          │   (upstream: port/src/runtime/kernel/       │
│                          │    kernel_xam.cpp)                          │
│                          │ • Local save & profile storage              │
│                          │   (upstream: port/src/runtime/kernel/       │
│                          │    save_store.cpp)                          │
│                          │ • Audio streaming via XMA decoding         │
│                          │   (upstream: port/src/runtime/kernel/       │
│                          │    audio_xaudio2.cpp)                       │
├──────────────────────────┴─────────────────────────────────────────────┤
│                    THIRD-PARTY RUNTIME DEPENDENCIES                    │
├────────────────────────────────────────────────────────────────────────┤
│ • msvcp140.dll, vcruntime140.dll (Microsoft Visual C++ Runtime)        │
│ • steam_api64.dll (Valve Steamworks Peer-to-Peer Networking)           │
├────────────────────────────────────────────────────────────────────────┤
│               THIS REPOSITORY'S CONTRIBUTIONS (divyprj)                │
├────────────────────────────────────────────────────────────────────────┤
│ • Standalone distribution wrapper & packaging pipeline (PowerShell)    │
│ • Verified executable branding (multi-res application icons in .rsrc)  │
│ • Tested configuration presets & defaults (config/settings.ini)        │
│ • End-user setup, multiplayer, and troubleshooting documentation       │
│ • Local maintenance utilities (tools/Reset_Save_Data.bat)              │
│ • Release verification & cryptographic checksum automation             │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Upstream Recompilation Engine Details

The compiled executable `Tekken Tag Tournament 2.exe` and setup tool `ttt2_setup.exe` are derived from the upstream project maintained by Shihab Al-Amri. The source files referenced below exist in the upstream repository, **not** locally in this distribution repository:

### A. Static Instruction Recompilation (XenonRecomp)
- Created by **hedge-dev**.
- Recompiles Xbox 360 PowerPC machine code statically into native x86_64 C++ translation units.
- Eliminates CPU emulation interpreter overhead, targeting a baseline 60 Hz game loop on supported modern hardware.

### B. Direct3D 11 Video Pipeline (Upstream: `gpu_render.cpp`)
- Implemented upstream by **Shihab Al-Amri**.
- Intercepts Xbox 360 GPU command buffers and translates shader constants and draw states into Direct3D 11 API calls.
- Employs **On-Demand Disk Shader Caching**: compute and pixel shaders are compiled as encountered and saved to `%LOCALAPPDATA%\TTT2Recomp\shadercache\`. Subsequent launches load bytecode from disk, eliminating first-encounter compilation pauses.

### C. Input Handling (Upstream: `kernel_xam.cpp`)
- Implemented upstream by **Shihab Al-Amri**.
- Polls native XInput controllers synchronously during each frame loop.
- Intercepts standard keyboard events and routes them to in-game controller registers.
- *Note:* Because Windows merges physical keyboards into a single hardware event queue, two-player local play on a single physical keyboard requires a virtual controller bridge (such as x360ce or Keyboard2Xinput) to map Player 2 to a virtual gamepad.

### D. Storage and Profile Sandboxing (Upstream: `save_store.cpp`)
- Implemented upstream by **Shihab Al-Amri**.
- Emulates the Xbox 360 Content Manager, redirecting save containers and profile data to `%LOCALAPPDATA%\TTT2Recomp\saves\`.

---

## 3. Scope of This Repository's Contributions

This repository is maintained as a **curated standalone distribution wrapper**:

1. **Packaging Automation:**
   - Hardened PowerShell packaging script (`scripts/build_github_release_zip.ps1`) enforcing strict file allowlists, rejecting proprietary game containers, and generating SHA-256 manifests.
2. **Configuration Presets:**
   - Pre-configured `settings.ini` establishing verified rendering, windowing, and audio settings.
3. **Application Icon Branding:**
   - Injected custom multi-resolution icons (16x16 up to 256x256) into the Win32 resource (`.rsrc`) section of the upstream executables using `UpdateResourceW`. The executable machine code (`.text` section) is unmodified.
4. **Maintenance Tooling:**
   - `tools/Reset_Save_Data.bat`: Cleanly backs up and resets user saves when starting fresh.
5. **Comprehensive User Documentation:**
   - Guides for installation, multiplayer controller mapping, keyboard configuration, and troubleshooting.
