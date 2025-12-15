#!/bin/bash
# 2.11BSD Unix on SIMH PDP-11 Emulator
#
# This script:
#   1. Changes to the directory where this script lives
#   2. Runs PDP11.exe (SIMH emulator) with boot.ini config
#   3. boot.ini sets up CPU, attaches 211bsd.dsk, and boots

echo "============================================"
echo "  2.11BSD Unix on SIMH PDP-11 Emulator"
echo "============================================"
echo ""
echo "Boot sequence:"
echo "  1. At ':' prompt - press ENTER"
echo "  2. At '#' prompt - press Ctrl+D"
echo "  3. At 'login:' - type: root"
echo ""
echo "To exit: type 'halt' or close window"
echo "============================================"
echo ""

# Navigate to script's directory (works regardless of where you run it from)
cd "$(dirname "$0")"

# Launch SIMH PDP-11 emulator with our boot config
# The emulator folder is one level up (..)
../simh-2024-07-05_06-07-03-Windows-Win32-4.0-Current-670a3728/PDP11.exe boot.ini
