#!/bin/sh

side=$1
cd ~/tools/zmk/app/

set -e
west build -p -d build/${side}_lp -b nice_nano_v2 -- -DSHIELD=navigatorLP_$side -DZMK_CONFIG="$HOME/projects/zmk-config/config"
west cp build/${side}_lp/zephyr/zmk.uf2 /mnt/c/Users/$USER/Documents/zmk_lp_${side}.uf2

