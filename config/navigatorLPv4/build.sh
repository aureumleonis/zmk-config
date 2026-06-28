#!/bin/sh

# 1. Grab the exact subfolder where this script and keymap live
configdir="$(cd "$(dirname "$0")" && pwd)"

# 2. Grab the repo root (two levels up from config/navigatorLPv4)
moduledir="$(cd "$configdir/../.." && pwd)"

side=$1

# Navigate to your local ZMK installation
cd ~/tools/zmk/app/

#logging='-S zmk-usb-logging'
#mouse=-DZMK_EXTRA_MODULES="$HOME/tools/kb_zmk_ps2_mouse_trackpoint_driver_mads/"
logging=''
mouse=''

mouse_module=
#mouse_module="$HOME/tools/kb_zmk_ps2_mouse_trackpoint_driver_mads"
dongle_module="$HOME/tools/zmk-dongle-display-view"
# dongle_module=
all_extra_modules="${moduledir};${dongle_module}"

set -e

# 3. Point -DZMK_CONFIG directly to your subfolder ($configdir)
west build -p -d "$moduledir/build/${side}_v4" \
  -b nice_nano_v2 \
  $logging \
  -- \
  $mouse \
  -DSHIELD="navigatorLPv4_$side nice_view_adapter dongle_display_view_pro_micro" \
  -DZMK_EXTRA_MODULES="$all_extra_modules" \
  -DZMK_CONFIG="$configdir" \
  -DKCONFIG_WARN_AS_ERROR=n

# Copy the fresh firmware to your Windows user directory
cp "$moduledir/build/${side}_v4/zephyr/zmk.uf2" /mnt/c/Users/$USER/Documents/zmk_v4_${side}.uf2