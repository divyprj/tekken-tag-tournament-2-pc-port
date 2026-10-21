# Automated Packaging Script for Tekken Tag Tournament 2 PC Release
# Validates release integrity and creates a distributable zip archive

param(
    [string]$SourceDir = (Join-Path (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)) "Tekken Tag Tournament 2 - PC Release"),
    [string]$OutputDir = (Join-Path (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)) "Distributable_Archives")
)

Write-Host "Starting release packaging process..."

if (-not (Test-Path $SourceDir)) {
    Write-Error "Source directory not found: $SourceDir"
    exit 1
}

# Verify critical files
$requiredFiles = @(
    "Tekken Tag Tournament 2.exe",
    "steam_api64.dll",
    "msvcp140.dll",
    "vcruntime140.dll",
    "icon.ico",
    "settings.ini",
    "README.txt",
    "tools\Reset_Save_Data.bat",
    "tools\Restore_Smart_App_Control.bat",
    "game\Default.xex",
    "game\tekken.img"
)

$missing = @()
foreach ($f in $requiredFiles) {
    $full = Join-Path $SourceDir $f
    if (-not (Test-Path $full)) {
        $missing += $f
    }
}

if ($missing.Count -gt 0) {
    Write-Error "Missing critical files: $($missing -join ', ')"
    exit 1
}

# Verify data containers count
$dataFiles = Get-ChildItem -Path (Join-Path $SourceDir "game") -Filter "data*.bin"
Write-Host "Verified data containers count: $($dataFiles.Count)"
if ($dataFiles.Count -lt 40) {
    Write-Error "Incomplete data container set in game folder."
    exit 1
}

if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

$dateStr = Get-Date -Format "yyyyMMdd"
$zipPath = Join-Path $OutputDir "Tekken_Tag_Tournament_2_PC_v0.1.6_$dateStr.zip"

Write-Host "Creating zip package at: $zipPath"
Write-Host "Note: This may take several minutes depending on disk speed..."

Compress-Archive -Path "$SourceDir\*" -DestinationPath $zipPath -CompressionLevel Optimal -Force

$zipItem = Get-Item $zipPath
$sizeGB = [Math]::Round($zipItem.Length / 1GB, 2)
Write-Host "Packaging complete. Archive size: $sizeGB GB ($($zipItem.Length) bytes)."
