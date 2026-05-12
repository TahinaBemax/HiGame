# 16 — Paramètres

**Rôle :** Gérer compte, notifications, limites, sécurité.
**États :** normal

## Layout

```
┌──────────────────────────┐
│ ←  Paramètres           │  ← Header H1
│                          │
│  Compte                  │  ← Section title
│  ┌──────────────────────┐│
│  │ ✏️ Modifier pseudo   │ │  ← Ligne avec chevron >
│  │ 🖼️ Changer avatar    │ │
│  │ 📋 Statut KYC: ✅    │ │
│  └──────────────────────┘│
│                          │
│  Notifications           │  ← Section title (toggle switches)
│  ┌──────────────────────┐│
│  │ Notifications push   │─┼─ ← Toggle ON
│  │ Son du jeu           │─┼─ ← Toggle ON
│  │ Vibration            │─┼─ ← Toggle OFF
│  └──────────────────────┘│
│                          │
│  Limites de jeu          │  ← Section title
│  ┌──────────────────────┐│
│  │ 💰 Limite dépôt      │ │
│  │   Journalier: 50 000 │ │  ← Valeur modifiable
│  │ ⏸️ Auto-exclusion    │ │  ← 24h / 7j / 30j
│  └──────────────────────┘│
│                          │
│  Affichage               │  ← Section title
│  ┌──────────────────────┐│
│  │ Langue: Français     │ │
│  │ 🌙 Mode sombre (V2)  │─┼─ ← Grisé
│  └──────────────────────┘│
│                          │
│  Sécurité                │  ← Section title
│  ┌──────────────────────┐│
│  │ 🔐 Mes sessions      │ │
│  │ 🚪 Déconnecter tout  │ │
│  └──────────────────────┘│
│                          │
│  Supprimer mon compte    │  ← Text rouge, avec confirmation
│                          │
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Section titles (H3)
- Settings rows (icon + label + value/control)
- Toggle switches
- Picker (limite, exclusion)
- Danger link (supprimer compte)

## Textes (variaminanana)
- Sections: "**Compte**" / "**Notifications**" / "**Limites** de jeu" / "**Affichage**" / "**Sécurité**"
- Compte: "Modifier **pseudo**" / "Changer **avatar**" / "**KYC**: ✅ Vérifié"
- Notifications: "**Notifications push**" / "**Son** du jeu" / "**Vibration**"
- Limites: "**Limite dépôt** journalier" / "**Auto-exclusion**"
- Affichage: "**Langue**: Français" / "🌙 **Mode sombre** (V2)"
- Sécurité: "🔐 Mes **sessions**" / "🚪 Déconnecter **tout**"
- Danger: "**Supprimer** mon compte"
- Confirmation: "**Sûr** de vouloir supprimer ? Toutes **données** effacées."

## Interactions
- Tap toggle → ON/OFF (avec animation)
- Tap limite → picker ou input
- Tap exclusion → bottom sheet: 24h / 7j / 30j
- Tap langue → sélecteur (Français / Malagasy)
- Tap "Supprimer" → modal confirmation → OTP SMS → suppression
- Tap back → Profil (15)

## Prompt Figma
> HiGame Settings screen. Header "Paramètres" with back arrow. Background #F5F5F5. Grouped sections with titles. Section "Compte": row "Modifier pseudo" with >, "Changer avatar", "KYC: ✅ Vérifié". Section "Notifications": 3 rows with toggle switches (iOS style) — push ON, sound ON, vibration OFF. Section "Limites de jeu": "Limite dépôt journalier: 50 000 Ar" with edit icon, "Auto-exclusion" with chevron. Section "Affichage": "Langue: Français", "Mode sombre" greyed out "V2". Section "Sécurité": "Mes sessions", "Déconnecter tout". Bottom: red text "Supprimer mon compte". Clean list style, white cards per section, 12px radius. Mobile 375x812.
