#!/usr/bin/env bash
set -euo pipefail

input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // ""' 2>/dev/null || echo "")

# Bloqueia comandos destrutivos
if echo "$cmd" | grep -qE '(rm -rf /|rm -rf \.|sudo rm|chmod 777|git reset --hard|git push.*--force|git push.*-f[^i])'; then
  echo "Comando potencialmente destrutivo bloqueado: $cmd" >&2
  echo "Use alternativas seguras ou peca permissao explicita ao usuario." >&2
  exit 2
fi

exit 0
