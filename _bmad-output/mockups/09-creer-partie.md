# 09 — Créer une partie

**Rôle :** Configurer et lancer une nouvelle partie Domino.
**États :** formulaire, solde insuffisant (bloquant)

## Layout

```
┌──────────────────────────┐
│ ←  Créer partie         │  ← Header H1
│                          │
│  Jeu                     │  ← Label
│  ┌──────────────────────┐│
│  │ 🎮 Domino    ●      │  ← Seul choix MVP (radio selected)
│  └──────────────────────┘│
│                          │
│  Type                    │
│  ┌──────────────────────┐│
│  │ ○ 1v1 (2 joueurs) ● │  ← Radio (selected 1v1)
│  │ ○ 4 joueurs (2 équ.) │
│  └──────────────────────┘│
│                          │
│  Mise                    │
│  [500] [1000] [2000]     │  ← Chips sélectionnable
│  [5000] [10000]          │
│                          │
│  Salon                   │
│  ┌──────────────────────┐│
│  │ ● Public             │  ← Radio
│  │ ○ Privé (code)       │
│  └──────────────────────┘│
│                          │
│  Temps par coup          │
│  [30s] [60s] [120s]      │  ← Chips
│                          │
│  ┌──────────────────────┐│
│  │ Récapitulatif         │  ← Card recap
│  │ Mise: 2000 Ar         │
│  │ Commission 12%: 480 Ar│
│  │ Gain possible: 3520 Ar│
│  └──────────────────────┘│
│                          │
│  [Créer la partie]       │  ← Button accent
│                          │
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Radio list (Jeu, Type, Mode)
- Chips (Mise, Temps)
- Recap card (transparent)
- Button accent full-width

## Textes (variaminanana)
- Header: "Créer **partie**"
- Jeu: "🎮 **Domino**"
- Type: "**1v1** (2 joueurs)" / "**4 joueurs** (2 équipes)"
- Mise: "**500**" / "**1 000**" / "**2 000**" / "**5 000**" / "**10 000** Ar"
- Mode: "**Public**" / "**Privé** (code)"
- Temps: "**30s**" / "**60s**" / "**120s**"
- Recap: "Mise: **X Ar**" / "Commission 12%: **X Ar**" / "Gain **possible**: **X Ar**"
- Button: "Créer la **partie**"
- Solde insuffisant: "⚠️ **Solde** insuffisant. **Dépose** money."

## Interactions
- Select type → radio update
- Select mise → chip highlight + recap update
- Select mode → public / privé
- Tap "Créer" → vérification solde → Salon d'attente (12)
- Solde < mise → popup "Solde insuffisant" + lien dépôt

## Prompt Figma
> HiGame Create Game screen. Header "Créer une partie" with back arrow. Background #F5F5F5. Radio cards: Game (Domino only, greyed if multiple), Type (1v1 or 3 joueurs). Chips row for Mise: 500 | 1,000 | 2,000 | 5,000 | 10,000 Ar (rounded chips, selected #00BFA5). Mode toggle: Public / Privé (code). Chips for Time per turn: 30s | 60s | 120s. Grey recap card showing: mise, commission 12%, gain potentiel. Full-width accent button "Créer la partie". Insufficient balance state: popup "Solde insuffisant" with "Déposer" link. Mobile 375x812.
