---
description: Cria ou reformula uma skill/agent definition usando o skill-architect (Opus)
allowed-tools: Read, Glob, Grep, Bash, Task
argument-hint: [nome-da-skill ou caminho relativo]
---

# Estruturar Skill / Agent

Alvo: **$ARGUMENTS**

## Passo 1: Localizar o arquivo alvo

Busque o arquivo da skill/agent informado:
!`find .claude -name "$ARGUMENTS*" -o -name "SKILL.md" -path "*$ARGUMENTS*" 2>/dev/null | head -20`

## Passo 2: Detectar tipo e modo

Com base no resultado da busca:
- **Skill**: arquivo chamado `SKILL.md` dentro de um diretorio com o nome da skill
- **Agent**: arquivo `.md` com frontmatter contendo `name:` (ex: `reviewer.md`)
- **Modo reformular**: arquivo encontrado na busca acima
- **Modo criar do zero**: nenhum arquivo encontrado

## Passo 3: Delegar ao skill-architect via Task tool

Use o **Task tool** para invocar o agente `skill-architect` com o seguinte prompt:

```
Alvo: [nome/caminho encontrado ou "$ARGUMENTS" para criar do zero]
Tipo: [skill / agent definition]
Modo: [reformular / criar do zero]
Contexto: [resultado dos passos acima]

Se arquivo existe, leia-o e reformule para eliminar lacunas.
Se nao existe, crie do zero seguindo os padroes do sistema.

Produza o relatorio de mudancas ao final.
```

## Passo 4: Apresentar resultado

Apos o agente escrever o arquivo, mostre ao usuario:
- O que foi criado/modificado
- As principais mudancas e justificativas
- Sugira rodar `git diff` para revisar antes de commitar
