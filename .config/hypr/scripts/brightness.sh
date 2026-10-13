#!/bin/bash

STEP=10

usage() {
	echo "usage: brightness.sh up|down" >&2
	exit 1
}

current() {
	brightnessctl -m | awk -F, '{ sub("%", "", $4); print $4 }'
}

level=$(current)

case $1 in
	up)	target=$(( level / STEP * STEP + STEP )) ;;
	down)	target=$(( (level + STEP - 1) / STEP * STEP - STEP )) ;;
	*)	usage ;;
esac

(( target > 100 ))	&& target=100
(( target < 1 ))	&& target=1

brightnessctl -q set "$target%"
level=$(current)

ICONS=(
	$'\U000F0336'
	$'\U000F1A4E'
	$'\U000F1A4F'
	$'\U000F1A50'
	$'\U000F1A51'
	$'\U000F1A52'
	$'\U000F1A53'
	$'\U000F1A54'
	$'\U000F1A55'
	$'\U000F1A56'
	$'\U000F06E8'
)

i=$(( level / 10 ))
(( i > 10 )) && i=10
icon=${ICONS[i]}

dunstify -a brightness -t 4000 -r 1 -h int:value:"$level" "$icon" "$level%"
