#!/usr/bin/env bash
# Arranca music-perception-mcp (stdio MCP server).
#
#   ./start-music-perception-mcp.sh
#
# Habla newline-delimited JSON-RPC 2.0 por stdin/stdout — mismo protocolo
# que logic-pro-mcp en modo --stdio. No necesita un puerto ni un bridge:
# un cliente MCP (Claude Code, etc.) lo lanza como proceso y le habla
# directo por stdin/stdout.
#
# Primera vez: crea el venv e instala dependencias con
#   python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt
#
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_PYTHON="$DIR/.venv/bin/python3"
SERVER="$DIR/server/music_perception_server.py"

if [ ! -x "$VENV_PYTHON" ]; then
  echo "No se encontró el venv en $VENV_PYTHON" >&2
  echo "Créalo con: cd \"$DIR\" && python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt" >&2
  exit 1
fi

if [ ! -f "$SERVER" ]; then
  echo "No se encontró el servidor en $SERVER" >&2
  exit 1
fi

exec "$VENV_PYTHON" "$SERVER" "$@"
