@echo off
REM 2.11BSD Unix on SIMH PDP-11 Emulator
REM
REM This script:
REM   1. Changes to the directory where this script lives
REM   2. Runs PDP11.exe (SIMH emulator) with boot.ini config
REM   3. boot.ini sets up CPU, attaches 211bsd.dsk, and boots

echo ============================================
echo   2.11BSD Unix on SIMH PDP-11 Emulator
echo ============================================
echo.
echo Boot sequence:
echo   1. At ":" prompt - press ENTER
echo   2. At "#" prompt - press Ctrl+D  
echo   3. At "login:" - type: root
echo.
echo To exit: type "halt" or close window
echo ============================================
echo.

REM Navigate to this script's directory (works regardless of where you run it from)
cd /d "%~dp0"

REM Launch SIMH PDP-11 emulator with our boot config
REM The emulator folder is one level up (..) - find any simh-* folder
set "SIMH_PATH="
for /d %%d in ("..\simh-*") do (
    set "SIMH_PATH=%%d"
    goto :found
)

:found
if "%SIMH_PATH%"=="" (
    echo Error: Could not find SIMH folder (simh-*) one level up from here.
    echo Please extract SIMH next to this folder, or edit this script with the correct path.
    pause
    exit /b 1
)

"%SIMH_PATH%\PDP11.exe" boot.ini
pause
