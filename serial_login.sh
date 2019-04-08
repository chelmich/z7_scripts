#!/usr/bin/env bash

# Connect to ZYBO Z7 SoC via serial with picocom
# Note: You may have to download picocom from your distribution's repository.

baud=115200
port="/dev/ttyUSB1"

picocom -b $baud --quiet -t $'\n' $port
