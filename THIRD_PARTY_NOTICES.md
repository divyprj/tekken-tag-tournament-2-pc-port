# Third-Party Software Notices and Intellectual Property Attribution

This document contains licensing terms, copyright notices, and provenance information for third-party software, libraries, tools, and runtimes used in or bundled with the Tekken Tag Tournament 2 PC Port distribution wrapper.

---

## Table of Contents

1. [Upstream Game Port Engine — Shihab Al-Amri](#1-upstream-game-port-engine--shihab-al-amri)
2. [XenonRecomp Recompilation Framework — hedge-dev](#2-xenonrecomp-recompilation-framework--hedge-dev)
3. [The Xenia Project — Emulation Reverse Engineering](#3-the-xenia-project--emulation-reverse-engineering)
4. [Microsoft Visual C++ Redistributable Runtime](#4-microsoft-visual-c-redistributable-runtime)
5. [Valve Steamworks SDK](#5-valve-steamworks-sdk)
6. [Statically Linked Upstream Libraries](#6-statically-linked-upstream-libraries)
7. [Intellectual Property and Trademarks — Bandai Namco Entertainment Inc.](#7-intellectual-property-and-trademarks--bandai-namco-entertainment-inc)

---

## 1. Upstream Game Port Engine — Shihab Al-Amri

- **Component:** Tekken Tag Tournament 2 PC Port Runtime & Asset Extractor
- **Original Author:** Shihab Al-Amri ([shihabal3amri](https://github.com/shihabal3amri))
- **Source Repository:** https://github.com/shihabal3amri/tekken-tag-tournament-2-pc
- **Bundled Binaries:** `Tekken Tag Tournament 2.exe` (v0.1.6), `ttt2_setup.exe` (v0.1.6)
- **Provenance Note:** The binaries distributed in this wrapper are compiled upstream binaries whose `.rsrc` sections were modified via Win32 `UpdateResourceW` to embed custom multi-resolution application icons (`ttt2_icon.ico` and `setup_icon.ico`). The executable machine code (`.text` section) is unmodified from upstream release v0.1.6.
- **License:** MIT License

```
MIT License

Copyright (c) 2024-2026 Shihab Al-Amri

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 2. XenonRecomp Recompilation Framework — hedge-dev

- **Component:** XenonRecomp (Xbox 360 Static Binary Recompiler)
- **Original Author:** hedge-dev ([hedge-dev](https://github.com/hedge-dev))
- **Source Repository:** https://github.com/hedge-dev/XenonRecomp
- **Role:** Statically translates Xbox 360 PowerPC bytecode into native x86_64 C++ translation units compiled into the game binary.
- **License:** MIT License

```
MIT License

Copyright (c) 2023-2026 hedge-dev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 3. The Xenia Project — Emulation Reverse Engineering

- **Component:** Xenia (Xbox 360 Research and Kernel Emulation Reference)
- **Original Author:** The Xenia Project Contributors ([xenia-project](https://github.com/xenia-project))
- **Source Repository:** https://github.com/xenia-project/xenia
- **Role:** Foundational reverse-engineering research on Xbox 360 system calls, memory architecture, XMA audio processing, and GPU microcode translation.
- **License:** BSD 3-Clause License

```
Copyright (c) 2013-2026, The Xenia Project Contributors
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```

---

## 4. Microsoft Visual C++ Redistributable Runtime

- **Files:** `msvcp140.dll`, `msvcp140_atomic_wait.dll`, `vcruntime140.dll`, `vcruntime140_1.dll`
- **Copyright:** Copyright (c) Microsoft Corporation. All rights reserved.
- **Role:** Standard C/C++ runtime dynamic link libraries required for x86_64 MSVC-compiled applications.
- **Distribution Terms:** Redistributed in accordance with Microsoft Visual Studio 2022 Redistributable Code terms. Users may also install the official runtime directly from:
  https://aka.ms/vs/17/release/vc_redist.x64.exe

---

## 5. Valve Steamworks SDK

- **File:** `steam_api64.dll`
- **Copyright:** Copyright (c) Valve Corporation. All rights reserved.
- **Role:** Enables Steam overlay integration and peer-to-peer multiplayer networking.
- **Distribution Terms:** Governed by the Valve Steamworks License Agreement. Requires a local Steam client installation to initiate peer-to-peer sessions.

---

## 6. Statically Linked Upstream Libraries

The compiled upstream runtime incorporates the following third-party open-source libraries:

- **FFmpeg** (GNU Lesser General Public License v2.1 or later):
  Audio streaming and multi-channel XMA packet decoding.
  Source: https://ffmpeg.org
- **libmspack** (GNU Lesser General Public License v2.1):
  Decompression of Microsoft Cabinet and LZX disc archives.
  Source: https://www.cabextract.org.uk/libmspack/
- **tiny-AES-c** (Unlicense / Public Domain):
  Portable AES-128/192/256 decryption routines for Title Update containers.
  Source: https://github.com/kokke/tiny-AES-c

---

## 7. Intellectual Property and Trademarks — Bandai Namco Entertainment Inc.

- **Tekken Tag Tournament 2**, the *Tekken* franchise, logos, character names, likenesses, voice recordings, visual animations, 3D meshes, textures, music tracks, and related trade dress are registered trademarks and copyrighted works of **Bandai Namco Entertainment Inc.**
- All rights are reserved by Bandai Namco Entertainment Inc.
- This distribution wrapper contains **zero proprietary game media**. Users are required to extract necessary game containers from their own legally dumped retail Xbox 360 disc.
