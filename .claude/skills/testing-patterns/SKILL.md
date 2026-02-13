---
name: testing-patterns
description: >
  Padroes de teste para este projeto.
  Use quando escrever testes, criar mocks, configurar fixtures,
  ou quando o usuario mencionar testes, TDD, cobertura, ou QA.
---

# Padroes de Teste

Antes de escrever qualquer teste, leia `agent_docs/testing-guide.md` para entender o framework, estrutura e convencoes deste projeto.

## Principios
1. Todo teste segue AAA: Arrange -> Act -> Assert
2. Cada teste testa UMA coisa
3. Nomes descritivos: "deve [comportamento] quando [condicao]"
4. Mocks apenas para dependencias externas, nunca para modulos internos
5. Fixtures e factories para dados de teste reutilizaveis

## Checklist Pre-Entrega
- [ ] Testes cobrem happy path
- [ ] Testes cobrem casos de erro
- [ ] Testes cobrem edge cases
- [ ] Nenhum teste depende de estado externo
- [ ] Todos passam isoladamente
