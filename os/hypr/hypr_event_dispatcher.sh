#!/bin/bash

source "hypr_event_handlers.sh"

function event() {
  local -r event_name="$2"
  [[ "${1:0:${#event_name}}" == $event_name ]]
}

function event_dispatcher() {
  local -r e="$1"
  event $e "monitoradded" && event::monitoradded $e
  event $e "monitorremoved" && event::monitorremoved $e
}

[[ -z $(pgrep -f hypr_event_dispatcher) ]] && \
socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do event_dispatcher $line; done
