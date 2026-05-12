# 08 — Retrait

**Rôle :** Retirer les gains du wallet vers Mobile Money.
**États :** formulaire, KYC non validé (bloquant), solde insuffisant, loading, success, error

## Layout

```
┌──────────────────────────┐
│ ←  Retirer money        │  ← Header H1
│                          │
│   Solde disponible       │  ← Label
│   Ar 25 000              │  ← Montant H2, accent
│                          │
│   Montant à retirer      │  ← Label
│   ┌──────────────────────┤
│   │ Ar  10 000           │  ← Input min 2000, max 500000
│   └──────────────────────┤
│                          │
│   Vers                    │  ← Label
│   ┌──────────────────────┐│
│   │ ● MVola     [logo]  │  ← Radio selected
│   │   +261 3X XX XXX XX │  ← Numéro KYC (vérifié)
│   └──────────────────────┘│
│                          │
│   Frais: Aucun frais      │  ← Caption
│   Délai: < 24h            │
│                          │
│   [Retirer Ar 10 000]   │  ← Button accent
│                          │
│   ⚠ KYC requis           │  ← État bloquant (banner orange)
│                          │
│   ✅ Demande enregistrée │  ← État success
│   ⏳ Traitement < 24h    │
│                          │
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Solde disponible (accent)
- Input montant (validation min/max)
- Provider radio (avec numéro KYC vérifié)
- Frais & délai info (caption)
- Button accent full-width
- KYC blocked banner
- Success confirmation

## Textes (variaminanana)
- Header: "**Retirer** money"
- Solde: "**Solde** disponible: **Ar 25 000**"
- Input: "Montant à retirer"
- Provider: "**MVola**" / "**Orange Money**" / "**Airtel Money**"
- Info: "**Frais:** Aucun frais HiGame | **Délai:** < 24h"
- Button: "Retirer Ar XX XXX"
- KYC bloquant: "⚠️ **KYC** requis avant tout **retrait**"
- Success: "✅ Demande **enregistrée** ! Reçois l'argent sous **24h**"
- Confirmation OTP: "**Code OTP** envoyé par **SMS** — vérifie"

## Interactions
- Input montant → validation: min 2000, max 500000, ≤ solde
- Select provider → radio highlight
- Tap "Retirer" → OTP popup → confirmation → success
- KYC pas validé → banner bloquant + lien vers KYC
- Solde insuffisant → message rouge + montant max suggéré

## Prompt Figma
> HiGame Withdrawal screen. Header "Faire un retrait" with back arrow. Background #F5F5F5. Available balance shown in teal #00BFA5 "Ar 25 000". Amount input with "Ar" prefix, min 2,000 max 500,000 Ar, radius 12px. Withdrawal method: radio list with MVola selected (shows linked phone number from KYC in #757575), Orange Money, Airtel Money. Fee info "Aucun frais HiGame | Délai < 24h". Full-width accent button "Retirer Ar 10 000". KYC blocked state: orange warning banner #FFB300 "KYC requis avant tout retrait" + button "Vérifier identité". Success state: green card "Demande enregistrée ! Reçois l'argent sous 24h". Mobile 375x812.
