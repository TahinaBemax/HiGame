# 10 — Rejoindre une partie (Privé)

**Rôle :** Rejoindre un salon privé via code. Écran 1/2 du flow "Rejoindre".
**États :** input code, error (code invalide), loading

## Layout

```
┌──────────────────────────┐
│ ←  Rejoindre partie     │  ← Header H1
│                          │
│                          │
│    🔑 Salon privé        │  ← H2, centré
│                          │
│   Entre le code          │  ← Label
│   d'invitation           │
│                          │
│   ┌──────────────────────┤
│   │   _ _ _ _ _ _        │  ← Input code 6 caractères
│   └──────────────────────┤
│                          │
│   [Rejoindre]            │  ← Button accent, désactivé si < 6
│                          │
│   ─── ou ───             │  ← Separator
│                          │
│   Chercher partie        │  ← Button outline
│   publique               │
│                          │
│                          │
│                          │
│  ← précédent             │  ← Lien "Choisir partie publique"
│                          │
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Input code (6 chars, uppercase auto, espacé)
- Button accent "Rejoindre" (désactivé si < 6 chars)
- Separator text "ou"
- Button outline "Partie publique"
- Error message (code invalide)

## Textes (variaminanana)
- Header: "Rejoindre **partie**"
- Titre: "🔑 **Salon privé**"
- Label: "Entre le **code invitation**"
- Input placeholder: "_**_**_**_**_**_**"
- Button: "Rejoindre le **salon**"
- Separator: "— **ou** —"
- Outline: "Chercher **partie publique**"
- Error: "❌ **Code invalide**. Vérifie et réessaie"

## Interactions
- Saisie code → auto uppercase, espacement
- Tap "Rejoindre" → validation code → Salon d'attente (12)
- Code invalide → error message + input shake
- Tap "Partie publique" → Rejoindre public (11)
- Tap back → Dashboard (05)

## Prompt Figma
> HiGame Join Private Game screen (screen 1 of 2). Header "Rejoindre une partie" with back arrow. Background #F5F5F5. Centered layout: large key icon 🔑 at top, title "Salon privé". Code input field: 6 character boxes, each 40x48px, border #E0E0E0 radius 8px, auto-advance on type. Accent button "Rejoindre", disabled until 6 chars. "— ou —" divider. Outline button "Chercher partie publique" (#1565C0). Error state: red border + "Code invalide" message. Mobile 375x812.
