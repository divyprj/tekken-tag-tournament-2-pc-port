<#
.SYNOPSIS
    Hardened Release Packaging Script for Tekken Tag Tournament 2 PC Port

.DESCRIPTION
    Validates mandatory release assets, converts authoritative Markdown documentation
    to distribution text files, enforces strict file allowlists (preventing inclusion
    of proprietary game assets or unintended binaries), builds the distribution zip archive,
    verifies archive contents, and generates an authoritative SHA-256 CHECKSUMS manifest.

.PARAMETER RootWorkspace
    Path to the TTT2 workspace root containing the release staging directory.

.PARAMETER OutputDir
    Destination path for distributable zip archives and checksum manifests.

.PARAMETER ZipName
    Filename for the output release archive.
#>

[CmdletBinding()]
param(
    [string]$RootWorkspace = "",
    [string]$OutputDir = "",
    [string]$ZipName = "Tekken_Tag_Tournament_2_PC_v0.1.6_GitHub_Release.zip"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Definition }
if (-not $RootWorkspace) {
    $RootWorkspace = Split-Path -Parent (Split-Path -Parent $scriptDir)
}
if (-not $OutputDir) {
    $OutputDir = Join-Path $RootWorkspace "Distributable_Archives"
}

Write-Host "================================================================================"
Write-Host "TEKKEN TAG TOURNAMENT 2 PC PORT: HARDENED RELEASE PACKAGING PIPELINE"
Write-Host "================================================================================"

# 1. Validate Workspace and Paths
if (-not (Test-Path $RootWorkspace)) {
    throw "Fatal: Root workspace directory does not exist: $RootWorkspace"
}

$repoRoot = Split-Path -Parent $scriptDir
$releaseSource = Join-Path $RootWorkspace "Tekken Tag Tournament 2 - PC Release"

if (-not (Test-Path $releaseSource)) {
    throw "Fatal: Release staging source directory not found: $releaseSource"
}

if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

# 2. Validate Mandatory Upstream and Wrapper Binaries
$mandatoryFiles = @{
    "Tekken Tag Tournament 2.exe" = (Join-Path $releaseSource "Tekken Tag Tournament 2.exe");
    "steam_api64.dll"              = (Join-Path $releaseSource "steam_api64.dll");
    "msvcp140.dll"                 = (Join-Path $releaseSource "msvcp140.dll");
    "msvcp140_atomic_wait.dll"     = (Join-Path $releaseSource "msvcp140_atomic_wait.dll");
    "vcruntime140.dll"             = (Join-Path $releaseSource "vcruntime140.dll");
    "vcruntime140_1.dll"           = (Join-Path $releaseSource "vcruntime140_1.dll");
    "icon.ico"                     = (Join-Path $releaseSource "icon.ico");
    "settings.ini"                 = (Join-Path $releaseSource "settings.ini");
    "tools\Reset_Save_Data.bat"    = (Join-Path $repoRoot "tools\Reset_Save_Data.bat")
}

# Locate setup utility
$setupExe = Join-Path $RootWorkspace "ttt2_setup.exe"
if (-not (Test-Path $setupExe)) {
    $setupExe = Join-Path $releaseSource "ttt2_setup.exe"
}
$mandatoryFiles["ttt2_setup.exe"] = $setupExe

# Strict pre-flight check: every mandatory file MUST exist
Write-Host "`n[1/6] Validating mandatory release assets..."
foreach ($key in $mandatoryFiles.Keys) {
    $filePath = $mandatoryFiles[$key]
    if (-not (Test-Path $filePath)) {
        throw "Build Failed: Mandatory release asset missing: '$key' at '$filePath'"
    }
    Write-Host "  [OK] Found $key"
}

# 3. Create Isolated Staging Directory
$stageGuid = [Guid]::NewGuid().ToString("N").Substring(0, 8)
$stageDir = Join-Path $OutputDir "staging_$stageGuid"

if (Test-Path $stageDir) {
    Remove-Item -Recurse -Force $stageDir
}
New-Item -ItemType Directory -Path $stageDir -Force | Out-Null

try {
    Write-Host "`n[2/6] Staging approved binaries and runtime dependencies..."
    
    # Copy root binaries and configs
    Copy-Item $mandatoryFiles["Tekken Tag Tournament 2.exe"] -Destination $stageDir
    Copy-Item $mandatoryFiles["ttt2_setup.exe"] -Destination $stageDir
    Copy-Item $mandatoryFiles["steam_api64.dll"] -Destination $stageDir
    Copy-Item $mandatoryFiles["msvcp140.dll"] -Destination $stageDir
    Copy-Item $mandatoryFiles["msvcp140_atomic_wait.dll"] -Destination $stageDir
    Copy-Item $mandatoryFiles["vcruntime140.dll"] -Destination $stageDir
    Copy-Item $mandatoryFiles["vcruntime140_1.dll"] -Destination $stageDir
    Copy-Item $mandatoryFiles["icon.ico"] -Destination $stageDir
    Copy-Item $mandatoryFiles["settings.ini"] -Destination $stageDir

    # Create tools subfolder
    $stageTools = Join-Path $stageDir "tools"
    New-Item -ItemType Directory -Path $stageTools -Force | Out-Null
    Copy-Item $mandatoryFiles["tools\Reset_Save_Data.bat"] -Destination $stageTools

    # 4. Generate Distribution Text Documentation from Authoritative Markdown
    Write-Host "`n[3/6] Generating distribution documentation from authoritative repository Markdown..."
    
    function Convert-MarkdownToPlainText {
        param (
            [string]$SourceMd,
            [string]$TargetTxt,
            [string]$HeaderTitle
        )
        if (-not (Test-Path $SourceMd)) {
            throw "Documentation error: Source markdown file not found: $SourceMd"
        }
        $raw = Get-Content -Path $SourceMd -Raw -Encoding UTF8
        
        # Clean basic markdown tags for clean plain text rendering in Notepad
        $clean = $raw -replace '<[^>]+>', ''
        $clean = $clean -replace '\[([^\]]+)\]\([^\)]+\)', '$1'
        $clean = $clean -replace '\*\*(.*?)\*\*', '$1'
        $clean = $clean -replace '\*(.*?)\*', '$1'
        $clean = $clean -replace '`([^`]+)`', '$1'
        $clean = $clean -replace '> \[![A-Z]+\]', ''
        $clean = $clean -replace '> ', '  '

        $banner = @"
================================================================================
$HeaderTitle
TEKKEN TAG TOURNAMENT 2 PC PORT (STANDALONE DISTRIBUTION)
================================================================================

"@
        $finalContent = $banner + $clean
        [System.IO.File]::WriteAllText($TargetTxt, $finalContent, [System.Text.Encoding]::UTF8)
        Write-Host "  [OK] Generated $(Split-Path $TargetTxt -Leaf)"
    }

    Convert-MarkdownToPlainText -SourceMd (Join-Path $repoRoot "README.md") `
                                -TargetTxt (Join-Path $stageDir "README.txt") `
                                -HeaderTitle "README AND PROJECT OVERVIEW"

    Convert-MarkdownToPlainText -SourceMd (Join-Path $repoRoot "docs\INSTALL_GUIDE.md") `
                                -TargetTxt (Join-Path $stageDir "INSTALL_GUIDE.txt") `
                                -HeaderTitle "INSTALLATION AND ASSET SETUP GUIDE"

    Convert-MarkdownToPlainText -SourceMd (Join-Path $repoRoot "docs\TROUBLESHOOTING.md") `
                                -TargetTxt (Join-Path $stageDir "TROUBLESHOOTING.txt") `
                                -HeaderTitle "TROUBLESHOOTING AND COMPATIBILITY GUIDE"

    Convert-MarkdownToPlainText -SourceMd (Join-Path $repoRoot "docs\MULTIPLAYER.md") `
                                -TargetTxt (Join-Path $stageDir "MULTIPLAYER.txt") `
                                -HeaderTitle "MULTIPLAYER AND CONTROLLER CONFIGURATION"

    Convert-MarkdownToPlainText -SourceMd (Join-Path $repoRoot "LICENSE") `
                                -TargetTxt (Join-Path $stageDir "LICENSE.txt") `
                                -HeaderTitle "REPOSITORY LICENSING AND LEGAL TERMS"

    Convert-MarkdownToPlainText -SourceMd (Join-Path $repoRoot "THIRD_PARTY_NOTICES.md") `
                                -TargetTxt (Join-Path $stageDir "THIRD_PARTY_NOTICES.txt") `
                                -HeaderTitle "THIRD-PARTY NOTICES AND ATTRIBUTIONS"

    Convert-MarkdownToPlainText -SourceMd (Join-Path $repoRoot "DISCLAIMER.md") `
                                -TargetTxt (Join-Path $stageDir "DISCLAIMER.txt") `
                                -HeaderTitle "INTELLECTUAL PROPERTY AND ANTI-PIRACY DISCLAIMER"

    # Also sync updated README.txt back to releaseSource for local consistency
    Copy-Item (Join-Path $stageDir "README.txt") -Destination (Join-Path $releaseSource "README.txt") -Force

    # 5. Anti-Leak Audit & Prohibited Files Check
    Write-Host "`n[4/6] Executing anti-leak audit on staged files..."
    $stagedItems = Get-ChildItem -Path $stageDir -Recurse -File
    
    $prohibitedPatterns = @(
        "*.xex",
        "*.img",
        "*.iso",
        "data*.bin",
        "*Smart_App_Control*",
        "*.cache",
        "*.pdb",
        "*.log",
        "*.bak"
    )

    foreach ($item in $stagedItems) {
        foreach ($pattern in $prohibitedPatterns) {
            if ($item.Name -like $pattern) {
                throw "CRITICAL SECURITY/COPYRIGHT VIOLATION: Prohibited file staged for release: '$($item.FullName)'"
            }
        }
    }

    # Strict Allowlist Enforcement
    $allowlist = @(
        "Tekken Tag Tournament 2.exe",
        "ttt2_setup.exe",
        "steam_api64.dll",
        "msvcp140.dll",
        "msvcp140_atomic_wait.dll",
        "vcruntime140.dll",
        "vcruntime140_1.dll",
        "icon.ico",
        "settings.ini",
        "README.txt",
        "INSTALL_GUIDE.txt",
        "TROUBLESHOOTING.txt",
        "MULTIPLAYER.txt",
        "LICENSE.txt",
        "THIRD_PARTY_NOTICES.txt",
        "DISCLAIMER.txt",
        "Reset_Save_Data.bat"
    )

    foreach ($item in $stagedItems) {
        if ($allowlist -notcontains $item.Name) {
            throw "Security policy violation: Unapproved file found in staging area: '$($item.Name)'"
        }
    }
    Write-Host "  [OK] Anti-leak check passed. Staged files conform 100% to strict allowlist."

    # 6. Compress Archive
    $zipOutput = Join-Path $OutputDir $ZipName
    if (Test-Path $zipOutput) {
        Remove-Item -Force $zipOutput
    }

    Write-Host "`n[5/6] Creating release archive: $zipOutput..."
    Compress-Archive -Path "$stageDir\*" -DestinationPath $zipOutput -CompressionLevel Optimal

    # 7. Post-Packaging Inspection & Checksum Generation
    Write-Host "`n[6/6] Inspecting generated archive and calculating SHA-256..."
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zipHandle = [System.IO.Compression.ZipFile]::OpenRead($zipOutput)
    $entryCount = $zipHandle.Entries.Count
    Write-Host "  Archive contains $entryCount verified entries:"
    foreach ($entry in $zipHandle.Entries) {
        Write-Host "    - $($entry.FullName) ($($entry.Length) bytes)"
        if ($entry.FullName -like "*Smart_App_Control*" -or $entry.FullName -like "*game/*" -or $entry.FullName -like "*.bin") {
            $zipHandle.Dispose()
            throw "Post-packaging audit failure: Contaminated file in archive: $($entry.FullName)"
        }
    }
    $zipHandle.Dispose()

    $fileHash = Get-FileHash -Path $zipOutput -Algorithm SHA256
    $zipItem = Get-Item $zipOutput
    $sizeMB = [Math]::Round($zipItem.Length / 1MB, 2)

    # Generate CHECKSUMS.txt
    $manifestPath = Join-Path $OutputDir "CHECKSUMS.txt"
    $utcTimestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd HH:mm:ss UTC")
    $manifestContent = @"
# TEKKEN TAG TOURNAMENT 2 PC PORT - RELEASE CHECKSUM MANIFEST
# Generated on: $utcTimestamp
# Package: $ZipName
# Size: $($zipItem.Length) bytes ($sizeMB MB)

SHA-256:
$($fileHash.Hash)  $ZipName
"@
    [System.IO.File]::WriteAllText($manifestPath, $manifestContent, [System.Text.Encoding]::UTF8)

    Write-Host "`n================================================================================"
    Write-Host "PACKAGING AND VERIFICATION SUCCESSFUL"
    Write-Host "Archive:  $ZipName"
    Write-Host "Size:     $sizeMB MB ($($zipItem.Length) bytes)"
    Write-Host "SHA-256:  $($fileHash.Hash)"
    Write-Host "Manifest: $manifestPath"
    Write-Host "================================================================================"

} finally {
    # Safe cleanup of isolated staging directory
    if (Test-Path $stageDir) {
        Remove-Item -Recurse -Force $stageDir -ErrorAction SilentlyContinue
    }
}
