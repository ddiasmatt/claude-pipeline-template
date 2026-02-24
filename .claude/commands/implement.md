---
description: Implementa uma story especifica seguindo o pipeline
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, Task
argument-hint: [numero-da-story ex: 001]
---

# Implementar Story

## Passo 1: Carregar Contexto
Leia os seguintes arquivos:
- `docs/stories/STORY-$ARGUMENTS*.md` (a story a implementar)
- O PRD referenciado na story
- `CLAUDE.md` para estrutura e regras do projeto
- Arquivos mencionados no "Contexto Tecnico" da story

## Passo 2: Determinar Complexidade e Modelo

Extraia a complexidade da story seguindo esta ordem de prioridade:
1. Campo `## Complexidade:` no arquivo da story (ex: `## Complexidade: M`)
2. Campo `## Estimativa` > `Complexidade:` no PRD referenciado
3. Se nao encontrar: use **M** (sonnet) como padrao seguro

Mapeamento de modelo:
| Complexidade | Modelo  | Agent               |
|-------------|---------|---------------------|
| P (Pequena) | haiku   | `implementer-haiku` |
| M (Media)   | sonnet  | `implementer-sonnet`|
| G (Grande)  | opus    | `implementer-opus`  |

Anote internamente: qual complexidade foi detectada, de onde veio, e qual modelo sera usado.

## Passo 3: Apresentar Plano

ANTES de escrever qualquer codigo, apresente:
1. **Modelo selecionado**: ex: "Complexidade M detectada na story → usando Sonnet"
2. Quais arquivos vai criar/modificar
3. A abordagem tecnica
4. Qualquer duvida ou ambiguidade

Espere aprovacao do usuario.

## Passo 4: Delegar Implementacao ao Agent

Apos aprovacao, use o **Task tool** para delegar ao agent correto:
- Complexidade **P** → agent `implementer-haiku` (model: haiku)
- Complexidade **M** → agent `implementer-sonnet` (model: sonnet)
- Complexidade **G** → agent `implementer-opus` (model: opus)

No prompt do Task, inclua:
- Caminho da story: `docs/stories/STORY-$ARGUMENTS*.md`
- Os criterios de aceite da story
- Qualquer contexto tecnico relevante que voce ja leu

## Passo 5: Validar e Escalar se Necessario

### Validacao Apos o Agent Completar
1. Rode os testes do projeto
2. Rode lint/typecheck
3. Verifique os criterios de aceite da story

### Escalada Automatica por Falha de Validacao
Se a validacao falhar E o modelo nao era opus:

```
Sequencia de escalada:
haiku → sonnet → opus
```

1. Informe o usuario: *"Validacao falhou com [modelo]. Escalando para [proximo modelo]..."*
2. Relance o Task com o agent mais capaz
3. No prompt de escalada, inclua:
   - Caminho da story
   - Relatorio completo de erros da validacao
   - O que o agent anterior implementou (resumo do output)
   - Instrucao: "Corrija os erros e complete a implementacao"

Se **opus** tambem falhar: apresente os erros ao usuario, nao escale mais — peca orientacao.

## Passo 6: Atualizar Story e Resumo Final

Apos implementacao bem-sucedida:
1. Atualize o status da story para `## Status: Em Review`
2. Apresente resumo:
   - Modelo(s) usado(s) — ex: "Haiku → escalado para Sonnet"
   - O que foi implementado
   - Arquivos criados/modificados
   - Criterios de aceite verificados
   - Qualquer pendencia
