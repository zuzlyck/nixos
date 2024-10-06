#!/usr/bin/env bash
#https://github.com/Frost-Phoenix

if hyprctl getoption decoration:blur:enabled | grep "int: 1" >/dev/null ; then
    hyprctl keyword decoration:blur:enabled false >/dev/null
else
    hyprctl keyword decoration:blur:enabled true >/dev/null
fi
