#!/usr/bin/bash
vpn_connected=$(pgrep -x vpnc &> /dev/null; echo "$?")

if [[ "$vpn_connected" == '0' ]]; then
  vpn_name=$(ps aux | grep "vpnc" | grep -v "grep" | head -n1 | awk '{print $12}')
  [[ "$vpn_name" == "vpnc" ]] && vpn_name="Connecting to VPN"
  [[ -n "$vpn_name" ]] && echo "歷  $vpn_name "
else echo ""; fi
