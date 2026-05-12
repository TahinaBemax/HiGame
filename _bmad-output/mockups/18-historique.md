# 18 — Historique

**Rôle :** Consulter l'historique des parties, filtres, détail/replay.
**États :** loading, liste, vide, detail (replay textuel)

## Layout

```
┌──────────────────────────┐
│ ←  Historique           │  ← Header H1
│                          │
│  [Toutes] [Victoires]    │  ← Filter chips
│  [Défaites]              │
│                          │
│  Liste parties           │
│                          │
│ ┌──────────────────────┐ │
│ │ 08 Mai • 1v1 • 2000  │ │  ← Card partie
│ │ 🏆 Gagné: +3520 Ar  │ │  ← Victoire (vert)
│ │ ⏱ 12 min  ▶ Détail  │ │
│ ├──────────────────────┤ │
│ │ 07 Mai • 4j • 1000   │ │
│ │ ❌ Perdu: -1000 Ar   │ │  ← Défaite (rouge)
│ │ ⏱ 8 min  ▶ Détail   │ │
│ ├──────────────────────┤ │
│ │ 06 Mai • 1v1 • 500   │ │
│ │ 🤝 Annulé: 0 Ar     │ │  ← Annulé (gris)
│ │ ⏱ 2 min  ▶ Détail   │ │
│ └──────────────────────┘ │
│                          │
│  [Charger plus...]       │  ← Pagination / scroll infini
│                          │
│                          │
│  Aucune partie           │  ← État vide
│  Jouez votre 1ère partie!│
│                          │
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Filter chips (Toutes, Victoires, Défaites)
- Partie cards (date, type, mise, résultat, durée, bouton détail)
- Empty state
- Pagination / infinite scroll
- Detail overlay (replay textuel des coups)

## Textes (variaminanana)
- Header: "**Historique**"
- Filtres: "**Toutes**" / "**Victoires**" / "**Défaites**"
- Victoire: "🏆 **Gagné**: +**3 520** Ar" (vert)
- Défaite: "❌ **Perdu**: -**1 000** Ar" (rouge)
- Annulé: "🤝 **Annulé**: 0 Ar" (gris)
- Info: "**08 Mai** • 1v1 • Ar **2 000** • **12 min**"
- Lien: "▶ **Détail**"
- Vide: "**Aucune** partie" / "Joue ta **1ère partie** !"
- Détail (replay): "**Tour 1**: Tojo pose [6|6]" / "**Tour 2**: Mialy pose [6|3]"

## Interactions
- Tap filter → filtrer liste
- Tap card → slide pour révéler bouton "Détail" OU tap direct
- Tap "Détail" → detail screen avec replay textuel
- Scroll → infinite scroll (20 par page)
- Tap "Rejouer" depuis le détail → recrée partie identique

## Prompt Figma
> HiGame Game History screen. Header "Historique" with back arrow. Background #F5F5F5. Filter chips row: Toutes | Victoires | Défaites. List of game cards: each white card radius 12px shows date, game type (1v1/4j), bet amount, result line (green "+3 520 Ar" for win, red "-1 000 Ar" for loss, grey "Annulé"), duration, and "▶ Détail" link. Infinite scroll. Empty state: illustration + "Aucune partie — Joue ta 1ère partie !". Detail overlay: chronological list of moves "Tour 1: Tojo pose [6|6]" in monospace style. Mobile 375x812.
