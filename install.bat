@echo off
setlocal enabledelayedexpansion

REM === Get directory of this script ===
set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM === Config ===
set "SRC_FILE=%SCRIPT_DIR%\.gitconfig"
set "DEST_FILE=%USERPROFILE%\.gitconfig"

REM === Check source exists ===
if not exist "%SRC_FILE%" (
    echo ERROR: %SRC_FILE% not found in current directory.
    exit /b 1
)

REM === If destination exists, back it up ===
if exist "%DEST_FILE%" (
    REM Get timestamp (YYYYMMDD_HHMMSS)
    for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set "TS=%%i"

    set "BACKUP_FILE=%DEST_FILE%.backup.!TS!"

    echo Backing up existing file to:
    echo %BACKUP_FILE%

    copy "%DEST_FILE%" "%BACKUP_FILE%" >nul
)

REM === Copy new file ===
echo Installing new config to:
echo %DEST_FILE%

copy "%SRC_FILE%" "%DEST_FILE%" >nul

echo Done.
endlocal
