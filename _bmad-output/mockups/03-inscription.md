# 03 — Inscription (Numéro + OTP)

**Rôle :** Créer un compte par téléphone. Flow critique (1er contact avec l'app).
**États :** input numéro, OTP, error (numéro invalide, code incorrect), timeout (renvoi), max tentatives

## Layout

```
┌──────────────────────────┐
│ ←  Créer compte          │  ← Header: H1, #212121, back arrow
│                          │
│   Numéro téléphone       │  ← Label body, #757575
│   ┌──────────────────┐   │
│   │ +261  XX XX XXX   │   │  ← Input, 9 chiffres, espacement auto
│   └──────────────────┘   │
│                          │
│   [Recevoir le code]     │  ← Button accent, désactivé si < 9 chiffres
│                          │
│   ☐ J'accepte les CGU    │  ← Checkbox + lien CGU (body small)
│   et Privacy             │
│                          │
│                          │
│   Étape suivante :       │
│   ┌──────────────────┐   │
│   │ Code OTP : _ _ _ _│   │  ← 4 inputs OTP, auto-focus
│   └──────────────────┘   │
│   ⚠ Code incorrect       │  ← Error state
│   Renvoyer dans 30s      │  ← Timer + renvoi
│                          │
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Header avec back arrow
- Input téléphone (+261 préfixe fixe, masque XX XX XXX XX)
- Button "Recevoir le code" (désactivé si < 9 chiffres)
- Checkbox CGU (liens)
- OTP input (4 chiffres, input masqué)
- Timer "Renvoyer dans Xs"

## Textes (variaminanana)
- Header: "Créer compte"
- Label: "Numéro téléphone"
- Placeholder: "+261  XX XX XXX XX"
- Button: "Recevoir le code"
- Checkbox: "J'accepte **CGU** & **Privacy**"
- OTP label: "Code **OTP** reçu par **SMS**"
- Error: "Code **incorrect**"
- Timer: "Renvoyer dans **30s**"
- Max tentatives: "Bloqué 15 min — trop de tentatives"

## Interactions
- Saisie numéro → masque auto XX XX XXX XX
- Tap "Recevoir le code" → envoi SMS OTP → afficher section OTP
- Saisie OTP → auto-validation 4 chiffres
- Error → message rouge + réinitialisation champ
- Timer → bouton renvoi actif après 30s
- Succès → KYC (04)

## Prompt Figma
> Registration screen for HiGame mobile app. Header "Créer un compte" with back arrow. White card on #F5F5F5 background. Phone input: fixed prefix "+261", 9-digit mask "XX XX XXX XX", 48px height, radius 12px, border #E0E0E0. Accent button (#00BFA5) "Recevoir le code" disabled until 9 digits filled. Below: checkbox "J'accepte les CGU et Privacy" with links. Secondary section for OTP: 4 separate digit inputs, centered, each 48x48px, border #E0E0E0. Error state: input border #F44336 + "Code incorrect" message. Timer "Renvoyer dans 30s" in #757575. Clean, spacious, high contrast for readability on small screens. Mobile 375x812.
