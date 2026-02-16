---
name: design-system
description: >
  Padroes e processo para criar um design system completo.
  Use quando o usuario pedir para criar design system, documentar tokens de design,
  criar pagina de componentes, definir cores, tipografia, espacamento, sombras,
  border-radius, ou qualquer documentacao visual do projeto.
---

# Design System — Skill de Elaboracao

Esta skill guia a criacao completa de um design system para qualquer projeto. Antes de comecar, leia `agent_docs/design-system.md` para o guia completo de referencia.

## Filosofia

Um design system nao e apenas uma colecao de componentes — e a **fonte unica de verdade** para todas as decisoes visuais do projeto. Ele deve:

1. **Documentar** os tokens existentes (cores, tipografia, spacing, shadows, radius)
2. **Padronizar** o uso de componentes com variantes, tamanhos e estados
3. **Acelerar** o desenvolvimento com referencias visuais claras
4. **Garantir consistencia** entre paginas, features e desenvolvedores

## Processo de Elaboracao

### Fase 1: Auditoria de Tokens

Antes de criar qualquer coisa, audite o que ja existe no projeto:

1. **CSS Variables** — ler `src/index.css` ou equivalente (`:root` vars)
2. **Tailwind Config** — ler `tailwind.config.ts` (cores, fonts, spacing customizados)
3. **Biblioteca de UI** — identificar componentes base (shadcn/ui, Radix, MUI, Chakra, etc.)
4. **Icones** — identificar icon set (Lucide, Heroicons, etc.)
5. **Padroes inline** — buscar valores hardcoded nos componentes (`grep` por hex colors, px values, etc.)

**Output**: lista completa de tokens primitivos encontrados.

### Fase 2: Definicao da Estrutura de Tokens

Organizar os tokens em 3 niveis:

```
Primitivos     →  Valores brutos: blue-500 = #3b82f6
Semanticos     →  Intencao: primary = blue-500, destructive = red-500
De componente  →  Uso especifico: button-bg = primary, card-border = border
```

Criar o arquivo de dados centralizado (ex: `tokens.ts`) com:
- Paletas de cores (primary, secondary, neutral, success, error, warning, info)
- Escala tipografica (display-xl ate caption, com size/weight/line-height)
- Escala de espacamento (baseada em 4px ou 8px)
- Border radius tokens
- Escala de sombras/elevacao

### Fase 3: Componentes Shared

Criar componentes utilitarios para a pagina de documentacao:

| Componente | Proposito |
|-----------|-----------|
| `SectionHeader` | Titulo + descricao de secao reutilizavel |
| `ColorSwatch` | Swatch de cor clicavel (copia hex com feedback) |
| `TokenTable` | Tabela generica para exibir tokens (nome, valor, preview) |
| `CodeBlock` | Exibicao de codigo de uso (opcional) |

### Fase 4: Secoes do Design System

Implementar as secoes na seguinte ordem:

#### Foundations (tokens visuais)
1. **Visao Geral** — stats, estrutura, hierarquia de tokens
2. **Cores** — paletas + semantic tokens + swatches clicaveis
3. **Tipografia** — escala com preview real de cada token
4. **Espacamento** — escala com barras visuais proporcionais
5. **Border Radius** — shapes com radius aplicado
6. **Sombras** — cards com cada shadow aplicada

#### Components (atomicos)
7. **Botoes** — variantes (primary, secondary, ghost, danger), tamanhos (sm, md, lg), estados (default, hover, focus, disabled, loading)
8. **Inputs & Forms** — text, select, textarea, checkbox, radio + estados (default, focus, error, disabled)
9. **Cards** — variantes (default, elevated, highlighted)
10. **Badges & Tags** — variantes de cor e formato

#### Patterns (composicoes)
11. **Navegacao** — header/navbar exemplo
12. **Hero Section** — headline, CTAs, social proof
13. **Pricing Table** — tiers com destaque
14. **Testimonials** — quote cards
15. **Feature Cards** — grid de features
16. **FAQ / Accordion** — perguntas expandiveis
17. **Footer** — multi-colunas

#### Meta
18. **Mapa de Paginas** — paginas do projeto com prioridade
19. **Guidelines** — regras de uso (cores, tipografia, layout, acessibilidade)

### Fase 5: Infraestrutura da Pagina

1. **Roteamento** — rota `/design-system` isolada (sem auth guard)
2. **Layout** — sidebar de navegacao + area de conteudo
3. **Lazy loading** — `React.lazy()` para nao afetar bundle principal
4. **Responsividade** — sidebar colapsa em mobile
5. **Navegacao** — scroll suave ou swap de conteudo entre secoes

## Regras Criticas

- ALWAYS usar os componentes da biblioteca UI do projeto (shadcn, MUI, etc.) — nunca criar equivalentes manuais
- ALWAYS usar Tailwind classes — nunca CSS inline ou styled-components ad-hoc
- ALWAYS centralizar dados de tokens em arquivo dedicado — nunca hardcodar nos componentes das secoes
- ALWAYS fazer lazy loading da pagina de design system — nunca impactar bundle principal
- ALWAYS incluir estados interativos nos componentes (hover, focus, disabled, loading)
- NEVER criar componentes que dupliquem funcionalidade da biblioteca UI existente
- NEVER incluir logica de negocio na pagina de design system — e puramente visual/documental

## Checklist Pre-Entrega

- [ ] Tokens centralizados em arquivo de dados dedicado
- [ ] Todas as secoes renderizam conteudo visual (nao apenas texto)
- [ ] Swatches de cor copiam valor ao clicar com feedback
- [ ] Tipografia mostra preview real (nao apenas numeros)
- [ ] Botoes mostram todos os estados incluindo loading
- [ ] Layout responsivo testado em mobile
- [ ] Rota isolada sem autenticacao
- [ ] Lazy loading configurado
- [ ] Build passa sem erros
- [ ] Acessibilidade basica (contraste AA, navegacao por teclado)

## Fragmentacao em Stories Sugerida

Para projetos usando o pipeline, recomenda-se fragmentar em 4 stories:

| Story | Escopo | Complexidade |
|-------|--------|-------------|
| 001 | Infraestrutura: tokens.ts, shared components, sidebar, pagina, rota, overview | M |
| 002 | Foundations: cores, tipografia, spacing, radius, shadows | M |
| 003 | Components: botoes, inputs, cards, badges | P |
| 004 | Patterns + Guidelines: nav, hero, pricing, testimonials, features, FAQ, footer, paginas, guidelines + responsividade | G |
