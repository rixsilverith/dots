#!/usr/bin/bash
if [[ "$(pamixer --get-mute &> /dev/null; echo $?)" == '0' ]]; then echo -n " M";
else echo -n " $(pamixer --get-volume)"; fi
