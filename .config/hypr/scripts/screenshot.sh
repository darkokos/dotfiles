dir=${1:-$HOME/Downloads/Pictures/Screenshots}
mkdir -p "$dir" || exit 1

geometry=$(slurp) || exit 0

file="$dir/$(date +%d-%m-%Y_%H-%M-%S)_grim.png"
grim -g "$geometry" "$file"
