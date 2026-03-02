#!/usr/bin/env bash

ICON_DIR="$HOME/.config/scripts/volume"
STEP="10%"
ID_FILE="/tmp/volume_notify_id"

# Read the previous notification ID (0 means "new notification")
read_id() {
    if [[ -f "$ID_FILE" ]]; then
        cat "$ID_FILE"
    else
        echo 0
    fi
}

# Send a notification via D-Bus so that replace-id actually works
notify_volume() {
    local vol muted icon prev_id new_id

    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
    vol=${vol%.*}  # Trim decimal part
    muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "yes" || echo "no")

    if [[ $muted == "yes" ]]; then
        icon="muted.png"
        vol="Muted"
    else
        if   (( vol > 66 )); then icon="full.png"
        elif (( vol > 33 )); then icon="full-1.png"
        else                      icon="full-2.png"
        fi
        vol="${vol}%"
    fi

    prev_id=$(read_id)

    new_id=$(gdbus call --session \
        --dest org.freedesktop.Notifications \
        --object-path /org/freedesktop/Notifications \
        --method org.freedesktop.Notifications.Notify \
        "Volume" \
        "$prev_id" \
        "file://$ICON_DIR/$icon" \
        "$vol" \
        "" \
        "[]" \
        "{'category': <'audio.volume'>}" \
        "int32 1000")

    # gdbus returns "(uint32 <ID>,)" — extract the number
    new_id=$(echo "$new_id" | sed 's/[^0-9]//g')
    echo "$new_id" > "$ID_FILE"
}

if [[ $# -lt 1 ]] || [[ ! $1 =~ ^(inc|dec|toggle)$ ]]; then
    echo "Usage: $0 [inc|dec|toggle]" >&2
    exit 1
fi

ACTION=$1

if ! command -v wpctl &>/dev/null; then
    echo "Error: wpctl not found." >&2
    exit 1
fi

case $ACTION in
    inc) wpctl set-volume -l 2.0 @DEFAULT_AUDIO_SINK@ $STEP+ ;;
    dec) wpctl set-volume -l 2.0 @DEFAULT_AUDIO_SINK@ $STEP- ;;
    toggle) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
esac

notify_volume
