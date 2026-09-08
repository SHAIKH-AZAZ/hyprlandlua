#!/bin/bash

DwindleIcon=""
ScrollingIcon=""

CurLayout=$(hyprctl getoption general:layout | grep str: | sed -E "s/str: //")

if [[ "$1" = "getlayout" ]]; then

  case "$CurLayout" in
    "scrolling")
      ;;
    "dwindle")
      ;;
    *)
      CurLayout="dwindle";;
  esac

  LayoutIcon="$ScrollingIcon"

  if [[ "$CurLayout" = "dwindle" ]]; then
    LayoutIcon="$DwindleIcon"
  fi

  printf '{"text":"%s","class":"%s","tooltip":"Layout: %s"}' "$LayoutIcon" "$CurLayout" "$CurLayout"
  exit 0
elif [[ $1 ]]; then
  echo "$1 is not a valid command!"
  exit 0
fi

Layout="scrolling"

if [[ "$CurLayout" = "scrolling" ]]; then
  Layout="dwindle"
fi

hyprctl -q keyword general:layout $Layout
pkill -RTMIN+5 waybar
