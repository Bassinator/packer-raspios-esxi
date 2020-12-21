#!/bin/bash
set -e
set -x

sudo systemctl disable rng-tools
sudo systemctl disable rpi-eeprom-update

