# 14 — Résultat de partie

**Rôle :** Annoncer le gagnant, détailler les scores, proposer revanche.
**États :** victoire (confettis), défaite (neutre), égalité (rare)

## Layout

```
┌──────────────────────────┐
│                          │
│    🏆 Partie terminée ! │  ← Header H1 (trophée si victoire)
│                          │
│  ┌──────────────────────┐│
│  │    [Avatar 80px]     ││  ← Avatar gagnant grand
│  │    Tojo               ││
│  │    🏆 A gagné !      ││  ← Texte victoire
│  │                      ││
│  │  Gain: Ar 3 520     ││  ← Montant gagné (accent, large)
│  │  (après commission   ││
│  │   12%)               ││
│  └──────────────────────┘│
│                          │
│  Scores détaillés        │  ← H3
│  ┌──────────────────────┐│
│  │ Tojo   20 pts   ✅  ││  ← Tableau scores
│  │ Mialy  47 pts        ││
│  └──────────────────────┘│
│                          │
│  Bouton voir tuiles      │  ← Text link "Voir tuiles restantes"
│                          │
│  ┌──────────────────────┐│
│  │ Tuiles restantes:    ││  ← Expandable (après tap)
│  │ Mialy: [3|4] [5|1]  ││
│  └──────────────────────┘│
│                          │
│  [Revanche !]            │  ← Button accent (recrée partie identique)
│  [Retour au lobby]       │  ← Button outline
│                          │
└──────────────────────────┘
  Fond: #F5F5F5
```

## Composants
- Trophée/Header (victoire: vert/trophée, défaite: gris)
- Avatar gagnant (grand, 80px)
- Gain card (accent, montant large)
- Scores table (joueur, points, résultat)
- Expandable tuiles restantes
- Buttons (Revanche, Retour)

## Textes (variaminanana)
- Victoire: "🏆 **Partie terminée** !" / "**A gagné** !"
- Défaite: "**Partie terminée**" (neutre)
- Gain: "**Gain**: Ar **3 520**" / "après **commission 12%**"
- Tableau: "**Tojo** — 20 pts ✅" / "**Mialy** — 47 pts"
- Link: "Voir **tuiles restantes**"
- Buttons: "**Revanche !**" / "**Retour** au lobby"
- Égalité: "**Égalité** ! La manche rejouée"

## Interactions
- Victoire → confettis animation + toast gain
- Tap "Voir tuiles" → expand section avec tuiles de chaque joueur
- Tap "Revanche !" → recrée salon avec mêmes paramètres
- Tap "Retour" → Dashboard (05)

## Prompt Figma
> HiGame Game Result screen. Victory state: confetti animation overlay, 🏆 trophy icon, header "Partie terminée !". Center: large winner avatar 80px circle, name "Tojo", "🏆 A gagné !" text. Green gain card: "Gain: Ar 3 520" in large bold #00BFA5, subtitle "après commission 12%". Below: scores table with 2 players (or 4), each row: avatar 24px, name, points, checkmark for winner. Expandable link "Voir tuiles restantes" reveals each player's remaining tiles. Two buttons: "Revanche !" (accent #00BFA5) and "Retour au lobby" (outline #1565C0). Defeat state: no confetti, neutral grey tones, no trophy. Background #F5F5F5. Mobile 375x812.
