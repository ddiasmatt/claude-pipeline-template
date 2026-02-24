---
description: Review de codigo contra padroes e criterios de aceite (Opus)
allowed-tools: Read, Glob, Grep, Bash, Task
argument-hint: [numero-da-story ou vazio para review geral]
---

# Code Review

## Contexto atual

Numero da story (se fornecido): $ARGUMENTS

Mudancas atuais:
!`git diff --cached --stat 2>/dev/null || git diff --stat`

Diff completo:
!`git diff --cached 2>/dev/null || git diff`

## Instrucoes

Use o **Task tool** para delegar o review ao agente `reviewer` (opus).

No prompt do Task, inclua:
1. O numero da story: `$ARGUMENTS` (se vazio, informar "review geral sem story")
2. O diff completo acima
3. A lista de arquivos alterados
4. Instrucao para carregar a story `docs/stories/STORY-$ARGUMENTS*.md` (se numero fornecido)

Exemplo de prompt para o Task:
```
Faca o review do codigo alterado para a STORY-$ARGUMENTS.

Arquivos alterados: [lista do git diff --stat]

Diff completo:
[conteudo do git diff]

Carregue a story em docs/stories/STORY-$ARGUMENTS*.md para verificar os criterios de aceite.
Siga seu processo completo de review e produza o relatorio com veredicto final.
```

Apos o agente retornar, apresente o relatorio ao usuario.
Se houver bloqueios, pergunte se deve corrigir.
