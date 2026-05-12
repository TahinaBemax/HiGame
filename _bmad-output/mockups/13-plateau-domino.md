# 13 — Plateau Domino

**Rôle :** Le cœur du produit. Jouer une partie de Domino complète.
**États :** mon tour, tour adverse, pioche dispo, blocage, domino!, reconnexion

## Layout

```
┌──────────────────────────┐
│ ⏱ 45s  🎯 Tojo          │  ← Barre info haut: timer + joueur actif
│                          │
│  Adversaire: 5 tuiles    │  ← Haut: stats adversaire (dos de tuiles)
│  ┌──┐ ┌──┐ ┌──┐ ┌──┐   │
│  │??│ │??│ │??│ │??│    │  ← Tuiles adverses face cachée
│  └──┘ └──┘ └──┘ └──┘   │
│                          │
│  ┌──────────────────────┐│
│  │    [6|6] [6|3]      │ │  ← Chaîne domino (scroll horizontal)
│  │         ┃           │ │  ← Double posé perpendiculairement
│  │    [3|3]            │ │
│  └──────────────────────┘│
│                          │
│  Score: Tojo 40 - 25    │  ← Score bar (petit, 2 coins)
│                          │
│ ──────────────────────── │  ← Séparateur
│                          │
│  ┌──┐ ┌──┐ ┌──┐ ┌──┐   │  ← Main du joueur (éventail)
│  │3 │ │6 │ │1 │ │0 │   │  ← Tuiles sélectionnables par tap
│  │4 │ │5 │ │2 │ │3 │   │
│  └──┘ └──┘ └──┘ └──┘   │
│       ↕ (sélectionnée)  │  ← Tuile sélectionnée se soulève
│                          │
│  [Poser]  [Pioche 5⏍]  │  ← Boutons d'action
│                          │
│  Tour adverse:           │  ← Overlay "Tour de X" (si pas mon tour)
│  "Tour de Tojo..."      │
│                          │
└──────────────────────────┘
  Fond: #1565C0 (bleu foncé, ambiance jeu)
```

## Composants
- **Barre info** (timer + joueur actif + score)
- **Zone adversaire** (tuiles face cachée avec compteur)
- **Plateau central** (chaîne domino, scroll horizontal, doubles en travers)
- **Score** (petit, permanent)
- **Main du joueur** (éventail sélectionnable, tap pour soulever)
- **Boutons action** (Poser, Pioche X, Passer)
- **Overlay** (quand pas mon tour / reconnexion)

## Textes (variaminanana)
- Timer: "⏱ **45s**" (compte à rebours)
- Joueur actif: "🎯 **Tojo**"
- Stats: "**5** tuiles" / "**3** tuiles"
- Boutons: "**Poser**" / "**Pioche** (5)" / "**Passer**"
- Mon tour: bordure lumineuse main
- Tour adverse: overlay "**Tour de** Tojo..."
- Blocage: "**Blocage** — calcul scores..."
- Domino!: "🎉 **Domino !**" + animation
- Reconnexion: "🔄 **Reconnexion...**"
- Pioche vide: "**Pioche** vide" (désactivé)

## Interactions
- **Tap sur tuile** → tuile se soulève (sélectionnée)
- **Drag sur chaîne** → si extrémité compatible, tuile s'accroche (prévisualisation)
- **Tap "Poser"** → confirme la pose → animation → tour suivant
- **Tap "Pioche"** → pioche une tuile → si jouable, possibilité de poser
- **Tap "Passer"** → tour suivant
- **Timer fini** → auto-pass si aucune action
- **Reconnexion** → overlay + restauration état

## Règles visuelles
- Chaîne horizontale avec scroll si trop longue
- Doubles posés perpendiculairement
- Faces des tuiles blanches avec points noirs
- Extrémités jouables mises en évidence (glow subtil)
- Tuile du joueur : fond blanc, chiffres noirs, séparation centrale

## Prompt Figma
> HiGame Domino Game Board in portrait mode. Background deep blue #1565C0. Top bar: ⏱ 45s timer, 🎯 active player name. Opponent area: row of face-down domino tiles (grey backs with white dots pattern), count label "5 tuiles". Center: domino chain playing area with horizontal scroll — tiles placed end-to-end, doubles placed perpendicularly crossing the chain. Tile design: white face, black dots, center line. Bottom player hand: fan layout of 4-7 tiles, tap to select (selected tile lifts up with subtle shadow). Action buttons row: "Poser" (accent #00BFA5), "Pioche 5⏍" (outline), "Passer" (text). Score mini-bar at bottom of chain area: "Tojo 40 - 25". When opponent's turn: semi-transparent overlay "Tour de Tojo..." with waiting animation. Mobile 375x812.
