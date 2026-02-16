# Design System — Guia de Referencia

Este documento serve como referencia completa para criar e manter um design system no projeto. Consulte-o ao criar paginas de documentacao visual, definir tokens, ou estabelecer padroes de componentes.

## 1. O que e um Design System

Um design system e o conjunto de:
- **Design Tokens**: valores primitivos (cores, fontes, espacamentos, sombras, radius)
- **Componentes**: elementos de UI reutilizaveis com variantes e estados documentados
- **Patterns**: composicoes de componentes para contextos especificos (hero, pricing, footer)
- **Guidelines**: regras de uso, acessibilidade, responsividade e boas praticas

## 2. Estrutura de Arquivos Recomendada

```
src/
  pages/
    DesignSystem.tsx                    # Pagina principal (layout sidebar + conteudo)
  components/
    design-system/
      DSNav.tsx                         # Sidebar de navegacao
      data/
        tokens.ts                       # Dados centralizados de todos os tokens
      shared/
        SectionHeader.tsx               # Titulo + descricao reutilizavel
        ColorSwatch.tsx                 # Swatch clicavel (copia hex)
        TokenTable.tsx                  # Tabela generica de tokens
      sections/
        OverviewSection.tsx             # Visao geral do design system
        ColorsSection.tsx               # Paletas e semantic tokens
        TypographySection.tsx           # Escala tipografica
        SpacingSection.tsx              # Escala de espacamento
        RadiusSection.tsx               # Border radius
        ShadowsSection.tsx              # Elevacao/sombras
        ButtonsSection.tsx              # Variantes de botoes
        InputsSection.tsx               # Inputs e formularios
        CardsSection.tsx                # Variantes de cards
        BadgesSection.tsx               # Badges e tags
        NavigationSection.tsx           # Navbar exemplo
        HeroSection.tsx                 # Hero section
        PricingSection.tsx              # Pricing table
        TestimonialsSection.tsx         # Testimonials
        FeaturesSection.tsx             # Feature cards
        FAQSection.tsx                  # FAQ accordion
        FooterSection.tsx               # Footer
        PagesSection.tsx                # Mapa de paginas
        GuidelinesSection.tsx           # Regras de uso
```

## 3. Hierarquia de Tokens

### 3.1 Tokens Primitivos
Valores brutos sem contexto semantico:

```typescript
// cores
const primitives = {
  blue: { 50: '#eff6ff', 100: '#dbeafe', ..., 900: '#1e3a8a' },
  red:  { 50: '#fef2f2', 100: '#fee2e2', ..., 900: '#7f1d1d' },
  // ...
}
```

### 3.2 Tokens Semanticos
Mapeiam primitivos para intencoes:

```typescript
const semantic = {
  primary: primitives.blue[600],
  destructive: primitives.red[600],
  success: primitives.green[600],
  warning: primitives.amber[500],
  muted: primitives.gray[500],
}
```

### 3.3 Tokens de Componente
Uso especifico em componentes:

```typescript
const component = {
  buttonPrimaryBg: semantic.primary,
  buttonPrimaryHover: primitives.blue[700],
  cardBorder: primitives.gray[200],
  inputFocusRing: semantic.primary,
}
```

## 4. Secoes Detalhadas

### 4.1 Cores
- Exibir cada paleta com swatches clicaveis (copiam hex ao clicar)
- Incluir semantic tokens (primary, secondary, destructive, etc.)
- Mostrar CSS variables correspondentes
- Garantir contraste WCAG AA em combinacoes texto/fundo

### 4.2 Tipografia
- Escala completa: display-xl, display-lg, h1-h6, body-lg, body, body-sm, caption
- Para cada token: size (px/rem), weight, line-height, letter-spacing
- Preview real renderizado (nao apenas valores numericos)
- Indicar uso recomendado (ex: "h1 — titulos de pagina")

### 4.3 Espacamento
- Escala baseada em multiplos de 4px: 0, 1(4px), 2(8px), 3(12px), 4(16px), 5(20px), 6(24px), 8(32px), 10(40px), 12(48px), 16(64px)
- Barras visuais com largura proporcional ao valor
- Mapeamento para classes Tailwind (p-1, p-2, m-4, gap-6, etc.)

### 4.4 Border Radius
- Escala: none(0), sm(2px), default(4px), md(6px), lg(8px), xl(12px), 2xl(16px), full(9999px)
- Preview visual com shapes quadradas aplicando cada radius

### 4.5 Sombras
- Escala de elevacao: sm, default, md, lg, xl, 2xl
- Preview visual com cards flutuantes em cada nivel
- Indicar uso recomendado (ex: "md — cards elevados, dropdowns")

### 4.6 Botoes
Documentar todas as combinacoes:

| Propriedade | Valores |
|-------------|---------|
| Variante | primary, secondary, outline, ghost, destructive, success |
| Tamanho | sm, default, lg, icon |
| Estado | default, hover, focus, disabled, loading |

- Loading state deve usar spinner animado
- Mostrar codigo de uso para cada variante

### 4.7 Inputs & Forms
- Tipos: text, email, password, number, select, textarea, checkbox, radio, switch
- Estados: default, focus, error, disabled
- Incluir labels, helper text, error messages
- Mostrar validacao visual (borda vermelha + mensagem de erro)

### 4.8 Cards
- Variantes: default (borda sutil), elevated (shadow), highlighted (borda colorida)
- Composicoes: card com header, card com imagem, card com footer/actions

### 4.9 Badges
- Variantes de cor: default, primary, secondary, destructive, success, warning
- Formatos: rounded (retangulo com cantos arredondados), pill (totalmente arredondado)

## 5. Patterns (Composicoes)

### 5.1 Navegacao
- Header com logo, links de navegacao, CTAs (login/signup)
- Versao mobile com menu hamburger

### 5.2 Hero Section
- Headline com gradient ou destaque
- Subtitle descritivo
- CTAs primario e secundario
- Social proof (logos de clientes ou metricas)

### 5.3 Pricing Table
- 3 tiers (Free, Pro, Enterprise)
- Destaque visual no plano recomendado (borda, badge "Popular")
- Lista de features com check/x
- CTA por tier

### 5.4 Testimonials
- Cards com: quote (aspas estilizadas), avatar, nome, cargo, empresa
- Layout em grid ou carrossel

### 5.5 Feature Cards
- Grid 2x2 ou 3x3
- Cada card: icone, titulo, descricao curta
- Icones do set do projeto (Lucide, Heroicons, etc.)

### 5.6 FAQ / Accordion
- Perguntas expandiveis com toggle suave
- Usar componente Accordion da biblioteca UI (shadcn, etc.)
- 4-6 perguntas exemplo

### 5.7 Footer
- Layout multi-colunas (4 colunas recomendado)
- Colunas: Produto, Empresa, Recursos, Legal
- Links sociais com icones
- Copyright

## 6. Mapa de Paginas SaaS

| Pagina | Prioridade | Descricao |
|--------|-----------|-----------|
| Landing / Home | Required | Hero + features + social proof + CTA |
| Pricing | Required | Tabela de precos com comparacao |
| Login / Signup | Required | Formularios de autenticacao |
| Dashboard | Required | Visao geral pos-login |
| Settings / Profile | Required | Configuracoes do usuario |
| About | Recommended | Sobre a empresa/equipe |
| Blog | Recommended | Conteudo e SEO |
| Changelog | Recommended | Historico de mudancas |
| Docs | Optional | Documentacao tecnica |
| Status | Optional | Status dos servicos |
| Terms / Privacy | Required | Legais |

## 7. Guidelines

### 7.1 Cores
- Usar semantic tokens (nao primitivos) nos componentes
- Primary para acoes principais, destructive para acoes destrutivas
- Garantir contraste minimo WCAG AA (4.5:1 texto normal, 3:1 texto grande)
- Nao usar mais de 3 cores acentuadas por pagina

### 7.2 Tipografia
- Maximo 2 font families (display + body)
- Usar escala definida — nunca valores arbitrarios
- Line-height minimo 1.5 para corpo de texto (acessibilidade)

### 7.3 Layout
- Grid de 12 colunas para layouts complexos
- Max-width de conteudo: 1280px (7xl)
- Spacing consistente entre secoes: 64px (16) ou 96px (24)
- Mobile-first: comecar do menor viewport

### 7.4 Componentes
- Sempre usar componentes da biblioteca UI — nunca recriar
- Estados obrigatorios: default, hover, focus, disabled
- Loading states com skeleton ou spinner
- Empty states com ilustracao + CTA

### 7.5 Acessibilidade
- Todos os inputs com labels associados (`htmlFor`)
- Imagens com `alt` descritivo
- Navegacao por teclado funcional (Tab, Enter, Escape)
- Focus ring visivel em todos os interativos
- `aria-label` em botoes icon-only

### 7.6 Performance
- Lazy loading para paginas e imagens abaixo do fold
- Otimizar imagens (WebP, srcset)
- Code splitting por rota

### 7.7 Responsividade
- Breakpoints Tailwind: sm(640), md(768), lg(1024), xl(1280), 2xl(1536)
- Sidebar colapsa em < md
- Grid adapta colunas por breakpoint
- Touch targets minimo 44x44px em mobile

## 8. Integracao com o Pipeline

Ao criar um design system via pipeline:

1. `/project:create-prd design-system` — documenta escopo e requisitos
2. `/project:create-plan design-system` — define ordem de implementacao
3. `/project:create-story design-system` — fragmenta em 4 stories (ver skill)
4. `/project:implement 001` — implementa story por story
5. `/project:review` — valida cada story
6. `/project:commit` — commit incremental

A skill `design-system` e carregada automaticamente quando o contexto envolve criacao de design system, garantindo que o Claude siga o processo correto.
