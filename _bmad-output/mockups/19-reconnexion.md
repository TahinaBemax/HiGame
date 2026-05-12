# 19 — Reconnexion

**Rôle :** Écran affiché pendant une coupure réseau. Critique pour 2G/3G.
**États :** reconnexion en cours, timeout (60s), reconnexion réussie

## Layout

```
┌──────────────────────────┐
│                          │
│     (overlay)            │
│                          │
│  ┌──────────────────────┐│
│  │                      ││
│  │                      ││
│  │   🔄                 ││  ← Spinner large
│  │                      ││
│  │   Reconnexion...     ││  ← H2, white
│  │                      ││
│  │   ⏱ 45s              ││  ← Timer (compte à rebours)
│  │                      ││
│  │   Tentative 2/5      ││  ← Caption
│  │                      ││
│  │                      ││
│  └──────────────────────┘│
│                          │
│ ═════════════════════════│
│                          │
│  (plateau en arrière-    │
│   plan, désaturé/blur)   │
│                          │
└──────────────────────────┘
  Fond: overlay semi-transparent sur le plateau
```

## Layout (timeout)

```
┌──────────────────────────┐
│                          │
│  ┌──────────────────────┐│
│  │                      ││
│  │   ⚠️                 ││  ← Warning icon
│  │                      ││
│  │   Connexion perdue   ││  ← H2
│  │                      ││
│  │   Trop de tentatives ││  ← Body
│  │   La partie continue ││
│  │   sans toi           ││
│  │                      ││
│  │   [Retour au lobby]  ││  ← Button outline
│  │                      ││
│  └──────────────────────┘│
│                          │
└──────────────────────────┘
```

## Composants
- Overlay semi-transparent (sur le plateau en arrière-plan)
- Spinner
- Timer (compte à rebours)
- Tentative counter
- Timeout card (warning icon + message)
- Button "Retour au lobby"

## Textes (variaminanana)
- Reconnect: "🔄 **Reconnexion**..." / "⏱ **45s**" / "Tentative **2/5**"
- Timeout: "⚠️ **Connexion perdue**" / "Trop de tentatives" / "La **partie continue** sans toi"
- Button: "**Retour** au **lobby**"
- Succès: "✅ **Reconnecté** !" + disparition overlay

## Interactions
- Auto : tentative de reconnexion WebSocket
- Timer mis à jour en temps réel
- Succès → overlay disparaît, état plateau restauré
- Timeout → message + bouton retour

## Prompt Figma
> HiGame Reconnection screen (overlay on game board). Semi-transparent dark overlay over the blurred/desaturated domino board. Center: white card with large spinning 🔄 icon, "Reconnexion..." title, countdown timer "⏱ 45s" in large font, attempt counter "Tentative 2/5" in caption. Timeout state: warning icon ⚠️, "Connexion perdue", subtitle "Trop de tentatives — La partie continue sans toi", outline button "Retour au lobby". Success state: overlay fades out, board becomes interactive again. Mobile 375x812.
