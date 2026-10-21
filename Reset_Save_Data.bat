@echo off
title Reset Tekken Tag Tournament 2 Save Data
echo ================================================================================
echo Tekken Tag Tournament 2: Reset Save Data Utility
echo ================================================================================
echo.
echo This utility clears your local save data and restores the game to a clean slate.
echo.

set "SAVEDIR=%LOCALAPPDATA%\TTT2Recomp\saves"

if exist "%SAVEDIR%" (
    echo Creating backup of current save data...
    if not exist "%LOCALAPPDATA%\TTT2Recomp\saves_backup" mkdir "%LOCALAPPDATA%\TTT2Recomp\saves_backup"
    xcopy /E /I /Y /Q "%SAVEDIR%" "%LOCALAPPDATA%\TTT2Recomp\saves_backup" >nul 2>&1
    
    echo Removing save containers and profile records...
    rd /s /q "%SAVEDIR%"
    mkdir "%SAVEDIR%"
    
    echo.
    echo Save data successfully reset.
    echo The next time you launch the game, it will start completely fresh.
) else (
    echo No active save data found at: %SAVEDIR%
    echo Save folder is already clean.
)

echo.
pause
