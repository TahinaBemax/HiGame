---
sprint_id: "S04"
sprint_duration: "11 jours"
sprint_goal: "Plateau UI, rejoindre partie, résultat avec commission"
stories:
  - "4.2 — Plateau Domino UI + Tour notifications"
  - "3.3 — Rejoindre partie publique + Fusion 30s"
  - "3.4 — Rejoindre partie privée + Annulation"
  - "4.3 — Résultat, Commission 12% & Crédit wallet"
dev_profile: "Junior solo avec IA assistant"
depends_on: "Sprint 3 (dashboard, création partie, moteur Domino)"
---

# Sprint 4 Planning — HiGame MVP

## Objectif du Sprint

**"Un joueur peut rejoindre une partie (publique/privée), jouer sur un plateau interactif, et voir le résultat avec son gain."**

À la fin de ce sprint, le flow suivant est fonctionnel :
1. Un joueur rejoint une partie publique (liste + filtres) ou privée (code 6 caractères)
2. La fusion de salons après 30s d'attente fonctionne
3. Le plateau de jeu s'affiche avec chaîne, main en éventail, timer
4. Les notifications push sont envoyées quand c'est son tour
5. Le résultat de la partie s'affiche avec commission 12% et crédit wallet

---

## Stories du Sprint

| # | Story | FRs | NFRs | UX-DRs | Difficulté | Estimation |
|:-:|-------|:---:|:----:|:------:|:----------:|:----------:|
| S4.1 | Plateau Domino UI + Tour notifications | FR-07, FR-08, FR-11 | NFR-06 | UX-DR-16 | 🟡 Moyen | 3 jours |
| S4.2 | Rejoindre partie publique + Fusion 30s | FR-06, FR-26 | NFR-12 | UX-DR-14, UX-DR-15 | 🟡 Moyen | 2 jours |
| S4.3 | Rejoindre partie privée + Annulation | FR-23, FR-25 | — | UX-DR-14, UX-DR-15 | 🔵 Facile | 2 jours |
| S4.4 | Résultat, Commission 12% & Crédit wallet | FR-09, FR-24 | NFR-11, NFR-24 | UX-DR-17 | 🟡 Moyen | 3 jours |
| | **Tests + Revue + Rétro** | | | | | **1 jour** |
| | **Total** | **7 FRs** | **4 NFRs** | **4 UX-DRs** | | **11 jours** |

---

## Déroulé Jour par Jour

---

### Jour 1 — Plateau UI : layout + chaîne + main

**Story :** 4.2 (partie 1/3)

**Objectif :** Layout du plateau Domino avec chaîne centrale et main en éventail.

#### Tâches

- [ ] Créer GameBoardScreen Flutter
- [ ] Fond #1565C0, barre info (timer + joueur actif + score)
- [ ] Chaîne centrale avec scroll horizontal
- [ ] Doubles affichés perpendiculairement
- [ ] Main du joueur en éventail en bas
- [ ] Tuiles adverses cachées (dos retourné)
- [ ] Widget TileWidget réutilisable (points, rotation)

#### Définition de fait (Jour 1)

- [ ] Plateau visible avec fond bleu
- [ ] Chaîne domino scrollable horizontalement
- [ ] Doubles perpendiculaires
- [ ] Main en éventail en bas
- [ ] Tuiles adverses cachées

---

### Jour 2 — Plateau UI : sélection + pose + pioche

**Story :** 4.2 (partie 2/3)

**Objectif :** Interaction : sélectionner une tuile, poser, piocher.

#### Tâches

- [ ] Tap sur tuile → sélection (soulèvement + ombre)
- [ ] Boutons "Poser" (gauche/droite) quand tuile sélectionnée
- [ ] Envoi de `game:play-tile` via Socket.IO
- [ ] Bouton "Pioche" → envoi `game:draw-tile`
- [ ] Gestion overlay quand ce n'est pas son tour (actions désactivées)
- [ ] Message "Tour de [joueur]" overlay
- [ ] Animation placement tuile (transition fluide vers la chaîne)

#### Définition de fait (Jour 2)

- [ ] Tap tuile → sélection avec effet
- [ ] Boutons Poser (gauche/droite) actifs
- [ ] Pioche fonctionnelle
- [ ] Overlay tour adverse bloque les actions

---

### Jour 3 — Plateau UI : notifications tour + optimisation 2G/3G

**Story :** 4.2 (partie 3/3)

**Objectif :** Notifications push et optimisations réseau.

#### Tâches

- [ ] Notification push locale quand c'est son tour (flutter_local_notifications)
- [ ] Vibration au début du tour
- [ ] Optimisations 2G/3G (NFR-06) : payloads compressés, heartbeat 10s, images compressées
- [ ] Skeleton loader pendant chargement du plateau
- [ ] Tests plateau UI

#### Définition de fait (Jour 3)

- [ ] Notification push au début du tour
- [ ] Vibration fonctionnelle
- [ ] App < 30 MB, heartbeat 10s
- [ ] Skeleton loader affiché pendant chargement

---

### Jour 4 — Rejoindre partie publique : backend

**Story :** 3.3 (partie 1/2)

**Objectif :** Backend liste salons publics, rejoindre, fusion 30s.

#### Tâches

- [ ] GET /game/public : liste salons publics depuis Redis sorted sets
- [ ] Paramètres : filtre par mise, filtre par type (1v1/4j)
- [ ] POST /game/join/:roomId : rejoindre un salon
- [ ] Vérifier capacité (max joueurs selon type)
- [ ] Si salon plein → démarrer la partie automatiquement
- [ ] CRON/timer Redis : après 30s d'attente, proposer fusion aux salons de même mise

#### Définition de fait (Jour 4)

- [ ] GET /game/public retourne salons disponibles
- [ ] POST /game/join/:roomId rejoint le salon
- [ ] Salon plein → démarrage partie
- [ ] Fusion après 30s déclenchée

---

### Jour 5 — Rejoindre partie publique : frontend + fusion

**Story :** 3.3 (partie 2/2)

**Objectif :** Écran rejoindre avec liste, filtres, popup fusion.

#### Tâches

- [ ] Créer JoinPublicScreen Flutter
- [ ] Liste des salons (type, mise, joueurs, temps, bouton Rejoindre)
- [ ] Filtres par mise et type
- [ ] Écran d'attente avec timer "Recherche..." + animation
- [ ] Popup fusion après 30s avec proposition
- [ ] Notification changement de mise après 60s

#### Définition de fait (Jour 5)

- [ ] Liste salons publics avec filtres
- [ ] Rejoindre redirige vers salon d'attente
- [ ] Popup fusion visible après 30s
- [ ] Changement mise proposé après 60s

---

### Jour 6 — Rejoindre partie privée + Annulation : backend

**Story :** 3.4 (partie 1/2)

**Objectif :** Backend salon privé, code 6 caractères, annulation.

#### Tâches

- [ ] POST /game/join/private : rejoindre avec code 6 caractères
- [ ] GET /game/private/:code : vérifier validité du code
- [ ] POST /game/cancel/:roomId : annuler la partie (créateur seulement)
- [ ] POST /game/leave/:roomId : quitter le salon (joueur non-créateur)
- [ ] Notification aux joueurs quand salon annulé
- [ ] Pas de transaction financière si annulé avant le début

#### Définition de fait (Jour 6)

- [ ] Rejoindre privé avec code 6 chars fonctionnel
- [ ] Annulation possible uniquement par le créateur
- [ ] Quitter salon libère la place
- [ ] Aucune transaction si annulé avant début

---

### Jour 7 — Rejoindre partie privée + Annulation : frontend

**Story :** 3.4 (partie 2/2)

**Objectif :** Écran rejoindre privé, salon d'attente, bouton annulation.

#### Tâches

- [ ] Créer JoinPrivateScreen Flutter (input code 6 chars)
- [ ] Create WaitingRoomScreen Flutter
- [ ] Avatars + pseudos des joueurs, places vides silhouettées
- [ ] Code privé affiché + bouton "Partager le code"
- [ ] Bouton "Annuler la partie" (visible créateur seulement)
- [ ] Bouton "Quitter" (visible autres joueurs)
- [ ] Timer d'attente avec temps écoulé

#### Définition de fait (Jour 7)

- [ ] Input code 6 chars + validation
- [ ] Salon d'attente avec avatars
- [ ] Annulation notifie tous les joueurs
- [ ] Quitter libère la place

---

### Jour 8 — Résultat : backend commission + crédit

**Story :** 4.3 (partie 1/2)

**Objectif :** Calcul résultat, commission 12%, crédit wallet.

#### Tâches

- [ ] Endpoint POST /game/result/:gameId : calculer le résultat
- [ ] Calcul pool total = somme des mises
- [ ] Commission 12% prélevée sur le pool
- [ ] Gain net = pool × 0.88 pour le gagnant (1v1) ou répartition (4j)
- [ ] Créditer le wallet du gagnant via optimistic locking (colonne version)
- [ ] Notification push "Gain de X Ar crédité" (FR-24)
- [ ] Endpoint GET /game/result/:gameId : récupérer le résultat
- [ ] Enregistrer la transaction dans `wallet_transactions`

#### Définition de fait (Jour 8)

- [ ] Calcul pool + commission 12% correct
- [ ] Gain net crédité via optimistic locking
- [ ] Notification push envoyée
- [ ] Transaction enregistrée dans wallet_transactions

---

### Jour 9 — Résultat : frontend écran + confettis + revanche

**Story :** 4.3 (partie 2/2)

**Objectif :** Écran résultat avec animations et bouton revanche.

#### Tâches

- [ ] Créer GameResultScreen Flutter
- [ ] Trophée si victoire, avatar gagnant 80px
- [ ] Gain affiché en #00BFA5 large
- [ ] Tableau scores (joueur, points, résultat)
- [ ] Expandable : tuiles restantes de chaque joueur
- [ ] Animation confettis si victoire
- [ ] Bouton "Revanche !" → recrée partie identique
- [ ] Bouton "Retour au lobby"
- [ ] Tests résultat

#### Définition de fait (Jour 9)

- [ ] Écran résultat avec scores et gain
- [ ] Confettis animation si victoire
- [ ] Revanche recrée une partie identique
- [ ] Tuiles restantes visibles en expandable

---

### Jour 10 — Tests intégration parcours complet

**Objectif :** Tester tout le parcours de jeu.

#### Tâches

- [ ] Test parcours : créer partie → rejoindre → plateau → résultat
- [ ] Test parcours : rejoindre public avec fusion 30s
- [ ] Test parcours : rejoindre privé avec code + annulation
- [ ] Test commission 12% sur le gain
- [ ] Test crédit wallet après victoire
- [ ] Test notification tour
- [ ] Tests unitaires des 4 stories

#### Définition de fait (Jour 10)

- [ ] `npx vitest run` → tout vert
- [ ] `flutter test` → tout vert
- [ ] Parcours complet testé de bout en bout

---

### Jour 11 — Revue + Rétrospective

**Objectif :** Consolider le sprint.

#### Tâches

- [ ] Revue de code
- [ ] Lint (npm run lint + flutter analyze)
- [ ] Checklist définition of done
- [ ] Rétrospective

---

## Définition of Done (Sprint 4)

- [ ] Plateau Domino UI complet (chaîne, main, timer, overlay)
- [ ] Pose de tuile, pioche, passage de tour fonctionnels
- [ ] Notification push + vibration au début du tour
- [ ] Rejoindre partie publique (liste + filtres + fusion 30s)
- [ ] Rejoindre partie privée (code 6 chars + annulation)
- [ ] Résultat avec commission 12% et crédit wallet
- [ ] Confettis animation + bouton revanche
- [ ] Tests passent
- [ ] Lint passe
- [ ] Aucune régression
