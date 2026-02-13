#!/usr/bin/env bash
set -euo pipefail

# Detecta stack e roda lint/typecheck automaticamente apos editar arquivos

# Node.js (npm/yarn/pnpm/bun)
if [ -f package.json ]; then
  # Detecta package manager
  if [ -f bun.lockb ]; then
    PM="bun"
  elif [ -f pnpm-lock.yaml ]; then
    PM="pnpm"
  elif [ -f yarn.lock ]; then
    PM="yarn"
  else
    PM="npm"
  fi

  # Lint
  if $PM run lint --silent 2>/dev/null; then
    true
  else
    echo "Lint encontrou problemas. Verifique e corrija."
  fi

  # TypeScript typecheck
  if [ -f tsconfig.json ]; then
    if ! npx tsc --noEmit 2>/dev/null; then
      echo "Erros de tipo encontrados. Verifique e corrija."
    fi
  fi

# Python
elif [ -f pyproject.toml ] || [ -f requirements.txt ]; then
  if command -v ruff &>/dev/null; then
    if ! ruff check . 2>/dev/null; then
      echo "Lint (ruff) encontrou problemas. Verifique e corrija."
    fi
  fi
  if command -v mypy &>/dev/null; then
    if ! mypy . --ignore-missing-imports 2>/dev/null; then
      echo "Erros de tipo (mypy) encontrados. Verifique e corrija."
    fi
  fi

# Go
elif [ -f go.mod ]; then
  if command -v golangci-lint &>/dev/null; then
    if ! golangci-lint run 2>/dev/null; then
      echo "Lint (golangci-lint) encontrou problemas. Verifique e corrija."
    fi
  fi

# Rust
elif [ -f Cargo.toml ]; then
  if ! cargo clippy --quiet 2>/dev/null; then
    echo "Clippy encontrou problemas. Verifique e corrija."
  fi
fi

exit 0
