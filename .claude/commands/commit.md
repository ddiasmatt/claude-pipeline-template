---
description: Commit inteligente com review pre-commit
allowed-tools: Read, Grep, Glob, Bash
---

# Commit Inteligente

## 1. Estado atual
!`git status`
!`git diff --cached --stat`

## 2. Verificacoes pre-commit

Antes de commitar, verifique:
- [ ] Nao ha TODOs temporarios ou codigo comentado
- [ ] Nao ha console.log de debug
- [ ] Nao ha credenciais ou dados sensiveis no diff
- [ ] O commit faz UMA coisa (single responsibility)
- [ ] Testes passam para as mudancas feitas
- [ ] Lint passa sem erros

Se alguma verificacao falhar, corrija primeiro e reporte o que corrigiu.

## 3. Criar commit

Use Conventional Commits:
- `feat:` nova funcionalidade
- `fix:` correcao de bug
- `refactor:` refatoracao sem mudanca de comportamento
- `docs:` apenas documentacao
- `test:` apenas testes
- `chore:` manutencao, deps, config

Formato: `tipo(escopo): descricao curta`

Exemplo: `feat(tasks): add due date filter to kanban board`

Se houver story relacionada, inclua: `feat(tasks): add due date filter [STORY-001]`
