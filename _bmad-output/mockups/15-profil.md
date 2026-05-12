# 15 — Profil

**Rôle :** Voir et modifier son profil, ses stats, accéder aux paramètres.
**États :** normal

## Layout

```
┌──────────────────────────┐
│    Mon Profil            │  ← Header H1
│                          │
│  ┌──────────────────────┐│
│  │     [Avatar 80px]    ││  ← Avatar (circulaire, modifiable)
│  │     Tojo123          ││  ← Pseudo
│  │     ✏️ Modifier      ││  ← Lien édition
│  └──────────────────────┘│
│                          │
│  Stats                   │  ← H3
│  ┌────┬────┬────┬──────┐│
│  │ 50 │ 32 │ 18 │ 64%  ││  ← Stats cards (parties, V, D, winrate)
│  └────┴────┴────┴──────┘│
│                          │
│  Gains: Ar 125 000       │  ← Ligne stats financières
│  Pertes: Ar 78 000       │
│                          │
│  KYC: ✅ Vérifié        │  ← Statut KYC (chip)
│                          │
│  Menu                    │  ← H3
│  ┌──────────────────────┐│
│  │ 📊 Historique       ││  ← Menu items avec icônes
│  ├──────────────────────┤│
│  │ ⚙️ Paramètres        ││
│  ├──────────────────────┤│
│  │ 📖 Règles du jeu     ││
│  ├──────────────────────┤│
│  │ 🆘 Centre d'aide     ││
│  ├──────────────────────┤│
│  │ 🚪 Déconnexion       ││  ← Rouge
│  └──────────────────────┘│
│                          │
│                          │
│ [🏠] [➕] [💰] [👤]      │  ← Bottom nav (👤 actif)
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Avatar (80px, modifiable)
- Pseudo + edit link
- Stats cards (parties, V, D, winrate)
- Financial stats
- KYC status chip
- Menu list (with icons)
- Bottom nav

## Textes (variaminanana)
- Header: "**Mon Profil**"
- Avatar: tap pour changer / "✏️ **Modifier**"
- Stats: "**50** Parties" / "**32** Victoires" / "**18** Défaites" / "**64%** Winrate"
- Gains: "**Gains**: Ar 125 000" / "**Pertes**: Ar 78 000"
- KYC: "✅ **Vérifié**" / "⏳ En attente" / "❌ Rejeté"
- Menu: "📊 **Historique**" / "⚙️ **Paramètres**" / "📖 **Règles** jeu" / "🆘 **Centre aide**" / "🚪 **Déconnexion**"

## Interactions
- Tap avatar → bottom sheet: "Prendre photo" / "Galerie"
- Tap pseudo → édition (1x/30 jours)
- Tap KYC → écran KYC (04)
- Tap menu items → écrans correspondants
- Tap Déconnexion → confirmation → Splash (01)
- Bottom nav Profil actif

## Prompt Figma
> HiGame Profile screen. Header "Mon Profil". Background #F5F5F5. Top: large avatar circle 80px with camera icon overlay, pseudonym "Tahina123" below, edit link "✏️ Modifier" in #1565C0. Stats row: 4 small cards inline — "50 Parties", "32 Victoires", "18 Défaites", "64% Winrate". Financial stats line: "Gains: Ar 125 000" (green), "Pertes: Ar 78 000" (red). KYC chip: green "✅ Vérifié" or orange "⏳ En attente". Menu list with icons: 📊 Historique, ⚙️ Paramètres, 📖 Règles du jeu, 🆘 Centre d'aide, 🚪 Déconnexion (red text). Each row has right arrow >. Bottom nav Profile tab active. Mobile 375x812.
