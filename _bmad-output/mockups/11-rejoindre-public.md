# 11 — Rejoindre une partie (Public)

**Rôle :** Voir les salons publics disponibles et rejoindre. Écran 2/2.
**États :** loading (skeleton), liste, vide, error

## Layout

```
┌──────────────────────────┐
│ ←  Partie publique      │  ← Header H1
│                          │
│   Filtres                │
│   [Tout] [500] [1000]    │  ← Chips filtre mise
│   [2000] [5000] [10000]  │
│                          │
│   [Tous] [1v1] [4j]     │  ← Chips filtre type
│                          │
│   Salons disponibles     │  ← Label
│                          │
│ ┌──────────────────────┐ │
│ │ 1v1 • Ar 1000         │ │  ← Card salon
│ │ 2/2 joueurs • 60s    │ │
│ │       [Rejoindre]    │ │  ← Bouton inline accent
│ ├──────────────────────┤ │
│ │ 4 joueurs • Ar 2000   │ │
│ │ 1/4 joueurs • 30s    │ │
│ │       [Rejoindre]    │ │
│ ├──────────────────────┤ │
│ │ 1v1 • Ar 5000         │ │
│ │ 1/2 joueurs • 60s    │ │
│ │       [Rejoindre]    │ │
│ └──────────────────────┘ │
│                          │
│   Aucune partie trouvée  │  ← État vide
│   Créez-en une !         │  ← Lien vers Créer (09)
│                          │
│   🔄 3 joueurs cherchent │  ← Banner fusion
│   aussi → Créer avec     │
│   matching auto          │
│                          │
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Filter chips (mise + type)
- Salon cards (type, mise, joueurs/total, temps, bouton Rejoindre)
- Empty state (illustration + lien)
- Fusion banner (si attente > 10s)
- Skeleton loaders (chargement)

## Textes (variaminanana)
- Header: "Partie **publique**"
- Filtres: "**Tout**" / "**1v1**" / "**4 joueurs**"
- Card: "**1v1** • Ar 1 000" / "**2/2** joueurs • **60s**"
- Button: "**Rejoindre**"
- Vide: "**Aucune** partie trouvée" / "Créez-en une **!**"
- Fusion banner: "🔄 **3 joueurs** cherchent aussi **Ar 1 000**"
- Bouton fusion: "Créer avec **matching auto**"

## Interactions
- Tap filter chip → filtrer liste
- Tap "Rejoindre" sur card → vérification solde → Salon d'attente (12)
- Tap "Créer" → Créer partie (09)
- Tap fusion banner → Créer partie avec matching auto
- Pull to refresh

## Prompt Figma
> HiGame Join Public Game screen (screen 2 of 2). Header "Partie publique" with back arrow. Background #F5F5F5. Filter chips row 1: Tous | 500 | 1,000 | 2,000 | 5,000 | 10,000 Ar. Filter chips row 2: Tous | 1v1 | 4 joueurs. Scrollable list of game room cards: each card white, radius 12px, shows room type (1v1 or 4j), bet amount in Ar, player count (X/total), time per turn, and inline accent "Rejoindre" button. Empty state: friendly illustration + text "Aucune partie trouvée" + link "Créez-en une !". Long-wait banner: orange #FFB300 "3 joueurs cherchent aussi — Créer avec matching auto". Skeleton loaders while loading. Mobile 375x812.
