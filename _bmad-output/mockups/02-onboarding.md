# 02 — Onboarding (3 slides)

**Rôle :** Présenter la valeur en 3 slides, préparer à l'inscription.
**États :** 3 slides, navigation par swipe et dots

## Layout

```
┌──────────────────────────┐
│                          │
│                          │
│     ┌──────────┐         │
│     │ Visuel   │         │  ← Illustration (tuiles domino + pièces)
│     │ Slide    │         │     (logos MVola/OM + flèche)
│     └──────────┘         │     (bouclier + cadenas)
│                          │
│   Joue au Domino et      │  ← H2, text #212121
│   gagne                  │
│                          │
│  Affronte des joueurs    │  ← Body, text #757575
│  de tout Madagascar...   │
│                          │
│       ○ ○ ○              │  ← Dots (actif: #1565C0, inactif: #E0E0E0)
│                          │
│     [Suivant]            │  ← Button primaire (accent #00BFA5)
│                          │
│        Passer            │  ← Text button, #757575
│                          │
└──────────────────────────┘
```

### Slides

| Slide | Titre (MG) | Sous-texte | Visuel |
|---|---|---|---|
| 1 | "Milalao Domino, **win** vola !" | "Affronte joueurs Madagascar, gagne money réel." | Tuiles domino + pièces or |
| 2 | "**Mobile Money** direct" | "Dépose, retire via MVola, OM, Airtel — 1 **clic**." | Logos MVola/OM/Airtel |
| 3 | "**Secure** & transparent" | "Parties équitables, commission 12% claire, retrait **instantané**." | Bouclier + cadenas |

## Composants
- Illustration (SVC vectoriel, pas d'image lourde)
- Dots de progression (3)
- Button "Suivant" (accent) / "Commencer" (dernier slide)
- Lien "Passer" (text button)

## Texte (variaminanana)
- Slide 1: "Milalao Domino, win vola !" / "Affronte joueurs Madagascar, gagne money réel."
- Slide 2: "Mobile Money direct" / "Dépose, retire via MVola, OM, Airtel — 1 clic."
- Slide 3: "Secure & transparent" / "Parties équitables, commission 12% claire, retrait instantané."
- Bouton: "Suivant" → dernier slide "Commencer"
- Lien: "Passer" (skip)

## Interactions
- Swipe horizontal gauche/droite
- Tap "Suivant" → slide suivant
- Tap "Commencer" (slide 3) → Inscription (03)
- Tap "Passer" → Inscription (03)

## Prompt Figma
> Mobile onboarding for HiGame app, 3 slides with horizontal swipe. Slide 1: domino tiles illustration + coins, title "Milalao Domino, win vola !", subtitle "Affronte joueurs Madagascar, gagne money réel." Slide 2: MVola/OM/Airtel logos with arrow, title "Mobile Money direct", subtitle "Dépose, retire via MVola, OM, Airtel — 1 clic." Slide 3: shield + lock illustration, title "Secure & transparent", subtitle "Parties équitables, commission 12% claire, retrait instantané." Bottom: 3 progress dots (active #1565C0, inactive #E0E0E0), accent button (#00BFA5) "Suivant" (last slide: "Commencer"), text link "Passer" in #757575. White background #FFFFFF. Mobile 375x812.
