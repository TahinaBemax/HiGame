---
sprint_id: "S06"
sprint_duration: "10 jours"
sprint_goal: "Reconnexion, anti-triche et logs administrateur"
stories:
  - "4.4 — Reconnexion après coupure + Timeout abandon"
  - "4.5 — Signalement joueur suspect"
  - "4.6 — Logs de replay administrateur"
dev_profile: "Junior solo avec IA assistant"
depends_on: "Sprint 5 (wallet, dépôt, retrait)"
---

# Sprint 6 Planning — HiGame MVP

## Objectif du Sprint

**"Un joueur peut se reconnecter après une coupure, signaler un joueur suspect, et l'admin peut rejouer n'importe quelle partie."**

À la fin de ce sprint, le flow suivant est fonctionnel :
1. Perte de connexion → écran "Reconnexion..." → restauration complète du plateau
2. Timeout 60s → joueur marqué abandon, la partie continue
3. Un joueur peut signaler un autre joueur (triche, abus, collusion)
4. 3 signalements en 24h → alerte admin
5. L'administrateur consulte les logs de replay d'une partie (event sourcing)

---

## Stories du Sprint

| # | Story | FRs | NFRs | UX-DRs | Difficulté | Estimation |
|:-:|-------|:---:|:----:|:------:|:----------:|:----------:|
| S6.1 | Reconnexion après coupure + Timeout abandon | FR-12, FR-19, FR-20 | NFR-04, NFR-06, NFR-10 | UX-DR-22 | 🟡 Moyen | 4 jours |
| S6.2 | Signalement joueur suspect | FR-14 | — | — | 🔵 Facile | 2 jours |
| S6.3 | Logs de replay administrateur | FR-21 | — | — | 🔵 Facile | 3 jours |
| | **Tests + Revue + Rétro** | | | | | **1 jour** |
| | **Total** | **4 FRs** | **4 NFRs** | **1 UX-DR** | | **10 jours** |

---

## Déroulé Jour par Jour

---

### Jour 1 — Reconnexion : snapshots backend

**Story :** 4.4 (partie 1/4)

**Objectif :** Système de snapshots de partie pour restauration rapide.

#### Tâches

- [ ] Table Prisma `game_snapshots` (gameId, playerId, state JSON, createdAt)
- [ ] Fonction `saveSnapshot(gameId)` : sauvegarder état complet après chaque action
- [ ] Fonction `getSnapshot(gameId, playerId)` : récupérer dernier snapshot
- [ ] Stocker snapshot dans Redis avec TTL pour accès rapide
- [ ] Persister snapshot dans PostgreSQL (Redis = cache, PG = fallback)
- [ ] Endpoint GET /game/reconnect/:gameId : retourner snapshot + état complet

#### Définition de fait (Jour 1)

- [ ] Snapshot sauvegardé après chaque action
- [ ] Snapshot disponible dans Redis + PostgreSQL
- [ ] GET /game/reconnect/:gameId retourne l'état complet

---

### Jour 2 — Reconnexion : restauration état backend

**Story :** 4.4 (partie 2/4)

**Objectif :** Logique de reconnexion et restauration côté serveur.

#### Tâches

- [ ] POST /game/reconnect : endpoint avec sessionId
- [ ] Vérifier que le joueur avait bien une partie en cours
- [ ] Restaurer le plateau, la main, le timer et le score depuis snapshot
- [ ] Gérer le cas "partie terminée pendant la déconnexion" → renvoyer résultat
- [ ] Réintégrer le joueur dans la Socket.IO room
- [ ] Broadcast `player:reconnected` aux autres joueurs
- [ ] Tests reconnexion

#### Définition de fait (Jour 2)

- [ ] POST /game/reconnect restaure l'état complet
- [ ] Plateau, main, timer, score identiques avant/après
- [ ] Joueur réintégré dans la room Socket.IO

---

### Jour 3 — Reconnexion : frontend écran + heartbeat

**Story :** 4.4 (partie 3/4)

**Objectif :** Écran reconnexion avec spinner, détection perte réseau.

#### Tâches

- [ ] Créer ReconnectScreen Flutter (UX-DR-22)
- [ ] Détection perte connexion : heartbeat Socket.IO 10s
- [ ] Écran "Reconnexion..." avec spinner et animation
- [ ] Logique reconnexion automatique : tenter toutes les 5s pendant 60s
- [ ] Socket.IO client avec `reconnection: true`, `reconnectionAttempts: 12`, `reconnectionDelay: 5000`
- [ ] Si reconnecté → restaurer état via snapshot + navigation vers plateau
- [ ] Si timeout 60s → afficher "Partie abandonnée"

#### Définition de fait (Jour 3)

- [ ] Détection perte connexion en < 10s
- [ ] Écran reconnexion avec spinner
- [ ] Reconnexion auto toutes les 5s pendant 60s
- [ ] Snapshot restauré visuellement

---

### Jour 4 — Reconnexion : timeout abandon + AFK

**Story :** 4.4 (partie 4/4)

**Objectif :** Timeout 60s → abandon, gestion AFK, optimisation 2G/3G.

#### Tâches

- [ ] Timer serveur 60s : si joueur pas reconnecté → marquer "ABANDON"
- [ ] Fonction `handleAbandon(gameId, playerId)` :
  - Marquer le joueur abandon
  - Distribuer ses tuiles au talon
  - Continuer la partie sans lui
  - Notifier les autres joueurs
- [ ] Gestion AFK : si inactif pendant son tour → passer automatiquement
- [ ] Optimisations 2G/3G (NFR-06) : heartbeat léger, payloads minifiés
- [ ] Tests timeout + abandon
- [ ] Tests reconnexion après abandon

#### Définition de fait (Jour 4)

- [ ] 60s sans reconnexion → abandon
- [ ] Partie continue sans le joueur abandonné
- [ ] AFK → passage automatique du tour
- [ ] Tests abandon + AFK passent

---

### Jour 5 — Signalement : backend

**Story :** 4.5 (partie 1/2)

**Objectif :** API de signalement avec motifs, seuil d'alerte.

#### Tâches

- [ ] Table Prisma `player_reports` (id, reporterId, reportedId, gameId, reason, description, createdAt)
- [ ] POST /game/report : créer un signalement
- [ ] Motifs : TRICHE_SUSPECTEE, COMPORTEMENT_ABUSIF, COLLUSION, AUTRE
- [ ] Lier le signalement aux game_events de la partie
- [ ] Fonction `checkReportThreshold(reportedId)` : compter signalements en 24h
- [ ] Si ≥ 3 signalements en 24h → alerte admin (email/notification)
- [ ] Endpoint GET /admin/reports : liste signalements (admin)
- [ ] Tests signalement

#### Définition de fait (Jour 5)

- [ ] POST /game/report enregistre le signalement
- [ ] Motifs disponibles (triche, abus, collusion, autre)
- [ ] Seuil 3 signalements/24h → alerte admin
- [ ] Liste admin des signalements

---

### Jour 6 — Signalement : frontend

**Story :** 4.5 (partie 2/2)

**Objectif :** UI signalement depuis le profil joueur.

#### Tâches

- [ ] Ajouter bouton "Signaler" sur le profil d'un joueur (pendant/après partie)
- [ ] Bottom sheet avec liste des motifs
- [ ] Champ texte optionnel pour description
- [ ] Confirmation "Signalement envoyé"
- [ ] Désactiver signalement multiple pour même partie (1 seule fois par partie par joueur)

#### Définition de fait (Jour 6)

- [ ] Bouton "Signaler" accessible depuis profil joueur
- [ ] Sélection motif + description
- [ ] Confirmation envoi
- [ ] Pas de double signalement pour même partie

---

### Jour 7 — Logs replay : backend event sourcing

**Story :** 4.6 (partie 1/2)

**Objectif :** API de replay avec game_events ordonnés.

#### Tâches

- [ ] Endpoint GET /admin/game/:gameId/events : liste des events (id ASC)
- [ ] Structure event : { id, gameId, playerId, actionType, payload, timestamp }
- [ ] Action types : TILE_PLACED, TILE_DRAWN, TURN_PASSED, ROUND_END, GAME_OVER, PLAYER_ABANDON, TIMER_EXPIRED
- [ ] Endpoint GET /admin/game/:gameId/replay : retourner séquence rejouable
- [ ] Pagination des events (100 par page)
- [ ] Filtres par joueur, type d'action, intervalle de temps
- [ ] Tests event sourcing

#### Définition de fait (Jour 7)

- [ ] GET /admin/game/:gameId/events retourne events ordonnés
- [ ] Events paginés (100/page)
- [ ] Filtres fonctionnels
- [ ] Replay retourne séquence complète

---

### Jour 8 — Logs replay : frontend admin

**Story :** 4.6 (partie 2/2)

**Objectif :** Interface admin de replay textuel.

#### Tâches

- [ ] Créer AdminReplayScreen Flutter (ou page web simple)
- [ ] Liste des parties (recherche par gameId, date, joueur)
- [ ] Timeline des events : chaque action avec timestamp + joueur + détail
- [ ] Step-by-step : boutons "Précédent" / "Suivant" pour rejouer
- [ ] Affichage de l'état du plateau à chaque étape
- [ ] Mise en évidence des actions suspectes (signalements liés)

#### Définition de fait (Jour 8)

- [ ] Interface admin de replay fonctionnelle
- [ ] Timeline des events avec détails
- [ ] Navigation step-by-step dans la partie
- [ ] Lien entre signalements et events

---

### Jour 9 — Tests sprint 6

**Objectif :** Tests de toutes les stories du sprint.

#### Tâches

- [ ] Tests reconnexion : snapshot → déconnexion → reconnexion → état identique
- [ ] Tests abandon : timeout 60s → abandon → partie continue
- [ ] Tests signalement : envoi, seuil 3/24h, alerte admin
- [ ] Tests replay : events ordonnés, pagination, filtres
- [ ] Tests d'intégration : joueur signale → admin consulte replay
- [ ] Tests unitaires frontend (ReconnectScreen, ReportDialog, AdminReplayScreen)

#### Définition de fait (Jour 9)

- [ ] `npx vitest run` → tout vert
- [ ] `flutter test` → tout vert
- [ ] Tests reconnexion + abandon OK
- [ ] Tests signalement + replay OK

---

### Jour 10 — Revue + Rétrospective

**Objectif :** Consolider le sprint.

#### Tâches

- [ ] Revue de code
- [ ] Lint (npm run lint + flutter analyze)
- [ ] Checklist définition of done
- [ ] Rétrospective

---

## Définition of Done (Sprint 6)

- [ ] Reconnexion après coupure < 60s avec restauration complète
- [ ] Heartbeat Socket.IO 10s, reconnexion auto toutes les 5s
- [ ] Timeout 60s → joueur abandonné, partie continue
- [ ] AFK → passage automatique du tour
- [ ] Signalement joueur (4 motifs) avec confirmation
- [ ] Seuil 3 signalements/24h → alerte admin
- [ ] Logs de replay admin (events ordonnés par id ASC)
- [ ] Navigation step-by-step dans le replay
- [ ] Optimisations 2G/3G (heartbeat léger, payloads minifiés)
- [ ] Tests passent
- [ ] Lint passe
