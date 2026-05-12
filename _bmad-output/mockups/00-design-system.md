# 00 — Design System HiGame

## Tokens Fondamentaux

### Palette

| Rôle | Hex | Usage |
|---|---|---|
| **Primaire** | `#1565C0` | Header, boutons principaux, navigation active, liens |
| **Primaire light** | `#42A5F5` | Hover, états actifs, badges |
| **Primaire dark** | `#0D47A1` | Textes sur fond clair, pieds de page |
| **Accent** | `#00BFA5` | Actions "fun", gains, bouton jouer, animations succès |
| **Accent light** | `#64FFDA` | Surbrillances, notifications gain |
| **Success** | `#4CAF50` | Transactions réussies, statut "vérifié", validation |
| **Error** | `#F44336` | Erreurs, pertes, rejet, déconnexion |
| **Warning** | `#FFB300` | Alertes, KYC en attente, solde faible |
| **Fond page** | `#F5F5F5` | Tous les fonds d'écran |
| **Surface** | `#FFFFFF` | Cards, modales, inputs |
| **Text primaire** | `#212121` | Corps de texte |
| **Text secondaire** | `#757575` | Sous-titres, labels |
| **Text disabled** | `#BDBDBD` | États inactifs |
| **Border** | `#E0E0E0` | Séparateurs, bordures input |

### Typographie

**Famille :** Inter (sans-serif)

| Style | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| **H1** | 24px | Bold (700) | 32px | Titres d'écran (header) |
| **H2** | 18px | Semi-Bold (600) | 24px | Sous-titres, sections |
| **H3** | 16px | Semi-Bold (600) | 22px | Titres de card |
| **Body** | 14px | Regular (400) | 20px | Corps de texte |
| **Body small** | 12px | Regular (400) | 16px | Labels, métadonnées |
| **Caption** | 11px | Medium (500) | 14px | Badges, timers |
| **Button** | 15px | Semi-Bold (600) | 20px | Boutons |
| **Monetary** | 20px | Bold (700) | 26px | Montants wallet |

### Spacing (8px grid)

| Token | Pixels |
|---|---|
| `space-xs` | 4px |
| `space-sm` | 8px |
| `space-md` | 12px |
| `space-lg` | 16px |
| `space-xl` | 24px |
| `space-2xl` | 32px |
| `space-3xl` | 48px |

### Border Radius

| Token | Value |
|---|---|
| `radius-sm` | 4px |
| `radius-md` | 8px |
| `radius-lg` | **12px** (boutons, cards, inputs) |
| `radius-round` | 50% (avatars, icônes circulaires) |

---

## Composants

### 1. Button — Primaire

```
┌──────────────────────────┐
│        Milalao           │  ← Accent #00BFA5, text white
└──────────────────────────┘
  height: 48px | radius: 12px | full-width
```

**États :** normal (accent), pressed (darker), disabled (grey #BDBDBD), loading (spinner)

### 2. Button — Secondaire (Outline)

```
┌──────────────────────────┐
│        Miverina           │  ← border #1565C0, text #1565C0
└──────────────────────────┘
  height: 48px | radius: 12px | bg: transparent
```

### 3. Button — Text

```
┌──────────────────────────┐
│        Annuler            │  ← text #757575, no border/bg
└──────────────────────────┘
  height: 40px
```

### 4. Input

```
┌──────────────────────────┐
│ Numéro téléphone          │  ← label top
│ ┌──────────────────────┐ │
│ │ +261  XX XX XXX XX   │ │  ← bg white, border #E0E0E0
│ └──────────────────────┘ │
│ ⚠ Numéro invalide        │  ← error state : border #F44336
└──────────────────────────┘
  height: 48px | radius: 12px | padding horizontal: 16px
```

**États :** default (border #E0E0E0), focus (border #1565C0), error (border #F44336 + message), success (border #4CAF50)

### 5. Card

```
┌──────────────────────────┐
│                          │
│   [icône]  Titre          │  ← bg white, shadow sm
│   Description             │
│                          │
└──────────────────────────┘
  radius: 12px | padding: 16px | shadow: 0 2px 8px rgba(0,0,0,0.08)
```

### 6. Wallet Card

```
┌──────────────────────────┐
│ ═══════════════════════  │  ← gradient #1565C0 → #0D47A1
│                          │
│     Solde                 │  ← label white 12px
│     Ar 12 500             │  ← montant white 24px bold
│                          │
│  [Déposer]   [Retirer]   │  ← btns blancs outline
│ ═══════════════════════  │
└──────────────────────────┘
  radius: 12px | padding: 20px
```

### 7. Bottom Navigation

```
┌────┬──────┬──────┬──────┐
│ 🏠 │  ➕  │  💰  │  👤  │
│Accueil|Partie|Wallet|Profil│
└────┴──────┴──────┴──────┘
  height: 64px | bg white | top border #E0E0E0
  active icon: #1565C0 | inactive: #BDBDBD
```

**4 tabs :** Accueil (dashboard), Partie (créer/rejoindre), Wallet, Profil

### 8. Modal / Bottom Sheet

```
┌──────────────────────────┐
░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ← overlay semi-transparent
┌──────────────────────────┐
│                          │
│   Titre                  │
│   Message / contenu      │
│                          │
│   [Bouton 1]  [Bouton 2] │
│                          │
└──────────────────────────┘
  radius top: 12px | padding: 24px | bg white
```

### 9. Skeleton Loader

```
┌──────────────────────────┐
│ ████████████████████████  │  ← shimmer animation
│ ████████                  │
│ ██████████████            │
│ ████████                  │
└──────────────────────────┘
  bg: #E0E0E0 shimmer → #F5F5F5
  radius: 4px
```

### 10. Toast / Snackbar

```
┌──────────────────────────┐
│ ✅ Transaction réussie   │  ← bg #4CAF50 (success)
└──────────────────────────┘
  | 🔴 Erreur: solde insuff. │  ← bg #F44336 (error)
  └──────────────────────────┘
    | 🟡 Vérification en cours│  ← bg #FFB300 (warning)
    └──────────────────────────┘
      radius: 12px | padding: 12px 16px
```

### 11. Avatar

- **Circulaire**, 40px (défaut), 56px (profil), 24px (salon)
- Bordure de 2px quand actif (vert) / en attente (gris)

### 12. Chip / Badge

```
┌──────────┐
│  Beta    │  ← bg #FFB300, text white 11px
└──────────┘
  radius: 4px | padding: 2px 8px
```

---

## Icônes

**Style :** Material Outlined (ligne fine, 2px stroke)
**Taille standard :** 24x24px
**Couleur :** héritée du contexte (primaire, accent, text)

---

## Ombre

| Niveau | Valeur |
|---|---|
| `shadow-sm` | `0 1px 3px rgba(0,0,0,0.08)` |
| `shadow-md` | `0 4px 12px rgba(0,0,0,0.1)` |
| `shadow-lg` | `0 8px 24px rgba(0,0,0,0.12)` |

---

## Prompt Figma Make

> Generate a mobile design system kit for "HiGame", a Malagasy traditional games platform with real money betting. 
> **Palette:** Primary #1565C0 (blue), Accent #00BFA5 (teal), Success #4CAF50, Error #F44336, Warning #FFB300, Background #F5F5F5, Surface #FFFFFF.
> **Typography:** Inter font. H1 24px Bold, H2 18px Semi-Bold, Body 14px Regular, Button 15px Semi-Bold, Monetary 20px Bold, Caption 11px Medium. 8px grid spacing.
> **Components to include:** Primary button (48px, #00BFA5, radius 12px), Outline button (border #1565C0), Text button, Input field (48px, radius 12px), Card (white, shadow sm, radius 12px), Wallet gradient card (#1565C0 → #0D47A1), Bottom navigation (4 tabs: Home, Game, Wallet, Profile), Modal bottom sheet, Skeleton loader, Toast notifications (success green, error red, warning amber), Avatar (circular 40px), Chip/badge (Beta style). 
> **Style:** Clean, modern, trustworthy + social mix. Rounded but not cartoonish. Suitable for entry-level Android phones (large touch targets, high contrast). Use Material Outlined icons. Mobile-first 375x812 frame.
