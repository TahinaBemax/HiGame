# 17 — Règles du jeu

**Rôle :** Expliquer les règles du Domino (variante malgache). Accessible sans compte.
**États :** normal

## Layout

```
┌──────────────────────────┐
│ ←  Règles du Domino     │  ← Header H1
│                          │
│  Sections (accordéon)    │
│                          │
│  > 🎯 Objectif          │  ← Expandable
│                          │
│  > 📋 Mise en place      │
│                          │
│  > 🎮 Déroulement        │
│    ┌──────────────────┐  │
│    │                  │  │  ← Illustration: chaîne domino
│    │  [schéma]        │  │
│    │                  │  │
│    └──────────────────┘  │
│                          │
│  > 💯 Scores             │
│                          │
│  > 🏁 Fin de partie      │
│                          │
│  > 🇲🇬 Variante MG       │  ← En évidence (accent)
│    ┌──────────────────┐  │
│    │ • Double départ   │  │  ← Liste règles spécifiques MG
│    │ • Pioche obligat.│  │
│    │ • Arrondi dizaine│  │
│    └──────────────────┘  │
│                          │
│  accessible sans compte  │  ← Caption
│                          │
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Header avec back
- Accordéon sections (expandable/collapsible)
- Schémas/illustrations (SVG, légers)
- Variante malgache mise en avant (accent)

## Textes (variaminanana)
- Header: "**Règles** du **Domino**"
- Sections: "🎯 **Objectif**" / "📋 **Mise en place**" / "🎮 **Déroulement**" / "💯 **Scores**" / "🏁 **Fin partie**" / "🇲🇬 **Variante MG**"
- Variante MG: "**Double départ** — commence par plus haut double" / "**Pioche obligatoire**" / "Arrondi à la **dizaine** supérieure" / "**Blanc** (0) compte 0 point"
- Footer: "Accessible **sans compte**"

## Interactions
- Tap section → expand/collapse avec animation fluide
- Déroulement → illustration schéma
- Variante MG → expand par défaut (highlight)
- Scroll

## Prompt Figma
> HiGame Domino Rules screen. Header "Règles du Domino" with back arrow. Background #F5F5F5. Accordion-style expandable sections: 🎯 Objectif, 📋 Mise en place, 🎮 Déroulement (with simple illustration of domino chain layout), 💯 Scores, 🏁 Fin de partie. Last section: 🇲🇬 Variante MG highlighted with light teal background #E0F2F1, listing: Double départ, Pioche obligatoire, Arrondi dizaine, Blanc = 0 point. Each section expands smoothly. Footer note "Accessible sans compte" in #757575. Mobile 375x812.
