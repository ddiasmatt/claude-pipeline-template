---
description: Retoma contexto apos /clear ou nova sessao
allowed-tools: Read, Grep, Glob, Bash
---

# Retomar Contexto

## Estado do repositorio
!`git status`
!`git log --oneline -10`
!`git branch -a`
!`git diff --stat HEAD~3 2>/dev/null`

## Documentacao ativa
Leia o CLAUDE.md e verifique:

1. **Stories em andamento:** Procure em `docs/stories/` por stories com status diferente de "Concluida"
2. **PRDs recentes:** Verifique `docs/prds/` por PRDs recentes
3. **Planos ativos:** Verifique `docs/plans/`
4. **Decisoes recentes:** Verifique `docs/decisions/`

## Resumo
Apresente:
- O que esta em andamento (stories/PRDs ativos)
- Ultimas mudancas no codigo (baseado no git log)
- Branch atual e seu estado
- Proximos passos sugeridos

Pergunte como o usuario deseja continuar.
