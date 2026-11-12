#!/data/data/com.termux/files/usr/bin/bash
# Rota el arte de fastfetch en cada ejecución:
# al abrir la terminal y en cada `clear` muestra el SIGUIENTE logo
# de la lista y avanza el ciclo.

LOGOS_DIR="$HOME/.config/fastfetch/logos"
STATE="$HOME/.cache/fastfetch-logo-index"

mkdir -p "$(dirname "$STATE")"

# Orden del ciclo (editable)
NAMES=(
    blackarch arch debian ubuntu fedora garuda kali android
    linuxmint opensuse manjaro void gentoo nixos endeavouros
    parrot pop mx zorin
)

LOGOS=()
for n in "${NAMES[@]}"; do
    [ -f "$LOGOS_DIR/$n.txt" ] && LOGOS+=("$LOGOS_DIR/$n.txt")
done
count=${#LOGOS[@]}

if [ "$count" -eq 0 ]; then
    exec fastfetch
fi

idx=0
[ -r "$STATE" ] && idx=$(cat "$STATE" 2>/dev/null)
[[ "$idx" =~ ^[0-9]+$ ]] || idx=0
idx=$(( idx % count ))

logo="${LOGOS[$idx]}"
echo $(( (idx + 1) % count )) > "$STATE"

# Colores de cada distro ($1-$9 de cada arte)
name=$(basename "$logo" .txt)
colors=()
case "$name" in
    blackarch)   colors=(--logo-color-1 white --logo-color-2 white --logo-color-3 white) ;;
    arch)        colors=(--logo-color-1 blue --logo-color-2 cyan) ;;
    debian)      colors=(--logo-color-1 red --logo-color-2 red) ;;
    ubuntu)      colors=(--logo-color-1 red --logo-color-2 yellow) ;;
    fedora)      colors=(--logo-color-1 blue --logo-color-2 white) ;;
    garuda)      colors=(--logo-color-1 magenta --logo-color-2 red --logo-color-3 yellow) ;;
    kali)        colors=(--logo-color-1 blue --logo-color-2 white) ;;
    android)     colors=(--logo-color-1 green --logo-color-2 green) ;;
    linuxmint)   colors=(--logo-color-1 green --logo-color-2 white) ;;
    opensuse)    colors=(--logo-color-1 green --logo-color-2 green) ;;
    manjaro)     colors=(--logo-color-1 green --logo-color-2 green) ;;
    void)        colors=(--logo-color-1 green --logo-color-2 green) ;;
    gentoo)      colors=(--logo-color-1 magenta --logo-color-2 white) ;;
    nixos)       colors=(--logo-color-1 blue --logo-color-2 cyan --logo-color-3 blue --logo-color-4 cyan --logo-color-5 white --logo-color-6 white) ;;
    endeavouros) colors=(--logo-color-1 magenta --logo-color-2 blue --logo-color-3 cyan) ;;
    parrot)      colors=(--logo-color-1 cyan --logo-color-2 white) ;;
    pop)         colors=(--logo-color-1 cyan --logo-color-2 white) ;;
    mx)          colors=(--logo-color-1 blue --logo-color-2 white) ;;
    zorin)       colors=(--logo-color-1 blue --logo-color-2 cyan) ;;
esac

exec fastfetch --logo "$logo" "${colors[@]}"
