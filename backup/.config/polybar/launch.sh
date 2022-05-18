#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


#
# Set bar for multiple screens
#

# https://github.com/polybar/polybar/issues/763
# Get all monitor
MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)

# if DOTFiLE_LAPTOP_MODE
top_right_modules="wired-network memory cpu date"
if [ "$DOTFILE_LAPTOP_MODE" = true ]; then
    # ENABLE wifi && battery module
    top_right_modules="wired-network wireless-network battery date"
    dpi=250
fi

if type "xrandr"; then
    for m in $MONITORS; do
        MONITOR=$m \
            TOP_RIGHT_MODULES=$top_right_modules \
            DPI=$dpi \
            polybar --reload top &
    done
else
    polybar --reload top &
fi

echo "Bars launched..."
