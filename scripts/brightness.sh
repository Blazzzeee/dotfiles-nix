#!/usr/bin/env bash

ICON_DIR="$HOME/.config/scripts/brightness"
ID_FILE="/tmp/brightness_notify_id"

# Read the previous notification ID (0 means "new notification")
read_id() {
    if [[ -f "$ID_FILE" ]]; then
        cat "$ID_FILE"
    else
        echo 0
    fi
}

# Send a notification via D-Bus so that replace-id actually works
notify_brightness() {
    local max cur pct icon prev_id new_id

    max=$(brightnessctl max)
    cur=$(brightnessctl get)
    pct=$(( cur * 100 / max ))

    if   (( pct == 100 )); then icon="full.png"
    elif (( pct >  66  )); then icon="full-1.png"
    elif (( pct >  33  )); then icon="full-2.png"
    else                        icon="empty.png"
    fi

    prev_id=$(read_id)

    new_id=$(gdbus call --session \
        --dest org.freedesktop.Notifications \
        --object-path /org/freedesktop/Notifications \
        --method org.freedesktop.Notifications.Notify \
        "Brightness" \
        "$prev_id" \
        "file://$ICON_DIR/$icon" \
        "${pct}%" \
        "" \
        "[]" \
        "{'category': <'brightness'>}" \
        "int32 1000")

    # gdbus returns "(uint32 <ID>,)" — extract the number
    new_id=$(echo "$new_id" | sed 's/[^0-9]//g')
    echo "$new_id" > "$ID_FILE"
}

if [[ $# -lt 1 ]] || [[ ! $1 =~ ^(inc|dec)$ ]]; then
    echo "Usage: $0 [inc|dec] [step]" >&2
    exit 1
fi

ACTION=$1
STEP=${2:-10%}

if ! command -v brightnessctl &>/dev/null; then
    echo "Error: brightnessctl not found." >&2
    exit 1
fi

if [[ $ACTION == inc ]]; then
    brightnessctl set +$STEP &>/dev/null
else
    brightnessctl set $STEP- &>/dev/null
fi

notify_brightness
