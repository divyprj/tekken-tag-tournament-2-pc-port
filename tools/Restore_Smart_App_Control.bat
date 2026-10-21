@echo off
:: Batch script to restore Windows 11 Smart App Control without reinstalling Windows
echo Requesting administrator privileges...
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Administrator privileges required. Right-click this file and choose "Run as administrator".
    pause
    exit /b
)

echo Restoring Smart App Control to Evaluation Mode (State 2)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" /v VerifiedAndReputablePolicyState /t REG_DWORD /d 2 /f

echo.
echo ==============================================================
echo Smart App Control has been restored in the Windows registry!
echo Please restart your computer for the change to take full effect.
echo ==============================================================
pause
