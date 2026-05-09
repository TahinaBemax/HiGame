---
sprint_id: "S03"
sprint_duration: "11 jours"
sprint_goal: "Dashboard, création de partie et moteur Domino côté serveur"
stories:
  - "3.1 — Dashboard principal"
  - "3.2 — Créer une partie Domino"
  - "4.1 — Moteur Domino server-authoritative + RNG"
dev_profile: "Junior solo avec IA assistant"
depends_on: "Sprint 2 (auth complète, KYC, règles)"
---

# Sprint 3 Planning — HiGame MVP

## Objectif du Sprint

**"Un joueur connecté voit son dashboard, crée une partie Domino, et le serveur sait gérer une partie complète."**

À la fin de ce sprint, le flow suivant est fonctionnel :
1. L'utilisateur arrive sur le dashboard avec son solde et les jeux disponibles
2. Il configure une partie (mise, type, mode, temps) et la crée
3. Le salon apparaît dans Redis (sorted set par mise)
4. Le moteur Domino côté serveur distribue les tuiles, valide les poses, gère la pioche et le score

---

## Stories du Sprint

| # | Story | FRs | NFRs | UX-DRs | Difficulté | Estimation |
|:-:|-------|:---:|:----:|:------:|:----------:|:----------:|
| S3.1 | Dashboard principal | — | — | UX-DR-11 | 🔵 Facile | 2 jours |
| S3.2 | Créer une partie Domino | FR-05, FR-18 | NFR-05 | UX-DR-13 | 🟡 Moyen | 3 jours |
| S3.3 | Moteur Domino server-authoritative + RNG | FR-07, FR-08, FR-17 | NFR-09, NFR-20, NFR-23 | — | 🔴 Complexe | 5 jours |
| | **Tests + Revue + Rétro** | | | | | **1 jour** |
| | **Total** | **5 FRs** | **4 NFRs** | **2 UX-DRs** | | **11 jours** |

---

## Déroulé Jour par Jour

---

### Jour 1 — Dashboard : header + solde

**Story :** 3.1 (partie 1/2)

**Objectif :** Header du dashboard avec solde wallet et bannière de bienvenue.

#### Tâches

- [ ] Créer DashboardScreen dans Flutter
- [ ] Header avec logo + solde wallet + icône œil (afficher/masquer)
- [ ] Bannière "Bienvenue" avec pseudo du joueur
- [ ] Provider Riverpod pour le solde temps réel (connexion Socket.IO)
- [ ] Bannière orange conditionnelle "KYC en attente"

#### Commandes

```bash
# Créer la structure dashboard
mkdir -p packages/frontend/lib/features/game/presentation/dashboard
# Le provider dashboard connecté au backend
touch packages/frontend/lib/features/game/presentation/dashboard/dashboard_provider.dart
```

#### Définition de fait (Jour 1)

- [ ] Dashboard affiche header (logo + solde + œil)
- [ ] Bannière bienvenue visible
- [ ] Solde affiché / masqué par icône œil
- [ ] Bannière orange visible si KYC en attente

---

### Jour 2 — Dashboard : bottom nav + actions

**Story :** 3.1 (partie 2/2)

**Objectif :** Navigation complète et boutons d'actions rapides.

#### Tâches

- [ ] Intégrer la BottomNavigationBar (4 tabs : Accueil, Partie, Wallet, Profil)
- [ ] Boutons actions rapides : Créer / Rejoindre / Wallet / Historique
- [ ] Section jeux : Domino actif, Ludo/Cartes grisés
- [ ] Redirection des boutons vers les bonnes routes GoRouter
- [ ] Tests du dashboard

#### Définition de fait (Jour 2)

- [ ] Bottom nav 4 tabs fonctionnelle
- [ ] Boutons actions redirigent vers les bonnes pages
- [ ] Domino visible et actif, autres jeux grisés
- [ ] Tests dashboard passent

---

### Jour 3 — Création partie : backend

**Story :** 3.2 (partie 1/2)

**Objectif :** Module de création de salon avec Redis sorted sets.

#### Tâches

- [ ] Créer module `matching` backend (routes, controller, service, schema)
- [ ] POST /game/create : créer un salon dans Redis
- [ ] Structure salon : gameId, type (1v1/4j), mise, mode (public/privé), temps par coup, code privé (6 chars)
- [ ] Redis sorted set par mise : `matching:{mise}` avec score = timestamp
- [ ] Génération code privé 6 caractères aléatoires (mode privé)
- [ ] GET /game/room/:id : récupérer infos salon

#### Définition de fait (Jour 3)

- [ ] POST /game/create crée un salon Redis
- [ ] Salon public ajouté au sorted set `matching:{mise}`
- [ ] Salon privé avec code 6 chars
- [ ] GET /game/room/:id retourne les infos du salon

---

### Jour 4 — Création partie : frontend

**Story :** 3.2 (partie 2/2)

**Objectif :** Écran "Créer une partie" avec sélecteurs et validation.

#### Tâches

- [ ] Créer CreateGameScreen Flutter
- [ ] Sélecteurs : type (1v1/4j), mise (500/1000/2000/5000/10000 Ar), mode (public/privé), temps (30s/60s/120s)
- [ ] Récapitulatif dynamique "Mise X Ar, commission 12%, gain potentiel X Ar"
- [ ] Champ code privé (visible seulement si mode privé)
- [ ] Appel API POST /game/create
- [ ] Redirection vers écran d'attente après création

#### Définition de fait (Jour 4)

- [ ] Tous les sélecteurs fonctionnels
- [ ] Récapitulatif mise à jour en temps réel
- [ ] Création partie → salon Redis créé
- [ ] Redirection vers salon d'attente

---

### Jour 5 — Moteur Domino : structure + types

**Story :** 4.1 (partie 1/5)

**Objectif :** Structure du module game backend, types tuiles, constantes.

#### Tâches

- [ ] Créer module `game` backend (routes, controller, service)
- [ ] Définir les types : Tile, Board, Hand, GameState, GameConfig
- [ ] Constantes : 28 tuiles double-6, distribution (7 tuiles 1v1, 5 tuiles 4j)
- [ ] Fonction `generateTiles()` : génère les 28 tuiles (0-0 à 6-6)
- [ ] Fonction `shuffleTiles(seed)` : mélange déterministe avec seed RNG
- [ ] Prisma migration : table `games` + `game_players`

#### Définition de fait (Jour 5)

- [ ] Module game backend créé
- [ ] Types Tile, Board, Hand définis
- [ ] generateTiles() produit les 28 tuiles double-6
- [ ] Migration Prisma table games + game_players

---

### Jour 6 — Moteur Domino : distribution + RNG

**Story :** 4.1 (partie 2/5)

**Objectif :** Distribution déterministe des tuiles via RNG seedé.

#### Tâches

- [ ] Implémenter RNG déterministe : seed = hash(gameId + createdAt)
- [ ] Fonction `initGame(gameId)` : distribue tuiles, détermine premier joueur
- [ ] Le premier joueur = celui qui a le double le plus fort (6-6 > 5-5 > ...)
- [ ] Stocker l'état initial dans Redis (clé `game:{gameId}:state`)
- [ ] Émettre événement `game:start` via Socket.IO avec l'état initial
- [ ] Écrire tests unitaires du RNG (même seed → même distribution)

#### Définition de fait (Jour 6)

- [ ] Même seed → même distribution (testé)
- [ ] Premier joueur déterminé par le double le plus fort
- [ ] État initial stocké dans Redis
- [ ] Événement `game:start` émis aux joueurs

---

### Jour 7 — Moteur Domino : validation pose + chaîne

**Story :** 4.1 (partie 3/5)

**Objectif :** Logique de validation des poses et gestion de la chaîne.

#### Tâches

- [ ] Fonction `canPlayTile(tile, boardEnds)` : vérifie compatibilité extrémités
- [ ] Fonction `placeTile(gameState, playerId, tile, end)` : pose une tuile
- [ ] Mettre à jour la chaîne (board) : extrémités gauche/droite
- [ ] Gérer les doubles : pose perpendiculaire, compte pour 4 extrémités (variante malgache)
- [ ] Fonction `getPlayableTiles(hand, boardEnds)` : retourne les tuiles jouables
- [ ] Valider que c'est bien le tour du joueur
- [ ] Émettre `game:tile-placed` avec le nouvel état

#### Définition de fait (Jour 7)

- [ ] canPlayTile valide correctement la compatibilité
- [ ] placeTile met à jour la chaîne et les extrémités
- [ ] Doubles gérés perpendiculairement
- [ ] Vérification du tour du joueur

---

### Jour 8 — Moteur Domino : pioche + talon + timer

**Story :** 4.1 (partie 4/5)

**Objectif :** Gestion de la pioche, talon, et timer par coup.

#### Tâches

- [ ] Fonction `drawTile(gameState, playerId)` : pioche depuis le talon
- [ ] Si talon vide + tuile non jouable → `passTurn`
- [ ] Fonction `nextTurn(gameState)` : passe au joueur suivant
- [ ] Timer Redis : clé `game:{gameId}:timer:{playerId}` avec TTL configurable
- [ ] À expiration du timer : passe automatiquement (ou pioche si obligatoire)
- [ ] Émettre `game:timer-expired`, `game:turn-changed`, `game:tile-drawn`

#### Définition de fait (Jour 8)

- [ ] Pioche depuis le talon fonctionnelle
- [ ] Passage de tour automatique si talon vide
- [ ] Timer Redis avec TTL configurable (30/60/120s)
- [ ] Expiration timer → action automatique

---

### Jour 9 — Moteur Domino : score + fin manche + events

**Story :** 4.1 (partie 5/5)

**Objectif :** Calcul des scores, détection fin de manche/partie, événements.

#### Tâches

- [ ] Fonction `checkDomino(gameState)` : détecte "Domino!" (dernière tuile posée)
- [ ] Fonction `checkBlocked(gameState)` : détecte blocage (personne ne peut jouer)
- [ ] Fonction `calculateRoundScore(gameState)` : somme des tuiles adverses
- [ ] Fonction `checkGameOver(gameState)` : score ≥ 100 → partie terminée
- [ ] Enregistrer chaque action comme `game_event` (event sourcing, AR-02)
- [ ] Émettre `game:round-end`, `game:game-over` avec scores

#### Définition de fait (Jour 9)

- [ ] "Domino!" détecté quand un joueur vide sa main
- [ ] Blocage détecté quand personne ne peut jouer
- [ ] Score calculé correctement
- [ ] Partie terminée quand score ≥ 100
- [ ] Tous les événements enregistrés dans game_events

---

### Jour 10 — Tests moteur Domino

**Story :** 4.1

**Objectif :** Tests unitaires et d'intégration du moteur Domino.

#### Tâches

- [ ] Tests unitaires : `generateTiles` → 28 tuiles uniques
- [ ] Tests unitaires : `shuffleTiles(seed)` → reproductible
- [ ] Tests unitaires : `canPlayTile` → tous les cas (compatible/incompatible/double)
- [ ] Tests unitaires : `placeTile` → chaîne mise à jour
- [ ] Tests unitaires : `calculateRoundScore` → somme correcte
- [ ] Tests d'intégration : partie complète simulée via Socket.IO
- [ ] Tests dashboard + création partie

#### Définition de fait (Jour 10)

- [ ] `npx vitest run` → tout vert
- [ ] `flutter test` → tout vert
- [ ] Moteur Domino testé : distribution, pose, pioche, score
- [ ] Aucune régression sur S1 et S2

---

### Jour 11 — Revue + Rétrospective

**Objectif :** Consolider le sprint, vérifier la complétude.

#### Tâches

- [ ] Revue de code de tout le sprint
- [ ] Vérifier lint (npm run lint + flutter analyze)
- [ ] Vérifier que le moteur Domino est correct (rejouer des parties test)
- [ ] Checklist définition of done
- [ ] Rétrospective

---

## Définition of Done (Sprint 3)

- [ ] Dashboard affiché avec solde, actions, bottom nav
- [ ] Création partie fonctionnelle (sélecteurs, création Redis, salon attente)
- [ ] Moteur Domino server-authoritative : distribution, pose, pioche, score
- [ ] RNG déterministe seedé (même seed → même partie)
- [ ] Timer par coup (30s/60s/120s) avec passage automatique
- [ ] Tous les événements enregistrés dans game_events
- [ ] Tests passent (flutter test + vitest)
- [ ] Lint passe (flutter analyze + npm run lint)
- [ ] Aucune régression sur les sprints précédents
