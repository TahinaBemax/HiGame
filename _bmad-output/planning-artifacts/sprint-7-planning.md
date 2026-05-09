---
sprint_id: "S07"
sprint_duration: "11 jours"
sprint_goal: "Profil, paramètres et historique des parties"
stories:
  - "5.1 — Profil + Statistiques"
  - "5.2 — Paramètres"
  - "5.3 — Historique parties + Filtres"
dev_profile: "Junior solo avec IA assistant"
depends_on: "Sprint 6 (reconnexion, signalement, logs admin)"
---

# Sprint 7 Planning — HiGame MVP

## Objectif du Sprint

**"Un joueur consulte son profil et ses stats, configure ses paramètres, et explore l'historique de ses parties avec filtres."**

À la fin de ce sprint, le flow suivant est fonctionnel :
1. L'utilisateur voit son profil (avatar, pseudo, KYC, statistiques)
2. Il modifie son avatar et pseudo (1 changement/30 jours)
3. Il configure notifications, limites, langue, sécurité
4. Il parcourt son historique avec filtres et scroll infini
5. Il consulte le replay textuel détaillé d'une partie

---

## Stories du Sprint

| # | Story | FRs | UX-DRs | Difficulté | Estimation |
|:-:|-------|:---:|:------:|:----------:|:----------:|
| S7.1 | Profil + Statistiques | — | UX-DR-18 | 🟡 Moyen | 3 jours |
| S7.2 | Paramètres (notifications, limites, sécurité) | — | UX-DR-19 | 🟡 Moyen | 3 jours |
| S7.3 | Historique parties + Filtres | FR-13 | UX-DR-21 | 🟡 Moyen | 4 jours |
| | **Tests + Revue + Rétro** | | | | **1 jour** |
| | **Total** | **1 FR** | **3 UX-DRs** | | **11 jours** |

---

## Déroulé Jour par Jour

---

### Jour 1 — Profil : backend

**Story :** 5.1 (partie 1/2)

**Objectif :** API profil et statistiques.

#### Tâches

- [ ] GET /profile/:userId : retourner profil complet
- [ ] Calculer statistiques : parties jouées, victoires, défaites, winrate, gains totaux, pertes
- [ ] PUT /profile/avatar : upload nouvel avatar
- [ ] PUT /profile/pseudo : modifier pseudo (vérifier délai 30 jours)
- [ ] Vérification : 1 changement pseudo tous les 30 jours
- [ ] Endpoint GET /profile/stats : statistiques agrégées

#### Définition de fait (Jour 1)

- [ ] GET /profile/:userId retourne profil + stats
- [ ] Avatar upload fonctionnel
- [ ] Pseudo modifiable avec vérification délai 30j

---

### Jour 2 — Profil : frontend

**Story :** 5.1 (partie 2/2)

**Objectif :** Écran profil avec avatar, stats, actions.

#### Tâches

- [ ] Créer ProfileScreen Flutter (UX-DR-18)
- [ ] Avatar circulaire 56px (modifiable : camera/gallery)
- [ ] Pseudo avec icône d'édition (1 changement/30 jours)
- [ ] Statut KYC (badge vérifié/attente/rejeté)
- [ ] Cartes statistiques : parties, victoires, défaites, winrate, gains, pertes
- [ ] Boutons : Historique, Paramètres, Règles, Aide, Déconnexion

#### Définition de fait (Jour 2)

- [ ] Profil complet affiché (avatar, pseudo, stats, KYC)
- [ ] Modification avatar fonctionnelle
- [ ] Pseudo éditable avec limite 30j
- [ ] Boutons de navigation présents

---

### Jour 3 — Paramètres : backend

**Story :** 5.2 (partie 1/2)

**Objectif :** API paramètres utilisateur.

#### Tâches

- [ ] Table Prisma `user_settings` (userId, pushEnabled, soundEnabled, vibrationEnabled, language, sessions JSON)
- [ ] GET /settings : retourner paramètres actuels
- [ ] PUT /settings : mettre à jour paramètres
- [ ] PUT /settings/delete-account : demander suppression (délai 7 jours)
- [ ] GET /settings/sessions : liste des sessions actives
- [ ] DELETE /settings/sessions/:id : déconnecter session distante
- [ ] Tests paramètres

#### Définition de fait (Jour 3)

- [ ] Paramètres persistés en base
- [ ] Sessions actives listées
- [ ] Déconnexion distante fonctionnelle
- [ ] Demande suppression compte avec délai 7j

---

### Jour 4 — Paramètres : frontend

**Story :** 5.2 (partie 2/2)

**Objectif :** Écran paramètres complet avec toutes les sections.

#### Tâches

- [ ] Créer SettingsScreen Flutter (UX-DR-19)
- [ ] Section Compte : pseudo, avatar, KYC (redirection)
- [ ] Section Notifications : toggles push, son, vibration
- [ ] Section Limites jeu : redirection vers limites dépôt
- [ ] Section Affichage : sélecteur langue (français/malgache)
- [ ] Section Sécurité : liste sessions actives + bouton déconnexion
- [ ] Section Suppression compte : confirmation + délai 7 jours

#### Définition de fait (Jour 4)

- [ ] Toutes les sections paramètres visibles
- [ ] Toggles notifications fonctionnels
- [ ] Changement langue fonctionnel
- [ ] Sessions listées avec déconnexion distante
- [ ] Suppression compte avec confirmation

---

### Jour 5 — Historique : backend pagination + filtres

**Story :** 5.3 (partie 1/3)

**Objectif :** API historique avec pagination et filtres.

#### Tâches

- [ ] GET /history : historique parties du joueur (paginated)
- [ ] Paramètres : page, limit (20), filter (ALL/WINS/LOSSES)
- [ ] Retourner : date, type (1v1/4j), mise, résultat (gain/perte), durée, gameId
- [ ] GET /history/:gameId : replay textuel détaillé de la partie
- [ ] Reconstruire le replay depuis game_events
- [ ] Calcul durée partie
- [ ] Tests historique

#### Définition de fait (Jour 5)

- [ ] GET /history retourne parties paginées (20/page)
- [ ] Filtres ALL/WINS/LOSSES fonctionnels
- [ ] GET /history/:gameId retourne replay textuel
- [ ] Durée partie calculée

---

### Jour 6 — Historique : frontend liste + scroll infini

**Story :** 5.3 (partie 2/3)

**Objectif :** UI historique avec liste chronologique et scroll infini.

#### Tâches

- [ ] Créer HistoryScreen Flutter (UX-DR-21)
- [ ] Liste chronologique inverse (20 parties)
- [ ] Chaque ligne : date, type, mise, résultat (gain/perte en couleur), durée
- [ ] Badge vert pour victoires, rouge pour défaites
- [ ] Scroll infini : chargement automatique 20 parties supplémentaires
- [ ] Skeleton loader pendant chargement
- [ ] Pull-to-refresh

#### Définition de fait (Jour 6)

- [ ] Liste historique visible
- [ ] Scroll infini fonctionnel (charge 20 par 20)
- [ ] Couleurs gain/perte distinctes
- [ ] Pull-to-refresh + skeleton loader

---

### Jour 7 — Historique : frontend replay textuel + filtres

**Story :** 5.3 (partie 3/3)

**Objectif :** Filtres et replay textuel détaillé.

#### Tâches

- [ ] Filtres : toutes / victoires / défaites (tabs)
- [ ] Tap sur une partie → écran détail replay
- [ ] Replay textuel : chronologie des coups avec numéro de manche
- [ ] Détail par manche : scores, tuiles posées, pioches
- [ ] Résumé final : gagnant, gain, durée
- [ ] Animation de transition vers le replay
- [ ] Tests historique

#### Définition de fait (Jour 7)

- [ ] Filtres victoires/défaites fonctionnels
- [ ] Replay textuel complet avec coups par manche
- [ ] Navigation vers détail partie

---

### Jour 8 — Tests profil + paramètres

**Objectif :** Tests des stories 5.1 et 5.2.

#### Tâches

- [ ] Tests unitaires backend (profile service, settings service)
- [ ] Tests unitaires frontend (ProfileScreen, SettingsScreen)
- [ ] Tests modification avatar
- [ ] Tests limite pseudo 30 jours
- [ ] Tests toggles notifications
- [ ] Tests déconnexion session distante
- [ ] Tests suppression compte

#### Définition de fait (Jour 8)

- [ ] Tests profil passent
- [ ] Tests paramètres passent

---

### Jour 9 — Tests historique

**Objectif :** Tests de la story 5.3.

#### Tâches

- [ ] Tests unitaires backend (history service, pagination, filtres)
- [ ] Tests unitaires frontend (HistoryScreen, ReplayScreen)
- [ ] Tests pagination (20 parties, scroll infini)
- [ ] Tests filtres (ALL/WINS/LOSSES)
- [ ] Tests replay textuel

#### Définition de fait (Jour 9)

- [ ] Tests historique passent
- [ ] Tests scroll infini OK

---

### Jour 10 — Tests intégration

**Objectif :** Tests de parcours complet et revue.

#### Tâches

- [ ] Tests d'intégration : profil → paramètres → historique
- [ ] Tests de non-régression sur tous les sprints précédents
- [ ] `npx vitest run` → tout vert
- [ ] `flutter test` → tout vert

#### Définition de fait (Jour 10)

- [ ] Tous les tests passent
- [ ] Aucune régression

---

### Jour 11 — Revue + Rétrospective

**Objectif :** Consolider le sprint, préparer Sprint 8.

#### Tâches

- [ ] Revue de code
- [ ] Lint (npm run lint + flutter analyze)
- [ ] Checklist définition of done
- [ ] Rétrospective

---

## Définition of Done (Sprint 7)

- [ ] Profil affiché avec avatar, pseudo, statistiques, statut KYC
- [ ] Modification avatar (camera/gallery)
- [ ] Pseudo modifiable (1 changement/30 jours)
- [ ] Paramètres : notifications (push/son/vibration)
- [ ] Paramètres : affichage (langue français/malgache)
- [ ] Paramètres : sécurité (sessions actives, déconnexion distante)
- [ ] Paramètres : suppression compte avec délai 7 jours
- [ ] Historique paginé (20 parties, scroll infini)
- [ ] Filtres (toutes/victoires/défaites)
- [ ] Replay textuel détaillé par partie
- [ ] Tests passent
- [ ] Lint passe
