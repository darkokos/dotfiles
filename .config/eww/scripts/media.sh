#!/usr/bin/env bash
trap 'kill 0' EXIT

last=""
emit() {
	local col=250 sep=$'\x1f' status title artist length len_s len_text json tl al cover
	IFS="$sep" read -r status title artist length < <(
		playerctl metadata --format \
			"{{status}}${sep}{{title}}${sep}{{artist}}${sep}{{mpris:length}}" 2>/dev/null
	)
	if [[ -z "$status" ]]; then status="Stopped"; title="Nothing playing"; artist=""; fi
	title=$(printf '%s' "$title" | fold -s -w $((col * 10 / 90)))
	artist=$(printf '%s' "$artist" | fold -s -w $((col * 10 / 78)))
	tl=$(printf '%s\n' "$title" | wc -l)
	al=$(printf '%s\n' "$artist" | wc -l)
	cover=$((130 + (tl - 1) * 20 + (al - 1) * 17))
	[[ "$length" =~ ^[0-9]+$ ]] || length=0
	len_s=$((length / 1000000))
	if (( len_s > 0 )); then
		len_text=$(awk -v s="$len_s" 'BEGIN{
			h=int(s/3600); m=int((s%3600)/60); s=s%60;
			if (h>0) printf "%d:%02d:%02d", h, m, s; else printf "%d:%02d", m, s }')
	else
		len_text="--:--"
	fi
	json=$(jq -nc --arg s "$status" --arg t "$title" --arg a "$artist" \
		--arg lt "$len_text" --argjson l "$len_s" --argjson c "$cover" \
		'{status:$s, title:$t, artist:$a, len:$l, len_text:$lt, cover:$c}')
	if [[ "$json" != "$last" ]]; then echo "$json"; last="$json"; fi
}

emit
{
	playerctl --all-players --follow metadata --format '{{playerName}}' &
	playerctl --all-players --follow status &
	while sleep 1; do echo tick; done &
	wait
} 2>/dev/null | while read -r _; do
	emit
done
