#!/usr/bin/env bash
trap 'kill 0' EXIT
cache="${XDG_CACHE_HOME:-$HOME/.cache}/eww-media"
mkdir -p "$cache"
find "$cache" -type f -mtime +7 -delete 2>/dev/null
rm -f "$cache"/*.tmp 2>/dev/null

cur_url() { playerctl metadata --format '{{mpris:artUrl}}' 2>/dev/null; }

download() {
	local url="$1" f="$2"
	if curl -fsSL --max-time 10 -o "$f.tmp.$$" "$url" && [[ -s "$f.tmp.$$" ]]; then
		mv "$f.tmp.$$" "$f"
		[[ "$(cur_url)" == "$url" ]] && echo "$f"
	else
		rm -f "$f.tmp.$$"
	fi
	return 0
}

seen="__init__"
emit() {
	local url f path
	url=$(cur_url)
	[[ "$url" == "$seen" ]] && return 0
	seen="$url"
	case "$url" in
		file://*)
			path="${url#file://}"
			path=$(printf '%b' "${path//%/\\x}")
			if [[ -f "$path" ]]; then echo "$path"; else echo none; fi
			;;
		http://*|https://*)
			f="$cache/$(printf '%s' "$url" | md5sum | cut -d' ' -f1)"
			if [[ -s "$f" ]]; then
				echo "$f"
			else
				echo none
				download "$url" "$f" &
			fi
			;;
		*) echo none ;;
	esac
	return 0
}

emit
{
	playerctl --all-players --follow metadata --format '{{playerName}}' &
	playerctl --all-players --follow status &
	while sleep 2; do echo tick; done &
	wait
} 2>/dev/null | while read -r _; do emit; done
