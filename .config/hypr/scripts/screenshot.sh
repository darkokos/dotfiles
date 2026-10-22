menu=$1
[[ -n $menu ]] || { echo "usage: screenshot.sh MENU [DIR]" >&2; exit 1; }
dir=${2:-$HOME/Downloads/Pictures/Screenshots}

COPY="Copy to clipboard"
SAVE="Save to file"

pick() { sh -c "$menu"; }
tilde() { printf '%s' "${1/#$HOME/\~}"; }

geometry=$(slurp) || exit 0

tmp=$(mktemp --suffix=.png -p "${XDG_RUNTIME_DIR:-/tmp}") || exit 1
trap 'rm -f "$tmp"' EXIT
grim -g "$geometry" "$tmp" || exit 1

choice=$(printf '%s\n%s\n' "$COPY" "$SAVE" | pick)

case $choice in
	"$COPY")
		wl-copy --type image/png < "$tmp"
	;;
	"$SAVE")
		name="$(date +%d-%m-%Y_%H-%M-%S)_grimp.png"

		while true; do
			path=$(tilde "$dir/$name" | pick)
			[[ -n $path ]] || exit 0

			path=${path/#\~/$HOME}
			[[ $path == /* ]] || path="$dir/$path"
			if [[ $path == */ || -d $path ]]; then
				path="${path%/}/$name"
			fi
			[[ ${path##*/} == *.* ]] || path+=".png"

			[[ -e $path ]] || break

			OTHER="Choose another path"
			OVERWRITE="Overwrite $(tilde "$path")"
			case $(printf '%s\n%s\n' "$OTHER" "$OVERWRITE" | pick) in
				"$OVERWRITE") 	break;;
				"$OTHER")	continue ;;
				*)		exit 0 ;;
			esac
		done

		mkdir -p "${path%/*}" && mv -f "$tmp" "$path"
	;;
esac
