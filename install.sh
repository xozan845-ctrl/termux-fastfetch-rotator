#!/data/data/com.termux/files/usr/bin/bash
# Instalador de termux-fastfetch-rotator
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.config/fastfetch"
BASHRC="$HOME/.bashrc"
MARK_BEGIN="# >>> termux-fastfetch-rotator >>>"
MARK_END="# <<< termux-fastfetch-rotator <<<"

info()  { printf '\033[1;32m==>\033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33m[!]\033[0m %s\n' "$*"; }

# 1. fastfetch
if ! command -v fastfetch >/dev/null 2>&1; then
    info "Instalando fastfetch..."
    pkg install -y fastfetch
else
    info "fastfetch ya está instalado ($(fastfetch --version | head -1))"
fi

# 2. Copiar configuración (con backup si ya existe)
if [ -d "$DEST" ]; then
    BACKUP="$DEST.bak.$(date +%Y%m%d-%H%M%S)"
    warn "Ya existe $DEST — copia de seguridad en $BACKUP"
    cp -a "$DEST" "$BACKUP"
fi

info "Copiando configuración a $DEST"
mkdir -p "$DEST/logos"
cp "$REPO_DIR/config/config.jsonc" "$DEST/config.jsonc"
cp "$REPO_DIR/config/rotate.sh"    "$DEST/rotate.sh"
cp "$REPO_DIR"/config/logos/*.txt  "$DEST/logos/"
chmod +x "$DEST/rotate.sh"

# 3. Activar en .bashrc (idempotente)
info "Configurando $BASHRC"
touch "$BASHRC"
if grep -qF "$MARK_BEGIN" "$BASHRC"; then
    # Elimina el bloque anterior para reemplazarlo
    sed -i "/${MARK_BEGIN//\//\\/}/,/${MARK_END//\//\\/}/d" "$BASHRC"
fi

cat >> "$BASHRC" <<'EOF'
# >>> termux-fastfetch-rotator >>>
# Rota el arte al abrir la terminal
if [[ $- == *i* ]]; then
    ~/.config/fastfetch/rotate.sh
fi

# `clear` limpia la pantalla y muestra el SIGUIENTE arte del ciclo
alias clear='command clear && ~/.config/fastfetch/rotate.sh'
# <<< termux-fastfetch-rotator <<<
EOF

info "¡Listo!"
echo
echo "  Abre una terminal nueva o ejecuta:  source ~/.bashrc"
echo "  Luego prueba:                       clear"
echo
echo "  Logos incluidos: $(ls -1 "$DEST/logos" | wc -l)"
