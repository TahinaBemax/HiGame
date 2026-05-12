# 06 — Wallet

**Rôle :** Voir le solde, accéder dépôt/retrait, consulter historique rapide.
**États :** loading, normal, vide (pas de transactions), error

## Layout

```
┌──────────────────────────┐
│ ←  Mon Wallet            │  ← Header H1
│                          │
│ ┌──────────────────────┐ │
│ │ ═══════════════════  │ │
│ │                      │ │
│ │   Solde               │ │  ← Label "Solde" white 12px
│ │   Ar 25 000           │ │  ← Montant H1 white bold 👁
│ │                      │ │
│ │ [Déposer]  [Retirer]  │ │  ← Boutons outline blancs
│ │                      │ │
│ │ ═══════════════════  │ │
│ └──────────────────────┘ │
│                          │
│   Dernières transactions │  ← H3
│                          │
│ ┌──────────────────────┐ │
│ │ ➕ Dépôt MVola   Ar   │ │
│ │    10 000        ✅  │ │  ← Ligne: icône + type + montant + statut
│ │    08 Mai 2026        │ │
│ ├──────────────────────┤ │
│ │ ➖ Partie #2847  Ar   │ │
│ │    2 000         ✅  │ │
│ │    07 Mai 2026        │ │
│ ├──────────────────────┤ │
│ │ ➕ Gain Domino   Ar   │ │
│ │    3 520         ✅  │ │
│ │    07 Mai 2026        │ │
│ └──────────────────────┘ │
│                          │
│   Voir tout historique   │  ← Text link, #1565C0
│                          │
│                          │
│ [🏠] [➕] [💰] [👤]      │  ← Bottom nav (💰 actif)
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Wallet card (gradient bleu)
- Button outline (déposer vert, retirer rouge)
- Transaction list (icône + type + montant + date + statut)
- Text link "Voir tout"

## Textes (variaminanana)
- Header: "Mon **Wallet**"
- Label: "**Solde**"
- Boutons: "**Déposer**" / "**Retirer**"
- Transactions: "Dépôt MVola" / "Partie #2847" / "Gain Domino"
- Statut: "✅ Succès" / "⏳ En cours" / "❌ Échoué"
- Vide: "**Aucune** transaction pour le moment"
- Lien: "Voir tout **historique**"

## Interactions
- Tap oeil → show/hide solde
- Tap Déposer → Dépôt (07)
- Tap Retirer → Retrait (08)
- Tap transaction → détail
- Tap "Voir tout" → Historique (18)
- Bottom nav Wallet actif

## Prompt Figma
> HiGame Wallet screen. Header "Mon Wallet" with back arrow. Gradient card #1565C0 to #0D47A1, radius 12px, shows "Solde" label, large amount "Ar 25 000" with eye toggle icon, two outline white buttons "Déposer" and "Retirer". Below: section "Dernières transactions" with list of 3 items: each row has icon (green + for deposit, red - for spend), description, amount, date, status chip (Succès/En cours/Échoué). Text link "Voir tout historique" in #1565C0. Empty state: illustration + "Aucune transaction" message. Background #F5F5F5. Bottom nav Wallet tab active. Mobile 375x812.
