# Guia Detalhado de Uso — Claude Code Pipeline

Este guia explica cada componente do pipeline, como funciona, e como tirar o maximo proveito dele no dia a dia.

---

## Indice

1. [Visao geral](#1-visao-geral)
2. [Instalacao](#2-instalacao)
3. [Configuracao inicial](#3-configuracao-inicial)
4. [Fluxo completo de uma feature](#4-fluxo-completo-de-uma-feature)
5. [Comandos em detalhe](#5-comandos-em-detalhe)
6. [Protecoes automaticas (Hooks)](#6-protecoes-automaticas-hooks)
7. [Skills — ativacao automatica](#7-skills--ativacao-automatica)
8. [Agents — especialistas sob demanda](#8-agents--especialistas-sob-demanda)
9. [Documentacao de referencia (agent_docs)](#9-documentacao-de-referencia-agent_docs)
10. [Estrutura de pastas do pipeline (docs)](#10-estrutura-de-pastas-do-pipeline-docs)
11. [Cenarios do dia a dia](#11-cenarios-do-dia-a-dia)
12. [Personalizacao avancada](#12-personalizacao-avancada)
13. [Troubleshooting](#13-troubleshooting)

---

## 1. Visao geral

### Filosofia

O pipeline implementa um principio simples: **nunca codar direto**. Toda mudanca significativa passa por um fluxo que documenta decisoes, fragmenta o trabalho, e valida o resultado.

```
Ideia → PRD → Plano → Stories → Codigo → Review → Commit
```

### Por que isso importa

- **Preserva contexto entre sessoes**: apos um `/clear` ou nova conversa, os documentos criados permanecem. O Claude pode retomar de onde parou lendo os docs
- **Garante qualidade consistente**: hooks automaticos impedem erros comuns (editar na main, comandos destrutivos, codigo sem lint)
- **Fragmenta trabalho complexo**: features grandes sao divididas em stories implementaveis em uma sessao cada
- **Cria historico de decisoes**: PRDs e planos documentam o "porque" das mudancas, nao so o "o que"

---

## 2. Instalacao

### Opcao A: degit (recomendado)

```bash
cd /seu/projeto

# Baixa o template (sem historico git)
npx degit ddiasmatt/claude-pipeline-template /tmp/pipeline-tmp

# Copia para o projeto (sem sobrescrever arquivos existentes)
cp -rn /tmp/pipeline-tmp/.claude .claude/
cp -rn /tmp/pipeline-tmp/agent_docs agent_docs/
cp -rn /tmp/pipeline-tmp/docs docs/
cp /tmp/pipeline-tmp/CLAUDE.md.template ./CLAUDE.md.template

# Limpa
rm -rf /tmp/pipeline-tmp
```

### Opcao B: git merge

```bash
cd /seu/projeto

git remote add pipeline https://github.com/ddiasmatt/claude-pipeline-template.git
git fetch pipeline
git merge pipeline/main --allow-unrelated-histories --no-commit

# Resolva conflitos se houver (ex: .gitignore), depois:
git commit -m "chore: add Claude Code development pipeline"
git remote remove pipeline
```

### Apos instalar

```bash
# Torna os hooks executaveis
chmod +x .claude/hooks/*.sh

# Adiciona ao .gitignore (se nao tiver)
echo -e "\n# Claude Code agent memory\n.claude/agent-memory/" >> .gitignore
```

---

## 3. Configuracao inicial

### 3.1 Criar o CLAUDE.md

O arquivo `CLAUDE.md` e a "constituicao" do projeto para o Claude. Ele le este arquivo em TODA sessao.

```bash
mv CLAUDE.md.template CLAUDE.md
```

Abra o `CLAUDE.md` e substitua cada placeholder:

| Placeholder | O que colocar | Exemplo |
|-------------|---------------|---------|
| `{{PROJECT_NAME}}` | Nome do projeto | `MeuApp` |
| `{{PROJECT_DESCRIPTION}}` | Descricao em 1-2 linhas | `API de gestao de pedidos com dashboard admin` |
| `{{STACK_ITEMS}}` | Lista de tecnologias (um por linha com `-`) | `- Backend: NestJS + TypeScript` |
| `{{CMD_DEV}}` | Comando para dev server | `npm run dev` |
| `{{CMD_BUILD}}` | Comando para build | `npm run build` |
| `{{CMD_LINT}}` | Comando para lint | `npm run lint` |
| `{{CMD_TEST}}` | Comando para testes | `npm test` |
| `{{CMD_TEST_WATCH}}` | Comando para testes em watch | `npm run test:watch` |
| `{{FOLDER_STRUCTURE}}` | Pastas principais do src (um por linha com `-`) | `- src/modules/ — modulos de dominio` |
| `{{PROJECT_PATTERNS}}` | Padroes do projeto (um por linha com `-`) | `- Todo modulo expoe um service + controller` |
| `{{ADDITIONAL_RULES}}` | Regras criticas extras (um por linha com `-`) | `- NEVER altere o schema Prisma sem migration` |

**Dica**: mantenha o CLAUDE.md com menos de 150 linhas. Detalhes vao nos `agent_docs/`.

### 3.2 Preencher os agent_docs/

Cada arquivo em `agent_docs/` tem sections com `[TODO: ...]`. Voce pode:

1. **Preencher manualmente** — abra cada arquivo e substitua os TODOs
2. **Pedir ao Claude** — abra o Claude Code no projeto e diga:
   ```
   Analise o codebase e preencha os agent_docs/ com informacoes reais do projeto
   ```

Os arquivos sao:

| Arquivo | O que documentar |
|---------|------------------|
| `architecture.md` | Componentes, fluxos de dados, integrações, decisoes arquiteturais |
| `code-conventions.md` | Padroes de codigo, naming, estrutura de pastas, convencoes de git |
| `database-schema.md` | Tabelas, relacionamentos, migrations, queries comuns |
| `testing-guide.md` | Framework de testes, como rodar, mocks, exemplos |
| `design-system.md` | Tokens de design, estrutura de componentes, guidelines visuais |

### 3.3 Adicionar skills especificas (opcional)

O template vem com `testing-patterns` e `design-system` (ambas universais). Para adicionar skills do seu stack:

```bash
mkdir -p .claude/skills/react-patterns  # ou vue-patterns, api-patterns, etc.
```

Crie `.claude/skills/react-patterns/SKILL.md`:

```yaml
---
name: react-patterns
description: >
  Padroes React para este projeto.
  Use quando criar componentes, hooks, ou trabalhar com state management.
---

# Padroes React

## Regras
1. Componentes funcionais com TypeScript
2. State management via React Query
3. [suas regras aqui]
```

A `description` deve conter palavras-chave que o usuario mencionaria. O Claude usa matching semantico para decidir quando carregar a skill.

---

## 4. Fluxo completo de uma feature

### Exemplo pratico: adicionar filtro de tasks por data

#### Passo 1 — Criar o PRD

```
/project:create-prd filtro-por-data
```

O Claude vai:
- Ler o `CLAUDE.md` e `agent_docs/architecture.md`
- Criar `docs/prds/PRD-filtro-por-data.md` com problema, requisitos, criterios de aceite
- Apresentar um resumo e perguntar se voce quer ajustar

**Voce revisa**, ajusta se necessario, e confirma.

#### Passo 2 — Criar o plano tecnico

```
/project:create-plan filtro-por-data
```

O Claude vai:
- Ler o PRD criado no passo anterior
- Ler `agent_docs/code-conventions.md`
- Criar `docs/plans/PLAN-filtro-por-data.md` com: arquivos a criar/modificar, ordem de implementacao, riscos, estimativas
- Perguntar se voce aprova

**Voce revisa** e aprova.

#### Passo 3 — Criar as stories

```
/project:create-story filtro-por-data
```

O Claude vai:
- Ler o PRD e o plano
- Fragmentar em stories pequenas (cada uma completavel em ~1 sessao)
- Criar arquivos como `docs/stories/STORY-001-componente-filtro.md`, `STORY-002-hook-filtragem.md`, etc.
- Cada story tem: objetivo, tarefas, criterios de aceite, contexto tecnico

**Voce revisa** as stories e ajusta se necessario.

#### Passo 4 — Implementar story por story

```
/project:implement 001
```

O Claude vai:
- Carregar a story + PRD + convencoes
- Apresentar o que vai fazer ANTES de escrever codigo
- Esperar sua aprovacao
- Implementar tarefa por tarefa, marcando cada uma como concluida
- Escrever testes
- Rodar `npm test` e `npm run lint`
- Atualizar o status da story para "Em Review"

#### Passo 5 — Review

```
/project:review 001
```

O Claude vai revisar o codigo contra:
- Padroes do `agent_docs/code-conventions.md`
- Criterios de aceite da story
- Checklist de qualidade, seguranca, performance

Produz um relatorio com: Aprovado / Sugestoes / Bloqueios.

#### Passo 6 — Commit

```
/project:commit
```

O Claude vai:
- Verificar que nao ha console.log de debug, TODOs, credenciais
- Rodar testes e lint
- Criar commit com Conventional Commits: `feat(tasks): add date range filter [STORY-001]`

#### Repetir passos 4-6 para STORY-002, STORY-003, etc.

---

## 5. Comandos em detalhe

### `/project:create-prd [nome]`

**O que faz**: cria um Product Requirements Document completo.

**Input**: nome da feature (ex: `filtro-por-data`, `sistema-notificacoes`)

**Output**: arquivo `docs/prds/PRD-[nome].md` com 10 sections:
1. Problema
2. Contexto
3. Requisitos funcionais
4. Requisitos nao-funcionais
5. Escopo (o que NAO e)
6. Arquitetura proposta
7. Criterios de aceite
8. Estimativa de complexidade
9. Riscos e dependencias
10. Metricas de sucesso

---

### `/project:create-plan [nome]`

**O que faz**: cria um plano tecnico baseado no PRD.

**Input**: nome da feature (deve existir um PRD correspondente)

**Output**: arquivo `docs/plans/PLAN-[nome].md` com:
- Lista de arquivos a criar/modificar
- Dependencias necessarias
- Ordem de implementacao
- Riscos tecnicos
- Estimativa por etapa

---

### `/project:create-story [nome]`

**O que faz**: fragmenta o PRD em stories implementaveis.

**Input**: nome da feature

**Output**: multiplos arquivos `docs/stories/STORY-NNN-[slug].md`, cada um com:
- Status (Pendente / Em Progresso / Em Review / Concluida)
- Objetivo
- Contexto tecnico (arquivos relacionados, padroes a seguir)
- Tarefas (checklist)
- Criterios de aceite
- Notas tecnicas

**Regra**: cada story deve ser completavel em 1 sessao do Claude Code.

---

### `/project:implement [numero]`

**O que faz**: implementa uma story especifica.

**Input**: numero da story (ex: `001`)

**Processo**:
1. Carrega story + PRD + convencoes
2. Apresenta plano e espera aprovacao
3. Implementa tarefa por tarefa
4. Escreve testes
5. Roda testes e lint
6. Atualiza status da story

---

### `/project:review [numero]`

**O que faz**: review de codigo contra padroes e criterios.

**Input**: numero da story (opcional — sem argumento faz review geral do diff)

**Checklist**:
- Conformidade com convencoes
- Qualidade (sem duplicacao, sem debug logs)
- Testes (cobertura, edge cases)
- Seguranca (inputs validados, sem dados sensiveis)
- Performance (sem N+1, sem memory leaks)

**Output**: relatorio com Aprovado / Sugestoes / Bloqueios.

---

### `/project:commit`

**O que faz**: commit inteligente com verificacoes.

**Verificacoes pre-commit**:
- Sem TODOs temporarios
- Sem console.log de debug
- Sem credenciais no diff
- Single responsibility (commit faz UMA coisa)
- Testes passam
- Lint passa

**Formato**: Conventional Commits — `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`

---

### `/project:catchup`

**O que faz**: retoma contexto apos `/clear` ou nova sessao.

**Le automaticamente**:
- `git status`, `git log`, `git branch`
- Stories em andamento em `docs/stories/`
- PRDs recentes em `docs/prds/`
- Planos ativos em `docs/plans/`

**Output**: resumo do que esta em andamento + proximos passos sugeridos.

---

### `/project:status`

**O que faz**: visao geral do pipeline.

**Mostra**:
- Todos os PRDs com status
- Stories agrupadas por status (Pendente / Em Progresso / Em Review / Concluida)
- Planos ativos
- Decisoes recentes
- Ultimos commits

---

## 6. Protecoes automaticas (Hooks)

Os hooks executam SEMPRE — nao sao sugestoes que o Claude pode ignorar. Sao garantias.

### Branch Guard

**Quando**: antes de qualquer `Edit` ou `Write`

**O que faz**: impede edicao de arquivos na branch `main` ou `master`. Forca criar feature branch.

**Mensagem de erro**: `"Nao edite na branch main/master. Crie uma feature branch: git checkout -b feat/nome"`

### Bash Firewall

**Quando**: antes de qualquer comando `Bash`

**O que faz**: bloqueia comandos destrutivos:
- `rm -rf /` ou `rm -rf .`
- `sudo rm`
- `chmod 777`
- `git reset --hard`
- `git push --force` ou `git push -f`

**Mensagem de erro**: `"Comando potencialmente destrutivo bloqueado: [comando]"`

### Quality Check

**Quando**: apos qualquer `Edit` ou `Write`

**O que faz**: detecta o stack e roda automaticamente:

| Stack | Lint | Typecheck |
|-------|------|-----------|
| Node.js (npm) | `npm run lint` | `npx tsc --noEmit` |
| Node.js (yarn) | `yarn run lint` | `npx tsc --noEmit` |
| Node.js (pnpm) | `pnpm run lint` | `npx tsc --noEmit` |
| Node.js (bun) | `bun run lint` | `npx tsc --noEmit` |
| Python | `ruff check .` | `mypy .` |
| Go | `golangci-lint run` | (built-in) |
| Rust | `cargo clippy` | (built-in) |

**Nao-bloqueante**: reporta erros mas nao impede a edicao. O Claude recebe o feedback e pode corrigir.

---

## 7. Skills — ativacao automatica

Skills sao "cartoes de referencia" que o Claude carrega automaticamente quando o contexto e relevante.

### Como funciona

O campo `description` da skill contem palavras-chave. Quando voce menciona essas palavras, o Claude carrega a skill automaticamente. Voce nao precisa fazer nada.

### Skill incluida: testing-patterns

**Ativa quando voce menciona**: testes, TDD, cobertura, QA, mocks, fixtures

**Conteudo**: principios de teste (AAA, um teste por coisa, naming), checklist pre-entrega

### Skill incluida: design-system

**Ativa quando voce menciona**: design system, tokens de design, cores, tipografia, espacamento, sombras, border-radius, componentes visuais, documentacao visual

**Conteudo**: processo completo de elaboracao de design system em 5 fases:
1. Auditoria de tokens existentes (CSS vars, Tailwind config, UI library)
2. Definicao da estrutura (primitivos, semanticos, de componente)
3. Componentes shared (SectionHeader, ColorSwatch, TokenTable)
4. 19 secoes organizadas em Foundations, Components, Patterns e Meta
5. Infraestrutura da pagina (rota isolada, lazy loading, responsividade)

Inclui checklist pre-entrega, regras criticas e sugestao de fragmentacao em 4 stories.

Referencia detalhada em `agent_docs/design-system.md`.

### Adicionando suas skills

Crie um diretorio em `.claude/skills/[nome]/` com um `SKILL.md`. O campo `description` e crucial — use palavras que o usuario diria naturalmente:

```yaml
---
name: api-patterns
description: >
  Padroes de API REST para este projeto.
  Use quando criar endpoints, rotas, controllers, middleware,
  validacao, autenticacao, ou respostas da API.
---
```

---

## 8. Agents — especialistas sob demanda

Agents sao "sub-IAs" com papel definido. Podem ser invocados pelo pipeline ou diretamente.

### Reviewer

**Papel**: code reviewer senior. Analisa sem modificar.

**Invocado por**: `/project:review`

**Verifica**: qualidade, padroes, seguranca, testes, performance.

**Output**: relatorio com veredicto (APROVADO / APROVADO COM SUGESTOES / BLOQUEADO)

### Planner

**Papel**: arquiteto de software. Analisa requisitos e cria planos.

**Invocado por**: `/project:create-plan`

**Produz**: lista de arquivos, ordem de implementacao, riscos, sugestao de fragmentacao em stories.

---

## 9. Documentacao de referencia (agent_docs)

Os `agent_docs/` sao a "memoria de longo prazo" do projeto. O Claude consulta sob demanda (progressive disclosure — nao carrega tudo em toda sessao).

| Arquivo | Quando e consultado |
|---------|---------------------|
| `architecture.md` | Ao criar PRDs, planos, ou entender impacto de mudancas |
| `code-conventions.md` | Ao implementar codigo, fazer review |
| `database-schema.md` | Ao criar migrations, queries, ou entender modelo de dados |
| `testing-guide.md` | Ao escrever testes |
| `design-system.md` | Ao criar design system, documentar tokens, definir padroes visuais |

**Dica**: quanto mais detalhados e precisos os agent_docs, melhor o Claude implementa. Vale investir tempo preenchendo-os bem.

---

## 10. Estrutura de pastas do pipeline (docs)

```
docs/
  prds/           PRDs de features (um por feature)
  plans/          Planos tecnicos de implementacao
  stories/        User stories (fragmentos implementaveis)
  architecture/   ADRs (Architecture Decision Records)
  decisions/      Log de decisoes tecnicas
```

Esses documentos **persistem entre sessoes**. Apos um `/clear`, o Claude pode retomar o contexto lendo-os com `/project:catchup`.

---

## 11. Cenarios do dia a dia

### "Quero adicionar uma feature nova"

```
/project:create-prd nome-da-feature
→ revisa PRD
/project:create-plan nome-da-feature
→ revisa plano
/project:create-story nome-da-feature
→ revisa stories
/project:implement 001
→ implementa cada story
```

### "Preciso retomar o trabalho de ontem"

```
/project:catchup
```

O Claude le git log, stories ativas, PRDs, e resume onde voce parou.

### "Quero ver o que esta em andamento"

```
/project:status
```

Lista PRDs, stories por status, planos, ultimos commits.

### "Implementei algo e quero fazer review"

```
/project:review
```

Sem argumento, faz review do diff atual. Com numero de story, valida contra criterios de aceite.

### "Quero commitar as mudancas"

```
/project:commit
```

Verifica qualidade, cria commit com Conventional Commits.

### "Preciso corrigir um bug simples"

Para bugs triviais (1-2 arquivos), voce pode pular o pipeline completo. Apenas:
1. Crie uma feature branch
2. Corrija o bug
3. `/project:review` para validar
4. `/project:commit` para commitar

### "A feature e muito pequena para PRD"

Se a mudanca e pequena (< 3 arquivos, < 1 hora), pode comecar direto do plano:

```
/project:create-plan minha-mudanca-pequena
→ preenche um plano simplificado
/project:implement 001
```

---

## 12. Personalizacao avancada

### Adicionar novo command

Crie um arquivo `.claude/commands/meu-comando.md`:

```yaml
---
description: Descricao curta do que faz
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
argument-hint: [argumento esperado]
---

# Titulo

Instrucoes para o Claude...
```

Disponivel como `/project:meu-comando [argumento]`.

### Adicionar novo agent

Crie um arquivo `.claude/agents/meu-agente.md`:

```yaml
---
name: meu-agente
description: O que este agente faz
tools: Read, Glob, Grep
model: sonnet
---

Instrucoes para o agente...
```

### Modificar hooks

Edite `.claude/settings.json` para adicionar/remover hooks. Edite os scripts em `.claude/hooks/` para alterar comportamento.

### Adicionar agent_docs extras

Crie novos arquivos em `agent_docs/` e referencie-os no `CLAUDE.md`:

```markdown
## Referencias (ler sob demanda)

- Meu novo doc — `agent_docs/meu-novo-doc.md`
```

---

## 13. Troubleshooting

### "O hook de branch guard esta bloqueando e eu preciso editar na main"

Isso e intencional. Crie uma feature branch:

```bash
git checkout -b feat/minha-mudanca
```

### "O quality check esta reportando erros mas o codigo esta correto"

O hook roda `lint` e `typecheck` do projeto. Se reporta erros falsos:
- Verifique se o comando de lint esta correto no `package.json`
- Ajuste o script `.claude/hooks/post-edit-quality.sh`

### "O Claude nao esta carregando as skills"

Verifique:
1. O arquivo esta em `.claude/skills/[nome]/SKILL.md` (com SKILL.md em maiusculas)
2. O campo `description` contem palavras-chave relevantes
3. Reinicie a sessao do Claude Code

### "O `/project:catchup` nao encontra stories"

Verifique se os arquivos estao em `docs/stories/` e seguem o formato `STORY-NNN-*.md`.

### "Quero desabilitar um hook"

Remova a entrada correspondente do `.claude/settings.json`. Por exemplo, para desabilitar o quality check, remova o bloco `PostToolUse`.
