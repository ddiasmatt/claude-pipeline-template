#!/usr/bin/env bash
set -euo pipefail

# Bloqueia edicoes diretas na branch main/master.
# Exige que o usuario crie uma branch antes de qualquer modificacao.

CURRENT_BRANCH=$(git -C "$(pwd)" branch --show-current 2>/dev/null || echo "")

if [ "$CURRENT_BRANCH" = "main" ] || [ "$CURRENT_BRANCH" = "master" ]; then
  echo "BLOQUEADO: voce esta na branch '$CURRENT_BRANCH'." >&2
  echo "Crie uma branch antes de editar:" >&2
  echo "  git checkout -b <nome-da-branch>" >&2
  exit 2
fi

exit 0
