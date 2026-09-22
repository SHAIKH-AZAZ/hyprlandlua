#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Scripts for refreshing wayle, rofi, wallust

SCRIPTSDIR=$HOME/.config/hypr/scripts
UserScripts=$HOME/.config/hypr/UserScripts

file_exists() { [ -e "$1" ]; }

# Kill already running rofi
if pidof rofi >/dev/null; then
  pkill rofi
fi

# quit ags & relaunch ags
#ags -q && ags &

# quit quickshell & relaunch quickshell — wait for the old instance to actually
# exit first, else the new one can lose the race for qs's IPC socket
pkill qs
tries=40
while pgrep -x qs >/dev/null 2>&1 && (( tries-- > 0 )); do sleep 0.05; done
qs &

# nudge rofi/swaybg to reload their theme
for pid in $(pidof rofi swaybg); do
  kill -SIGUSR1 "$pid"
done

# Restart wayle (bar + notifications + OSD all live in one shell process)
wayle panel restart >/dev/null 2>&1 || true

# Relaunching rainbow borders if the script exists (reads wallust's output file,
# which callers already write before invoking this script)
if file_exists "${UserScripts}/RainbowBorders.sh"; then
  ${UserScripts}/RainbowBorders.sh &
fi

exit 0
