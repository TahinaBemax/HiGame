# 07 — Dépôt

**Rôle :** Ajouter de l'argent au wallet via Mobile Money.
**États :** formulaire, loading (redirection), success (confettis), error, timeout

## Layout

```
┌──────────────────────────┐
│ ←  Déposer money        │  ← Header H1
│                          │
│   Montant                │  ← Label
│                          │
│   [5 000] [10 000]       │  ← Quick amount chips
│   [20 000] [50 000]      │
│   [100 000]              │
│                          │
│   ┌──────────────────────┤
│   │ Ar  15 000           │  ← Input personnalisé (min 1000, max 200000)
│   └──────────────────────┤
│                          │
│   Mode paiement          │  ← Label
│   ┌──────────────────────┐│
│   │ ● MVola     [logo]  │  ← Radio selected (recommandé)
│   │ ○ Orange M.  [logo] │
│   │ ○ Airtel M.  [logo] │
│   └──────────────────────┘│
│                          │
│   Frais: Gratuit HiGame  │  ← Caption
│   3% coté provider       │
│                          │
│   [Déposer Ar 15 000]   │  ← Button accent (#00BFA5)
│                          │
│   Loading...             │  ← État: redirection MVola
│     ⏳ Redirection...    │
│                          │
│   ✅ Succès!             │  ← État: animation confettis
│   Ar 15 000 crédités     │
│                          │
│   ❌ Échec               │  ← État: erreur
│   Veuillez réessayer     │
│                          │
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Quick amount chips (sélectionnable, accent border)
- Input montant (avec préfixe Ar, min/max validation)
- Provider radio list (MVola logo, OM logo, Airtel logo)
- Frais info (caption)
- Button accent full-width
- Success overlay (confettis animation)
- Error state (toast rouge)

## Textes (variaminanana)
- Header: "**Déposer** money"
- Label: "Montant"
- Quick: "**5 000**" / "**10 000**" / "**20 000**" / "**50 000**" / "**100 000**"
- Provider: "**MVola** (recommandé)" / "**Orange Money**" / "**Airtel Money**"
- Frais: "**Frais:** Gratuit HiGame | 3% côté **provider**"
- Button: "Déposer Ar XX XXX"
- Success: "✅ **Ar XX 000** crédités sur ton **wallet** !"
- Error: "❌ **Transaction échouée**. Réessaie."

## Interactions
- Tap chip → auto-remplit input
- Input montant → validation min/max en temps réel
- Select provider → radio highlight
- Tap "Déposer" → redirection MVola (deep link ou USSD)
- Callback → success toast + wallet refresh
- Error → message + retry button
- Timeout → "Vérifie dans historique"

## Prompt Figma
> HiGame Deposit screen. Header "Faire un dépôt" with back arrow. Background #F5F5F5. Quick amount chips row: 5,000 | 10,000 | 20,000 | 50,000 | 100,000 Ar, rounded chips 32px, selected state #00BFA5 border + bg light. Below: amount input field with "Ar" prefix, radius 12px, min 1,000 max 200,000 Ar. Payment provider section: radio list with provider logos — MVola (selected, "Recommandé"), Orange Money, Airtel Money. Fee info text in #757575. Full-width accent button (#00BFA5) "Déposer Ar 15 000". Success state: confetti animation overlay + green card "Ar 15 000 crédités sur ton wallet !". Error state: red toast. Mobile 375x812.
