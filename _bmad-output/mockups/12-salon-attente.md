# 12 — Salon d'attente

**Rôle :** Salle d'attente avant le début de la partie. Gère le matching, la fusion.
**États :** attente joueurs, privé (code affiché), attente longue (>30s → popup fusion), fusion en cours, ready

## Layout

```
┌──────────────────────────┐
│ ←  Salon #2847    🔒    │  ← Header: numéro salon + icône privé si privé
│                          │
│  Domino • 1v1 • Ar 2000 │  ← Info partie (body small)
│  60s par coup             │
│                          │
│  Code invitation          │  ← Si privé
│  ┌──────────────────┐   │
│  │  A3B2C1            │   │  ← Code large, copiable
│  │ [Copier le code]  │   │
│  └──────────────────┘   │
│                          │
│  Joueurs                 │  ← Section
│                          │
│  ┌────┐  ┌────┐         │
│  │ 👤 │  │ 👤 │         │  ← Avatars 56px
│  │Tojo│  │ ?  │         │  ← Pseudo / "En attente..."
│  │ ✅ │  │ ⏳ │         │  ← Statut prêt
│  └────┘  └────┘         │
│                          │
│  Recherche joueurs...    │  ← Animation si joueurs manquants
│                          │
│  ┌──────────────────────┐│
│  │ ⏳ 45s d'attente...   ││  ← Timer si attente > 0
│  │ 🔄 3 joueurs aussi   ││  ← Popup fusion (après 30s)
│  │ [Rejoindre] [Attendre]││
│  └──────────────────────┘│
│                          │
│  [Annuler / Quitter]     │  ← Button text (créateur: Annuler, sinon: Quitter)
│                          │
│  Si créateur: [Démarrer] │  ← Button accent (actif si tous prêts)
│                          │
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Header (numéro salon, icône cadenas si privé)
- Info partie (jeu, type, mise, temps)
- Code invitation card (si privé)
- Avatars joueurs (56px, avec statut prêt/attente)
- Timer d'attente
- Fusion popup (après 30s)
- Boutons (Annuler, Quitter, Démarrer)

## Textes (variaminanana)
- Header: "Salon #**2847**" + 🔒 (si privé)
- Info: "**Domino** • **1v1** • Ar **2 000** • **60s**/coup"
- Code privé: "**Code invitation**: A3B2C1" / "Copier le **code**"
- Joueurs: pseudo + "**En attente...**"
- Timer: "⏳ **45s** d'attente"
- Fusion: "🔄 **3 joueurs** cherchent aussi Ar 1 000" / "**[Rejoindre]** / [Attendre]"
- Fusion acceptée: "🔄 **Fusion** des salons..."
- Boutons: "**Annuler**" (créateur) / "**Quitter**" (participant) / "**Démarrer**" (si prêt)

## Interactions
- Tap "Copier le code" → presse-papier + toast "Code copié ✅"
- Tap "Annuler" → confirmation → remboursement → Dashboard
- Tap "Quitter" → confirmation → Dashboard
- Tap "Démarrer" (si créateur + tous prêts) → Plateau (13)
- Popup fusion : "Rejoindre" → fusion + redirection / "Attendre" → continue
- Timer 30s → popup fusion automatique
- Timer 60s → "Change de mise ?" suggestion

## Prompt Figma
> HiGame Waiting Room screen. Header "Salon #2847" with lock icon if private, back arrow. Info bar: "Domino • 1v1 • Ar 2 000 • 60s/coup". If private: code display card with large "A3B2C1" text and "Copier le code" button. Players section: 2 (or 4) avatar circles 56px, pseudonym below, status icon (green check if ready, clock if waiting). If waiting: animated "Recherche joueurs..." text with bouncing dots. After 30s: fusion popup card "3 joueurs cherchent aussi Ar 1 000" with "Rejoindre" (accent) and "Attendre" (outline) buttons. Bottom: text button "Annuler" or "Quitter", and "Démarrer" accent button (active only when all players ready + creator). Background #F5F5F5. Mobile 375x812.
