---
description: Implementa uma story especifica seguindo o pipeline
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
argument-hint: [numero-da-story ex: 001]
---

# Implementar Story

## Passo 1: Carregar Contexto
Leia os seguintes arquivos:
- `docs/stories/STORY-$ARGUMENTS*.md` (a story a implementar)
- O PRD referenciado na story
- `agent_docs/code-conventions.md`
- Qualquer outro arquivo de `agent_docs/` relevante para a tarefa

## Passo 2: Apresentar Plano
ANTES de escrever qualquer codigo, apresente:
1. Quais arquivos vai criar/modificar
2. A abordagem tecnica
3. Qualquer duvida ou ambiguidade

Espere aprovacao do usuario.

## Passo 3: Implementar
- Siga as convencoes em `agent_docs/code-conventions.md`
- Implemente as tarefas da story uma a uma
- Marque cada tarefa como concluida no arquivo da story
- Escreva testes conforme `agent_docs/testing-guide.md`

## Passo 4: Validar
Apos implementar:
1. Rode os testes: `npm test`
2. Rode o lint: `npm run lint`
3. Verifique cada criterio de aceite da story
4. Atualize o status da story para "Em Review"

## Passo 5: Resumo
Apresente:
- O que foi implementado
- Arquivos criados/modificados
- Testes escritos
- Criterios de aceite verificados
- Qualquer pendencia ou nota
