<#
.SYNOPSIS
    [DEPRECATED & DISABLED] Legacy Release Packaging Entrypoint

.DESCRIPTION
    This script previously performed unconstrained workspace packaging, which risked
    accidentally archiving proprietary, copyrighted Xbox 360 game containers
    (Default.xex, tekken.img, data*.bin) or local configuration caches.

    In accordance with the repository security and copyright compliance audit (AUDIT_REPORT.md),
    this entrypoint has been permanently disabled.

    To generate an official, sanitized distribution package containing ONLY approved
    redistributable wrapper files, configuration templates, and documentation, use:

        powershell -ExecutionPolicy Bypass -File .\scripts\build_github_release_zip.ps1

.NOTES
    Compliance Status: Deprecated / Safety Disabled
#>

[CmdletBinding()]
param()

Write-Error @"
================================================================================
CRITICAL SAFETY NOTICE: SCRIPT PERMANENTLY DISABLED
================================================================================
'scripts/package_release.ps1' is deprecated and intentionally disabled.

REASON:
Legacy recursive directory packaging can accidentally bundle proprietary,
copyrighted game assets (such as Default.xex, tekken.img, and data*.bin)
into public distribution archives, violating Bandai Namco intellectual property
and project distribution rules.

APPROVED PACKAGING SCRIPT:
Please use the hardened release packaging script instead:
    .\scripts\build_github_release_zip.ps1

The approved script enforces an explicit allowlist, validates required binaries,
strictly forbids proprietary game data, and generates verified SHA-256 checksums.
================================================================================
"@

exit 1
