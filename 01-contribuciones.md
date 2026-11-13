# 01 — Contribuciones de IA

Asegura que los agentes de IA no diluyan, ignoren ni rompan el funcionamiento, compatibilidad y directrices del proyecto en entornos Termux / Android.

| ID     | Regla                                                                                                                                                                                                                                                                                          |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| R-IA-1 | **Lectura de contexto obligatoria**: antes de proponer o aplicar cambios, la IA mapea el estado leyendo `README.md`, los scripts principales (`install.sh`, `update.sh`) y la lógica de rotación (`config/rotate.sh`, `config/config.jsonc`). Debe comprender las particularidades de Termux (rutas `/data/data/com.termux/files/...`, almacenamiento Android `/storage/emulated` y permisos). |
| R-IA-2 | **Uso adecuado de herramientas y preservación de formato**: la IA usa herramientas nativas de edición e inspección en lugar de comandos destructivos o reescrituras a ciegas. Debe preservar estrictamente los saltos de línea LF (`eol=lf`) requeridos por los shebangs en Termux y no alterar el espaciado ni las secuencias ANSI de los artes ASCII (`config/logos/*.txt`). Prohibido manipular archivos sin revisar el resultado (`git diff`). |
| R-IA-3 | **Atomicidad y Git estricto**: cada cambio u objetivo es un commit atómico con Conventional Commits citando el área afectada (ej. `docs(ia): adaptar directrices de contribucion de IA`, `feat(logos): anadir arte de distro`, `fix(rotate): corregir rotacion de indice`). Prohibido agrupar tareas dispares en un commit genérico ("arreglos varios"). |
| R-IA-4 | **Sin pases libres (Calidad y Verificación de Shell)**: todo script nuevo o modificado debe mantener directivas estrictas de ejecución (`set -euo pipefail`), verificar su sintaxis (`bash -n`) y garantizar idempotencia (no duplicar entradas en `~/.bashrc` y preservar backups `.bak`). Si añade logos, debe colocarlos en `config/logos/`, registrarlos en el array `NAMES` de `config/rotate.sh`, asignar colores en el `case` y documentar en `README.md`. |
| R-IA-5 | **PRs como entregable final**: la IA no commitea directo a `master`/`main`; su trabajo vive en una rama semántica (ej. `docs/ai-contributions`, `feat/...`, `fix/...`) y se entrega mediante Pull Request con descripción clara del cambio, motivación y evidencias reales de verificación (comandos y resultados). |
| R-IA-6 | **Refactorizaciones consensuadas y no intrusivas**: la IA no introduce refactorizaciones oportunistas o no solicitadas que ensucian el PR. Debe respetar la configuración del usuario y las rutas estándar (`~/.config/fastfetch`, `~/.cache/fastfetch-logo-index`, `~/.bashrc`). |

## Verificación

- El historial de la rama refleja un delta atómico (`git log --oneline`).
- Verificación de sintaxis de scripts Bash modificados (`bash -n install.sh config/rotate.sh update.sh`).
- Validación de consistencia: cada logo registrado en `NAMES` (`rotate.sh`) cuenta con su correspondiente archivo `.txt` en `config/logos/` y mapeo de colores.
- Verificación de terminaciones de línea LF (sin CRLF) en todos los scripts ejecutables.
- En la descripción del PR se detallan las pruebas realizadas y la justificación de los cambios.
