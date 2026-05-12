# 04 — KYC (Vérification d'identité)

**Rôle :** Upload pièce d'identité. Obligatoire pour jouer avec argent réel. Bloquant si non fait.
**États :** formulaire (type + photo), preview, uploading, success, rejected

## Layout

```
┌──────────────────────────┐
│ ←  Vérification identité │  ← Header H1
│                          │
│  Obligatoire pour jouer  │  ← Body, #757575
│  avec money réel          │
│                          │
│  Type de pièce            │  ← Label
│  ┌──────────────────────┐│
│  │ ○ Carte identité (CIN)│  ← Radio select
│  │ ○ Permis conduire    │  │
│  └──────────────────────┘│
│                          │
│  Photo de la pièce        │  ← Label
│  ┌──────────────────────┐│
│  │                      ││
│  │   📷 Prendre photo   ││  ← Zone upload (dashed border)
│  │   ou galerie          ││
│  │                      ││
│  └──────────────────────┘│
│                          │
│  [Envoyer]               │  ← Button accent, désactivé si pas de photo
│                          │
│  Statut: ⏳ En attente    │  ← Chip warning
│     (si déjà soumis)     │
│                          │
│  🔒 Données chiffrées    │  ← Caption, #757575
│  conformes privacy        │
│                          │
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Radio selector (type de pièce)
- Upload zone (dashed border, icon camera + galerie)
- Image preview (après sélection)
- Button "Envoyer"
- Status chip (warning: attente, success: vérifié, error: rejeté)
- Security notice text

## Textes (variaminanana)
- Header: "Vérification identité"
- Sous-titre: "Obligatoire pour jouer avec **money réel**"
- Type: "Carte identité (**CIN**)" / "Permis conduire"
- Upload: "Prendre **photo**" / "Choisir **galerie**"
- Button: "Envoyer"
- Statuts: "⏳ En attente" / "✅ Vérifié" / "❌ Rejeté: photo floue"
- Sécurité: "🔒 Données **chiffrées** & conformes **privacy**"

## Interactions
- Select type → highlight radio
- Tap upload → bottom sheet: "Appareil photo" / "Galerie"
- Photo prise → preview avec bouton "Re-prendre"
- Tap "Envoyer" → loading spinner → success/error toast
- Statut rejeté → message motif + bouton "Réessayer"

## Prompt Figma
> KYC identity verification screen for HiGame. Header "Vérification d'identité" with back arrow. Subtitle "Obligatoire pour jouer avec money réel" in #757575. Radio selector: "Carte d'identité National (CIN)" and "Permis de conduire". Upload zone: dashed border #E0E0E0, 200px height, camera icon centered, text "Prendre photo ou galerie". After photo: image preview with retake button. Accent button "#00BFA5" "Envoyer", disabled until photo attached. Status section: orange chip #FFB300 "⏳ En attente de vérification". Security text "🔒 Données chiffrées & conformes privacy" in #757575 11px. Mobile 375x812.
