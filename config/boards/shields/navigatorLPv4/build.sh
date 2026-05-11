#!/bin/sh

side=$1
cd ~/tools/zmk/app/
#logging='-S zmk-usb-logging'
#mouse=-DZMK_EXTRA_MODULES="$HOME/tools/kb_zmk_ps2_mouse_trackpoint_driver_mads/"
logging=''
mouse=''

set -e
#west build -p -d build/${side}_v4 -b nice_nano_v2 -- -DSHIELD=settings_reset -DZMK_CONFIG="$HOME/projects/zmk-config/config"
west build -p -d build/${side}_v4 -b nice_nano_v2 $logging -- $mouse -DSHIELD=navigatorLPv4_$side -DZMK_CONFIG="$HOME/projects/zmk-config/config"
cp build/${side}_v4/zephyr/zmk.uf2 /mnt/c/Users/$USER/Documents/zmk_v4_${side}.uf2
