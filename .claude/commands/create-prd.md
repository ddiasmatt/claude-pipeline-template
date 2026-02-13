---
description: Cria um Product Requirements Document para uma nova feature
allowed-tools: Read, Write, Edit, Glob, Grep
argument-hint: [nome-da-feature]
---

# Criar PRD

Antes de comecar, leia:
- `CLAUDE.md` para contexto do projeto
- `agent_docs/architecture.md` para entender o sistema

Agora crie um PRD para: **$ARGUMENTS**

## Template do PRD

Crie o arquivo `docs/prds/PRD-$ARGUMENTS.md` com esta estrutura:

```
# PRD: [Nome da Feature]

## Status: Rascunho
## Data: [data atual]
## Autor: Claude + [usuario]

## 1. Problema
Qual dor ou necessidade esta feature resolve?

## 2. Contexto
O que ja existe no sistema que se relaciona com esta feature? Quais limitacoes atuais motivam esta mudanca?

## 3. Requisitos Funcionais
- [ ] RF01: [descricao]
- [ ] RF02: [descricao]

## 4. Requisitos Nao-Funcionais
- Performance: [criterios]
- Seguranca: [criterios]
- Compatibilidade: [criterios]

## 5. Escopo (O que NAO e)
- [O que explicitamente nao faz parte desta feature]

## 6. Arquitetura Proposta
- Componentes afetados: [lista]
- Novos componentes: [lista]
- Mudancas no banco: [se aplicavel]
- APIs novas/alteradas: [se aplicavel]

## 7. Criterios de Aceite
1. [Criterio verificavel]
2. [Criterio verificavel]

## 8. Estimativa
- Complexidade: [P / M / G]
- Justificativa: [por que]

## 9. Riscos e Dependencias
- [Risco ou dependencia identificada]

## 10. Metricas de Sucesso
- [Como medir se a feature teve o impacto esperado]
```

Apos criar o PRD, apresente um resumo e pergunte se o usuario quer ajustar algo antes de prosseguir.
