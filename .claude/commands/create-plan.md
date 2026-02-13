---
description: Cria um plano tecnico de implementacao baseado em um PRD
allowed-tools: Read, Write, Edit, Glob, Grep
argument-hint: [nome-do-prd]
---

# Criar Plano de Implementacao

Antes de comecar, leia:
- O PRD em `docs/prds/PRD-$ARGUMENTS.md`
- `agent_docs/architecture.md`
- `agent_docs/code-conventions.md`

## Instrucoes

Crie o arquivo `docs/plans/PLAN-$ARGUMENTS.md` com:

```
# Plano de Implementacao: [Nome]

## PRD Referencia: docs/prds/PRD-[nome].md

## Arquivos a Criar
| Arquivo | Proposito |
|---------|-----------|
| [caminho] | [o que faz] |

## Arquivos a Modificar
| Arquivo | Mudanca |
|---------|---------|
| [caminho] | [o que muda] |

## Dependencias Necessarias
- [pacote/lib se precisar instalar algo]

## Ordem de Implementacao
1. [Primeiro passo — o que tem menos dependencias]
2. [Segundo passo]
3. [...]

## Riscos Tecnicos
- [Risco identificado + mitigacao]

## Estimativa por Etapa
| Etapa | Complexidade |
|-------|-------------|
| [etapa] | [P/M/G] |
```

Apos criar o plano, apresente um resumo e pergunte se o usuario aprova antes de prosseguir para a criacao de stories.
