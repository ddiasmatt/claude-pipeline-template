# Claude Code Pipeline Template

Pipeline estruturado de desenvolvimento para projetos assistidos por Claude Code. Inclui commands, hooks de protecao, skills, agents e estrutura de documentacao.

## O que inclui

```
.claude/
  commands/       8 slash commands para o pipeline completo
  hooks/          Firewall de comandos destrutivos + lint/typecheck automatico
  settings.json   Configuracao dos hooks
  skills/         Skills auto-ativantes (testing-patterns)
  agents/         Reviewer e planner especializados
agent_docs/       Templates de documentacao tecnica
docs/             Estrutura para PRDs, planos, stories, decisoes
CLAUDE.md.template  Template de CLAUDE.md com placeholders
```

## Como usar num projeto existente

### Opcao 1: degit (recomendado)

```bash
# Copia o template sem historico git
npx degit ddiasmatt/claude-pipeline-template /tmp/pipeline-tmp

# Copia para seu projeto (sem sobrescrever existentes)
cp -rn /tmp/pipeline-tmp/.claude .claude/
cp -rn /tmp/pipeline-tmp/agent_docs agent_docs/
cp -rn /tmp/pipeline-tmp/docs docs/
cp /tmp/pipeline-tmp/.gitignore .gitignore  # ou merge manual
cp /tmp/pipeline-tmp/CLAUDE.md.template CLAUDE.md.template

# Limpa
rm -rf /tmp/pipeline-tmp
```

### Opcao 2: git merge

```bash
# Adiciona como remote
git remote add pipeline https://github.com/ddiasmatt/claude-pipeline-template.git
git fetch pipeline

# Merge (pode gerar conflitos no .gitignore)
git merge pipeline/main --allow-unrelated-histories --no-commit

# Resolve conflitos se houver, commita
git commit -m "chore: add Claude Code development pipeline"

# Remove remote
git remote remove pipeline
```

## Apos copiar: personalizacao

### 1. Renomear CLAUDE.md.template

```bash
mv CLAUDE.md.template CLAUDE.md
```

Edite e substitua os placeholders `{{...}}` com as informacoes do seu projeto:
- `{{PROJECT_NAME}}` — nome do projeto
- `{{PROJECT_DESCRIPTION}}` — descricao em 1-2 linhas
- `{{STACK_ITEMS}}` — lista de tecnologias
- `{{CMD_DEV}}`, `{{CMD_BUILD}}`, etc. — comandos do projeto
- `{{FOLDER_STRUCTURE}}` — pastas principais do src
- `{{PROJECT_PATTERNS}}` — padroes especificos do projeto
- `{{ADDITIONAL_RULES}}` — regras criticas do projeto

### 2. Preencher agent_docs/

Cada arquivo em `agent_docs/` tem headers com `[TODO: ...]`. Preencha com informacoes reais do seu projeto:

- `architecture.md` — componentes, fluxos, integrações
- `code-conventions.md` — padroes de codigo, naming, git
- `database-schema.md` — tabelas, relacionamentos, migrations
- `testing-guide.md` — framework, mocks, exemplos

### 3. Adicionar skills especificas (opcional)

Crie skills para o framework do seu projeto:

```bash
mkdir -p .claude/skills/react-patterns  # ou vue-patterns, api-patterns, etc.
```

Crie um `SKILL.md` com:
```yaml
---
name: react-patterns
description: >
  Padroes React para este projeto.
  Use quando criar componentes, hooks, ou trabalhar com state management.
---

# Padroes React
[Conteudo especifico do seu projeto]
```

### 4. Atualizar .gitignore

Adicione ao seu `.gitignore` existente:
```
# Claude Code agent memory
.claude/agent-memory/
```

## Comandos disponiveis

Apos configurar, use os seguintes slash commands no Claude Code:

| Comando | O que faz |
|---------|-----------|
| `/project:create-prd [feature]` | Cria PRD em `docs/prds/` |
| `/project:create-plan [feature]` | Cria plano tecnico em `docs/plans/` |
| `/project:create-story [feature]` | Cria stories em `docs/stories/` |
| `/project:implement [numero]` | Implementa uma story |
| `/project:review [numero]` | Review de codigo |
| `/project:commit` | Commit inteligente |
| `/project:catchup` | Retoma contexto apos /clear |
| `/project:status` | Visao geral do pipeline |

## Fluxo de desenvolvimento

```
Nova feature:
  /project:create-prd filtro-mensagens
  → revisar e ajustar PRD
  /project:create-plan filtro-mensagens
  → revisar e aprovar plano
  /project:create-story filtro-mensagens
  → revisar stories
  /project:implement 001
  → Claude implementa com plano + testes
  /project:review 001
  → review contra criterios
  /project:commit
  → commit com verificacoes

Retomar trabalho: /project:catchup
Visao geral:     /project:status
```

## Protecoes automaticas

- **Branch guard**: bloqueia edicoes na main/master
- **Bash firewall**: bloqueia `rm -rf`, `git push --force`, etc.
- **Quality check**: roda lint + typecheck apos cada edicao (detecta stack automaticamente: Node.js, Python, Go, Rust)
