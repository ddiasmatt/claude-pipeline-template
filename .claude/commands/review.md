---
description: Review de codigo contra padroes e criterios de aceite
allowed-tools: Read, Glob, Grep
argument-hint: [numero-da-story ou vazio para review geral]
---

# Code Review

## Se numero de story fornecido:
Leia a story `docs/stories/STORY-$ARGUMENTS*.md` e valide contra criterios.

## Mudancas atuais:
!`git diff --cached --stat 2>/dev/null || git diff --stat`

## Checklist de Review

Analise o codigo alterado verificando:

### 1. Conformidade com Padroes
- Segue convencoes de `agent_docs/code-conventions.md`?
- Naming consistente?
- Estrutura de arquivos correta?

### 2. Qualidade
- Sem codigo duplicado?
- Funcoes com responsabilidade unica?
- Sem TODO/FIXME/HACK temporarios?
- Sem console.log de debug?
- Sem credenciais ou dados sensiveis?

### 3. Testes
- Logica de negocio testada?
- Casos de borda cobertos?
- Testes passando?

### 4. Seguranca
- Inputs validados?
- Sem SQL injection / XSS?
- Dados sensiveis protegidos?
- RLS policies adequadas?

### 5. Performance
- Sem queries N+1?
- Sem loops desnecessarios?
- Sem memory leaks (cleanup de channels/subscriptions)?

### 6. Padroes VukTasks
- Hooks seguem o padrao hook-first?
- Realtime subscriptions tem cleanup?
- Notificacoes nao auto-notificam?
- TickTick sync e best-effort?

## Output
Produza relatorio:
- **Aprovado**: O que esta bom
- **Sugestoes**: Melhorias opcionais
- **Bloqueios**: DEVE ser corrigido antes de merge

Se ha bloqueios, ofereca para corrigi-los.
