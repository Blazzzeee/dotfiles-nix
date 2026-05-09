#!/usr/bin/env sh
set -eu

if ! command -v dunstctl >/dev/null 2>&1; then
  printf '{"text":"","class":"unavailable","tooltip":"dunstctl not found"}\n'
  exit 0
fi

paused="$(dunstctl is-paused 2>/dev/null || echo false)"
waiting="$(dunstctl count waiting 2>/dev/null || echo 0)"

if [ "$paused" = "true" ]; then
  printf '{"text":"","class":"paused","tooltip":"Notifications paused"}\n'
  exit 0
fi

if [ "$waiting" -gt 0 ] 2>/dev/null; then
  printf '{"text":" <span foreground=\"#f38ba8\"><sup></sup></span>","class":"waiting","tooltip":"%s notification(s) waiting"}\n' "$waiting"
  exit 0
fi

printf '{"text":"","class":"none","tooltip":"No notifications"}\n'
