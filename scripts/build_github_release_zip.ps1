# Script to build the official GitHub Release asset package
# Adheres to the SpartanPort open-source distribution model:
# Distributes only the compiled launcher, installer, and runtime binaries without proprietary game assets.

param(
    [string]$RootWorkspace = (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)),
    [string]$OutputDir = (Join-Path (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)) "Distributable_Archives")
)

Write-Host "Building GitHub Releases asset package..."

if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

$stageDir = Join-Path $OutputDir "github_release_staging"
if (Test-Path $stageDir) {
    Remove-Item -Recurse -Force $stageDir
}
New-Item -ItemType Directory -Path $stageDir | Out-Null

# Copy installer and tool binaries
$setupExe = Join-Path $RootWorkspace "ttt2_setup.exe"
if (Test-Path $setupExe) {
    Copy-Item $setupExe -Destination $stageDir
    Write-Host "Added ttt2_setup.exe"
} else {
    Write-Error "ttt2_setup.exe not found at $setupExe"
    exit 1
}

# Copy patched executable and runtime assets from release folder
$releaseSource = Join-Path $RootWorkspace "Tekken Tag Tournament 2 - PC Release"

$binaries = @(
    "Tekken Tag Tournament 2.exe",
    "steam_api64.dll",
    "msvcp140.dll",
    "msvcp140_atomic_wait.dll",
    "vcruntime140.dll",
    "vcruntime140_1.dll",
    "icon.ico",
    "settings.ini",
    "README.txt"
)

foreach ($b in $binaries) {
    $src = Join-Path $releaseSource $b
    if (Test-Path $src) {
        Copy-Item $src -Destination $stageDir
        Write-Host "Added $b"
    }
}

# Create tools subfolder in staging
$stageTools = Join-Path $stageDir "tools"
New-Item -ItemType Directory -Path $stageTools -Force | Out-Null

$toolFiles = @(
    "Reset_Save_Data.bat",
    "Restore_Smart_App_Control.bat"
)

foreach ($t in $toolFiles) {
    $srcTool = Join-Path $releaseSource "tools\$t"
    if (Test-Path $srcTool) {
        Copy-Item $srcTool -Destination $stageTools
        Write-Host "Added tools\$t"
    }
}

# Create INSTALL_GUIDE.txt inside the package
$installGuidePath = Join-Path $stageDir "INSTALL_GUIDE.txt"
$installGuideContent = @"
================================================================================
TEKKEN TAG TOURNAMENT 2 - PC PORT INSTALLATION GUIDE
Open-Source Preservation Distribution (SpartanPort Model)
================================================================================

PREREQUISITES:
1. Windows 10 (64-bit) or Windows 11 (64-bit).
2. DirectX 11 compatible graphics card (NVIDIA GTX 1050 / AMD RX 560 or newer).
3. A legally dumped Xbox 360 copy of Tekken Tag Tournament 2 in ISO format:
   Filename: Tekken Tag Tournament 2 (USA, Europe).iso
4. Approximately 15 GB of free hard drive space.

--------------------------------------------------------------------------------
STEP-BY-STEP SETUP:
--------------------------------------------------------------------------------
1. Place this release folder and your 'Tekken Tag Tournament 2 (USA, Europe).iso'
   in the same folder, or remember the path to your ISO file.

2. Run 'ttt2_setup.exe'.
   - The installer window will appear.
   - Select your ISO file when prompted.
   - The installer will automatically extract the game containers, unpack the
     assets into a 'game' subdirectory, apply Title Update 3, and verify integrity.
   - Wait for the progress bar to reach 100%.

3. (Optional / Pre-Patched Update)
   - Replace 'Tekken Tag Tournament 2.exe' with the patched binary included in
     this zip to ensure custom title bar branding and latest input latency fixes.

4. Launch the game:
   - Double-click 'Tekken Tag Tournament 2.exe'.
   - First launch will compile shaders (20 to 60 seconds). Subsequent launches
     will open instantly.

--------------------------------------------------------------------------------
CONTROLS (TEKKEN 7 KEYBOARD & CONTROLLER MAPPINGS):
--------------------------------------------------------------------------------
Player 1 (Controller):
  D-Pad / Left Stick : Movement
  X (Square)         : Left Punch (LP / 1)
  Y (Triangle)       : Right Punch (RP / 2)
  A (Cross)          : Left Kick (LK / 3)
  B (Circle)         : Right Kick (RK / 4)
  RB / R1            : Tag (Change Partner)
  Start              : Pause / Menu

Player 1 (Keyboard Default):
  W / A / S / D      : Movement
  U                  : Left Punch (1)
  I                  : Right Punch (2)
  J                  : Left Kick (3)
  K                  : Right Kick (4)
  O                  : Tag
  Enter / Space      : Start / Select

Player 2 (Shared Keyboard):
  Arrow Keys         : Movement
  Numpad 7           : Left Punch (1)
  Numpad 8           : Right Punch (2)
  Numpad 4           : Left Kick (3)
  Numpad 5           : Right Kick (4)
  Numpad 9           : Tag

--------------------------------------------------------------------------------
TROUBLESHOOTING:
--------------------------------------------------------------------------------
- Windows 11 Smart App Control (Error 0xc0e90002):
  Run 'tools\Restore_Smart_App_Control.bat' as Administrator if Smart App Control blocks
  execution.
- Black screen on startup:
  Wait 60 seconds for DirectX 11 shader pipelines to compile.
- Missing DLL errors:
  Install the latest Microsoft Visual C++ Redistributable (x64) from Microsoft:
  https://aka.ms/vs/17/release/vc_redist.x64.exe
- Reset save data:
  Run 'tools\Reset_Save_Data.bat' to wipe local played records and start fresh.

For full documentation and updates, visit the GitHub repository.
================================================================================
"@

[System.IO.File]::WriteAllText($installGuidePath, $installGuideContent, [System.Text.Encoding]::ASCII)

$zipOutput = Join-Path $OutputDir "Tekken_Tag_Tournament_2_PC_v0.1.6_GitHub_Release.zip"
if (Test-Path $zipOutput) {
    Remove-Item -Force $zipOutput
}

Write-Host "Compressing release package to $zipOutput..."
Compress-Archive -Path "$stageDir\*" -DestinationPath $zipOutput -CompressionLevel Optimal

Remove-Item -Recurse -Force $stageDir

$zipItem = Get-Item $zipOutput
$sizeMB = [Math]::Round($zipItem.Length / 1MB, 2)
Write-Host "GitHub Releases package created successfully: $sizeMB MB ($($zipItem.Length) bytes)."
