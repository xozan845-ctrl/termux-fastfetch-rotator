#!/data/data/com.termux/files/usr/bin/bash
# Secuencia usada para grabar assets/demo.gif
# Uso: asciinema rec --headless --window-size 110x30 -c "bash assets/demo.sh" demo.cast

ROTATE="$HOME/.config/fastfetch/rotate.sh"
PROMPT='\033[1;32mtermux\033[0m:\033[1;34m~\033[0m$ '

# Empezar el ciclo desde el primer arte (BlackArch)
rm -f "$HOME/.cache/fastfetch-logo-index"

type_clear() {
    for ((i = 0; i < ${#1}; i++)); do
        printf '%s' "${1:i:1}"
        sleep 0.08
    done
}

step() {
    printf "$PROMPT"
    sleep 0.5
    type_clear "clear"
    sleep 0.8
    command clear
    "$ROTATE"
    sleep 2.2
}

clear
printf '\033[?25l'   # ocultar el cursor en el GIF
"$ROTATE"
sleep 2.5

step
step
step
step
step

printf "$PROMPT"
sleep 1.5
