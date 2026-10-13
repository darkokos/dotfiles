#!/bin/bash

SINK=@DEFAULT_AUDIO_SINK@

usage() {
	echo "usage: volume.sh up STEP | down STEP | mute" >&2
	exit 1
}

case $1 in
	up|down)
		[[ $2 =~ ^[0-9]+$ ]] || usage

		wpctl set-mute "$SINK" 0

		if [[ $1 == up ]]; then
			wpctl set-volume -l 2.0 "$SINK" "$2%+"
		else
			wpctl set-volume "$SINK" "$2%-"
		fi
	;;
	mute)
		wpctl set-mute "$SINK" toggle
	;;
	*)
		usage
	;;
esac

out=$(wpctl get-volume "$SINK")
vol=$(awk '{ printf "%d", $2 * 100 + 0.5 }' <<< "$out")

ICON_MUTED=$'\U000F075F'
ICON_LOW=$'\U000F057F'
ICON_MID=$'\U000F0580'
ICON_HIGH=$'\U000F057E'

if [[ $out == *MUTED* ]]; then
	dunstify -a volume-muted -t 4000 -r 1 "$ICON_MUTED" ""
	exit 0
fi

if (( vol == 0 )); then
	icon=$ICON_LOW
elif (( vol < 50 )); then
	icon=$ICON_MID
else
	icon=$ICON_HIGH
fi

dunstify -a volume -t 4000 -r 1 -h int:value:"$vol" "$icon" "$vol"
