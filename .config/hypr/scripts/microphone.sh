#!/bin/bash

SOURCE=@DEFAULT_AUDIO_SOURCE@

case $1 in
	toggle)
		wpctl set-mute "$SOURCE" toggle
	;;
	*)
		echo "usage: microphone.sh toggle" >&2
		exit 1
	;;
esac

ICON_MIC=$'\U000F036C'
ICON_MIC_MUTED=$'\U000F036D'

if [[ $(wpctl get-volume "$SOURCE") == *MUTED* ]]; then
	icon=$ICON_MIC_MUTED
else
	icon=$ICON_MIC
fi

dunstify -a icon-only -t 4000 -r 1 "$icon" ""
