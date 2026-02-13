---
description: Cria user stories baseadas em um PRD e plano de implementacao
allowed-tools: Read, Write, Edit, Glob, Grep
argument-hint: [nome-da-feature]
---

# Criar User Stories

Antes de comecar, leia:
- PRD em `docs/prds/PRD-$ARGUMENTS.md`
- Plano em `docs/plans/PLAN-$ARGUMENTS.md` (se existir)
- `agent_docs/architecture.md`

## Instrucoes

Fragmente o PRD em stories pequenas e implementaveis. Cada story deve ser completavel em uma sessao do Claude Code.

Para cada story, crie um arquivo `docs/stories/STORY-[NNN]-[slug].md`:

```
# STORY-[NNN]: [Titulo curto e descritivo]

## Status: Pendente
## Feature: [nome da feature]
## PRD: docs/prds/PRD-[nome].md

## Objetivo
[1-2 frases sobre o que esta story entrega]

## Contexto Tecnico
- Arquivos relacionados: [lista de arquivos existentes relevantes]
- Padroes a seguir: [referencia a agent_docs/ relevante]
- Dependencias: [de outras stories ou libs]

## Tarefas
- [ ] [Tarefa especifica e verificavel]
- [ ] [Tarefa especifica e verificavel]
- [ ] [Escrever testes]

## Criterios de Aceite
1. [Criterio verificavel]
2. [Criterio verificavel]
3. Testes passando

## Notas Tecnicas
[Qualquer detalhe que ajude na implementacao — patterns a usar, gotchas, etc.]
```

Regras:
- Cada story deve ter escopo BEM definido — implementavel em 1 sessao
- Sempre incluir tarefa de testes
- Sempre incluir criterios de aceite verificaveis
- Numerar sequencialmente (STORY-001, STORY-002, etc.)
- Se a feature e grande, crie stories com dependencias claras entre si

Apos criar, liste todas as stories com seus titulos e pergunte se o usuario quer ajustar.
