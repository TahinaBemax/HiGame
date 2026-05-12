# 01 — Splash Screen

**Rôle :** Première impression. Marque, confiance, orientation.
**États :** loading (vérification session), error (pas de réseau)

## Layout

```
┌──────────────────────────┐
│                          │
│                          │
│                          │
│        [LOGO]            │  ← Logo HiGame (blanc sur fond bleu)
│        HiGame            │  ← H1, white
│                          │
│  Jeux malgaches, argent  │  ← Body, white 80%
│  réel                    │
│                          │
│                          │
│      ○ ○ ○               │  ← Spinner loading (blanc)
│                          │
│                          │
│  v1.0.0-beta             │  ← Caption, white 60%
│                          │
└──────────────────────────┘
  Fond: #1565C0 (primaire)
```

## Composants
- Logo centré (SVG vectoriel, pas de PNG lourd)
- Spinner (animation légère, pas de GIF)
- Texte version

## Texte (variaminanana)
- **HiGame** (le nom, pas de traduction)
- "Jeux malgaches, argent réel" → peut rester en français ou "Lalao malagasy, vola tena izy"

## Interactions
- Auto : 2s → si token valide → Dashboard (05)
- Auto : 2s → si pas de session → Onboarding (02)
- Auto : si erreur réseau → afficher message "Check connexion"

## Prompt Figma
> Splash screen for HiGame mobile app. Background: solid #1565C0 (blue). Center: HiGame logo (simple icon + "HiGame" wordmark in white). Subtitle: "Jeux malgaches, argent réel" in white 14px. Below: thin white circular loading spinner. Bottom corner: version "v1.0.0-beta" in white 60% opacity 11px. Minimalist, clean, 2-second auto-transition. Mobile frame 375x812.
