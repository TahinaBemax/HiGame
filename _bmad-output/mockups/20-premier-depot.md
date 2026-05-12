# 20 — Premier dépôt (Wallet vide guidé)

**Rôle :** Guidage pour le premier dépôt quand le wallet est vide. État "empty" du wallet.
**États :** wallet vide (première visite)

## Layout

```
┌──────────────────────────┐
│ ←  Mon Wallet           │  ← Header H1
│                          │
│  ┌──────────────────────┐│
│  │ ═══════════════════  ││
│  │                      ││
│  │    Ar 0              ││  ← Solde à 0
│  │                      ││
│  │ ═══════════════════  ││
│  └──────────────────────┘│
│                          │
│  ┌──────────────────────┐│
│  │                      ││
│  │      💰              ││  ← Illustration large: wallet vide
│  │                      ││
│  │   Ton wallet est     ││  ← H2
│  │   vide               ││
│  │                      ││
│  │   Dépose money       ││  ← Body
│  │   pour commencer à   ││
│  │   jouer et gagner !  ││
│  │                      ││
│  │   ⚡ MVola =        ││  ← Accent info
│  │   Rapide & secure    ││
│  │                      ││
│  └──────────────────────┘│
│                          │
│  [Déposer maintenant]    │  ← Button accent (large, full-width)
│                          │
│  Comment ça marche ?     │  ← Text link
│  ┌──────────────────────┐│
│  │ 1. Dépose money      ││  ← Mini steps (3 étapes simples)
│  │ 2. Choisis partie    ││
│  │ 3. Joue & gagne !    ││
│  └──────────────────────┘│
│                          │
│                          │
│ [🏠] [➕] [💰] [👤]      │  ← Bottom nav (💰 actif)
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Wallet card (gradient, solde 0)
- Empty state illustration (wallet vide)
- CTA "Déposer maintenant" (accent, large)
- "Comment ça marche" expandable
- Mini steps (3)
- Bottom nav

## Textes (variaminanana)
- Solde: "Ar **0**"
- Illustration: "💰"
- Titre: "Ton **wallet** est **vide**"
- Sous-titre: "**Dépose** money pour commencer à **jouer** et **gagner** !"
- Info: "⚡ **MVola** = Rapide & **secure**"
- Button: "**Déposer** maintenant"
- Lien: "Comment ça **marche** ?"
- Steps: "1. **Dépose** money / 2. Choisis **partie** / 3. **Joue** & gagne !"

## Interactions
- Tap "Déposer maintenant" → Dépôt (07)
- Tap "Comment ça marche" → expand mini steps
- Bottom nav Wallet actif

## Prompt Figma
> HiGame Empty Wallet / First Deposit guide screen. Header "Mon Wallet" with back arrow. Background #F5F5F5. Top: gradient wallet card #1565C0→#0D47A1 showing "Ar 0" balance. Center: large friendly illustration of empty wallet with coin icon 💰. Title "Ton wallet est vide" in #212121, subtitle "Déposer de l'argent pour commencer à jouer et gagner !" in #757575. Teal info line "⚡ MVola = Rapide & secure" in #00BFA5. Large full-width accent button "Déposer maintenant". Below: collapsible "Comment ça marche ?" with 3 simple steps: 1. Dépose money, 2. Choisis partie, 3. Joue & gagne !. Bottom nav Wallet tab active. Mobile 375x812.
