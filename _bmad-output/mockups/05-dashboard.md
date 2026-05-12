# 05 — Dashboard / Lobby

**Rôle :** Hub central. Tout part d'ici. Vue principale après connexion.
**États :** loading (skeleton), normal, KYC en attente (orange banner), empty (premier dépôt), error

## Layout

```
┌──────────────────────────┐
│ 🎲 HiGame    👁 Ar 500  🔔│  ← Header: logo, solde (toggle), notif bell
│                          │
│ ⚠ KYC en attente...      │  ← Warning banner (#FFB300) si KYC pas validé
│                          │
│ ┌──────────────────────┐ │
│ │  🎮 Domino   ⚡Beta  │ │  ← Game card (actif, badge Beta)
│ │  Jouer maintenant!   │ │
│ ├──────────────────────┤ │
│ │  🎲 Ludo   🚧 Bientôt│ │  ← Game card (grisé)
│ ├──────────────────────┤ │
│ │  🃏 Cartes  🚧 Bientôt││  ← Game card (grisé)
│ └──────────────────────┘ │
│                          │
│ [Créer partie] [Rejoindre]│  ← Boutons inline
│                          │
│ ┌──────────────────────┐ │
│ │ 💰 Wallet >           │ │  ← Quick action card
│ │ Solde: Ar 12 500      │ │
│ └──────────────────────┘ │
│                          │
│ ┌──────────────────────┐ │
│ │ 📊 Historique >       │ │  ← Quick action card
│ └──────────────────────┘ │
│                          │
│                          │
│ [🏠] [➕] [💰] [👤]      │  ← Bottom nav
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Header line (logo, solde avec oeil toggle, notification bell)
- Warning banner (KYC)
- Game cards (Domino actif avec badge "Beta", Ludo/Cartes grisés "Bientôt")
- Action buttons (Créer partie, Rejoindre)
- Quick cards (Wallet, Historique)
- Bottom navigation (4 tabs)

## Textes (variaminanana)
- Solde: "Ar 12 500" (toggle oeil pour masquer)
- Domino card: "🎮 Domino" / "🔥 Jouer maintenant !" / badge "Beta"
- Ludo/Cartes: "🚧 **Bientôt**"
- Boutons: "Créer **partie**" / "Rejoindre **partie**"
- Wallet card: "💰 Wallet" / "Solde: **Ar X**"
- Warning banner: "⚠️ **KYC** en attente — certaines **features** limitées"

## Interactions
- Tap Domino card → Create/Join party flow
- Tap "Créer partie" → Create game (09)
- Tap "Rejoindre" → Join screen (10-11)
- Tap Wallet card → Wallet (06)
- Tap Historique → History (18)
- Tap bell icon → notifications
- Tap oeil → show/hide solde
- Bottom nav → navigation tabs

## Prompt Figma
> HiGame dashboard/lobby screen (home). Background #F5F5F5. Top header bar: "HiGame" logo left, solde (eye toggle) center "Ar 12 500", notification bell icon right. Orange warning banner #FFB300 "KYC en attente — features limitées". Game section: 3 vertical cards (radius 12px, white, shadow sm). Card 1: "🎮 Domino" with green "Beta" badge, active. Card 2: "🎲 Ludo" greyed "Bientôt". Card 3: "🃏 Cartes" greyed "Bientôt". Below: 2 inline buttons "Créer partie" (accent #00BFA5) and "Rejoindre" (outline #1565C0). Then 2 quick cards: "💰 Wallet" with solde, "📊 Historique". Bottom navigation: 4 tabs outlined icons (Home, Game, Wallet, Profile), active #1565C0. Mobile 375x812.
