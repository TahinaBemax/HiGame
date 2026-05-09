---
sprint_id: "S05"
sprint_duration: "12 jours"
sprint_goal: "Dépôt MVola, solde temps réel, retrait et limites"
stories:
  - "2.1 — Dépôt MVola via PaidMada"
  - "2.2 — Solde wallet temps réel"
  - "2.3 — Retrait des gains"
  - "2.4 — Limites de dépôt"
dev_profile: "Junior solo avec IA assistant"
depends_on: "Sprint 4 (plateau, rejoindre, résultat)"
---

# Sprint 5 Planning — HiGame MVP

## Objectif du Sprint

**"Un joueur peut déposer de l'argent depuis MVola, voir son solde en temps réel, retirer ses gains et configurer ses limites de dépôt."**

À la fin de ce sprint, le flow suivant est fonctionnel :
1. L'utilisateur dépose depuis MVola via PaidMada (1 000 - 200 000 Ar)
2. Le solde wallet se met à jour en temps réel (< 5s)
3. L'utilisateur retire ses gains (2 000 - 500 000 Ar)
4. L'utilisateur configure ses limites (journalière, hebdo, mensuelle, auto-exclusion)
5. L'idempotence empêche les doubles crédits

---

## Stories du Sprint

| # | Story | FRs | NFRs | UX-DRs | Difficulté | Estimation |
|:-:|-------|:---:|:----:|:------:|:----------:|:----------:|
| S5.1 | Dépôt MVola via PaidMada | FR-03 | NFR-03, NFR-15 | UX-DR-12 | 🔴 Complexe | 4 jours |
| S5.2 | Solde wallet temps réel | FR-04 | NFR-24 | UX-DR-12 | 🟡 Moyen | 2 jours |
| S5.3 | Retrait des gains | FR-10 | NFR-19, NFR-21 | UX-DR-12 | 🟡 Moyen | 3 jours |
| S5.4 | Limites de dépôt | FR-15 | NFR-22 | UX-DR-19 | 🔵 Facile | 2 jours |
| | **Tests + Revue + Rétro** | | | | | **1 jour** |
| | **Total** | **4 FRs** | **6 NFRs** | **2 UX-DRs** | | **12 jours** |

---

## Déroulé Jour par Jour

---

### Jour 1 — Dépôt MVola : module payment backend

**Story :** 2.1 (partie 1/4)

**Objectif :** Structure du module payment, intégration PaidMada.

#### Tâches

- [ ] Créer module `payment` backend (routes, controller, service, schema)
- [ ] POST /payment/deposit : initier un dépôt
- [ ] Générer correlationId unique (uuid v4)
- [ ] POST /payment/webhook/paidmada : recevoir callback PaidMada
- [ ] Stocker tentative de dépôt dans `wallet_transactions` (statut PENDING)
- [ ] Validation montant (min 1 000 Ar, max 200 000 Ar)
- [ ] Minuteur 2 min pour la transaction

#### Définition de fait (Jour 1)

- [ ] POST /payment/deposit créé avec correlationId
- [ ] Webhook PaidMada reçoit les callbacks
- [ ] Transaction stockée avec statut PENDING
- [ ] Montant validé (1 000 - 200 000 Ar)

---

### Jour 2 — Dépôt MVola : idempotence + optimistic locking

**Story :** 2.1 (partie 2/4)

**Objectif :** Garantir l'intégrité financière via idempotence et optimistic locking.

#### Tâches

- [ ] Redis lock sur correlationId avant traitement (TTL 5 min)
- [ ] Table `idempotency_keys` : stocker les correlationId traités
- [ ] Vérifier idempotence : si correlationId déjà traité → retourner succès sans doubler
- [ ] Optimistic locking wallet : `UPDATE wallets SET balance = ?, version = version + 1 WHERE id = ? AND version = ?`
- [ ] Si version mismatch → retry (max 3 tentatives)
- [ ] Gestion timeout 2 min : marquer transaction ÉCHOUÉ si pas de callback
- [ ] Tests idempotence (même correlationId soumis 2x)

#### Définition de fait (Jour 2)

- [ ] Double soumission correlationId → pas de double crédit
- [ ] Optimistic locking échoue et retry si conflit
- [ ] Timeout 2 min → statut ÉCHOUÉ

---

### Jour 3 — Dépôt MVola : frontend

**Story :** 2.1 (partie 3/4)

**Objectif :** Écran dépôt MVola avec sélection montant et statuts.

#### Tâches

- [ ] Créer DepositScreen Flutter
- [ ] Wallet card gradient (#1565C0→#0D47A1) avec solde
- [ ] Sélecteur de montant (quick picks : 1 000, 5 000, 10 000, 25 000, 50 000, 100 000, 200 000)
- [ ] Input personnalisé pour montant custom
- [ ] Validation min/max
- [ ] Bouton "Déposer" → appel POST /payment/deposit
- [ ] Écran de statut (En cours → Succès/Échoué)
- [ ] Compte à rebours 2 min

#### Définition de fait (Jour 3)

- [ ] Écran dépôt avec quick picks + custom input
- [ ] Validation montant (1 000 - 200 000 Ar)
- [ ] Statut transaction affiché en temps réel
- [ ] Timer 2 min visible

---

### Jour 4 — Dépôt MVola : tests + webhook simulation

**Story :** 2.1 (partie 4/4)

**Objectif :** Tester le dépôt complet, simuler callback PaidMada.

#### Tâches

- [ ] Script de simulation callback PaidMada
- [ ] Test dépôt → callback → crédit wallet
- [ ] Test dépôt → timeout → échec
- [ ] Test double correlationId → pas de double crédit
- [ ] Test optimistic locking contention
- [ ] Tests unitaires et d'intégration

#### Définition de fait (Jour 4)

- [ ] Tests dépôt complets passent
- [ ] Simulation callback PaidMada fonctionnelle
- [ ] Idempotence vérifiée
- [ ] Timeout 2 min testé

---

### Jour 5 — Solde wallet : backend temps réel

**Story :** 2.2 (partie 1/2)

**Objectif :** Endpoint solde et mise à jour temps réel via Socket.IO.

#### Tâches

- [ ] GET /wallet/balance : retourner solde + version (pour optimistic locking)
- [ ] GET /wallet/transactions : historique 10 dernières transactions
- [ ] Socket.IO event `wallet:balance-updated` émis à chaque changement
- [ ] Formater solde "Ar XX XXX"
- [ ] Cache Redis du solde (pour accès rapide)
- [ ] Tests solde

#### Définition de fait (Jour 5)

- [ ] GET /wallet/balance retourne solde + version
- [ ] Événement Socket.IO wallet:balance-updated émis
- [ ] Redis cache du solde

---

### Jour 6 — Solde wallet : frontend + cache Hive offline

**Story :** 2.2 (partie 2/2)

**Objectif :** UI wallet, cache Hive, mode offline.

#### Tâches

- [ ] Créer/améliorer WalletScreen Flutter
- [ ] Wallet card avec gradient, solde large (Monetary 20px Bold)
- [ ] Boutons "Déposer" / "Retirer"
- [ ] Dernières 10 transactions avec statuts (Succès/En cours/Échoué)
- [ ] Cache Hive du solde (dernière valeur connue)
- [ ] Affichage "Hors connexion" si cache > 5 min
- [ ] Mise à jour temps réel via Socket.IO listener

#### Définition de fait (Jour 6)

- [ ] Wallet card visible avec solde
- [ ] Historique 10 dernières transactions
- [ ] Cache Hive fonctionnel offline
- [ ] Message "Hors connexion" si cache vieux > 5min

---

### Jour 7 — Retrait : backend

**Story :** 2.3 (partie 1/2)

**Objectif :** API de retrait, statuts, validation admin.

#### Tâches

- [ ] POST /payment/withdraw : créer demande de retrait
- [ ] Validation solde suffisant (min 2 000 Ar, max 500 000 Ar)
- [ ] Statuts : PENDING → APPROVED/REJECTED
- [ ] PUT /payment/withdraw/:id/approve (admin)
- [ ] PUT /payment/withdraw/:id/reject (admin) + motif
- [ ] Si rejet : remettre montant sur le wallet
- [ ] Alerte admin si délai > 24h
- [ ] Notification push au joueur (succès/échec)

#### Définition de fait (Jour 7)

- [ ] POST /payment/withdraw crée demande
- [ ] Validation solde + min/max
- [ ] Approbation/rejet admin fonctionnel
- [ ] Remise wallet si rejet
- [ ] Alerte 24h

---

### Jour 8 — Retrait : frontend

**Story :** 2.3 (partie 2/2)

**Objectif :** Écran retrait avec sélection montant et suivi.

#### Tâches

- [ ] Créer WithdrawScreen Flutter
- [ ] Sélecteur montant (quick picks et custom)
- [ ] Validation solde disponible
- [ ] Affichage statut demande (En cours/Succès/Échoué)
- [ ] Historique des retraits
- [ ] Message si en attente de validation admin
- [ ] Tests retrait

#### Définition de fait (Jour 8)

- [ ] Écran retrait avec validation solde
- [ ] Statut demande visible
- [ ] Historique retraits affiché
- [ ] Message clair si en attente admin

---

### Jour 9 — Limites dépôt : backend

**Story :** 2.4 (partie 1/2)

**Objectif :** API des limites de dépôt (journalière, hebdo, mensuelle, auto-exclusion).

#### Tâches

- [ ] Table `deposit_limits` (userId, type DAILY/WEEKLY/MONTHLY, amount, autoExclusionUntil)
- [ ] GET /wallet/limits : retourner limites actuelles
- [ ] PUT /wallet/limits : modifier limites
- [ ] Middleware vérification limite avant chaque dépôt
- [ ] Calcul montant déjà déposé sur la période
- [ ] Auto-exclusion : bloquer dépôts pour X temps
- [ ] Tests limites

#### Définition de fait (Jour 9)

- [ ] Limites persistées en base
- [ ] Vérification avant dépôt (refus si limite atteinte)
- [ ] Auto-exclusion fonctionnelle

---

### Jour 10 — Limites dépôt : frontend

**Story :** 2.4 (partie 2/2)

**Objectif :** UI paramètres limites avec toggles et inputs.

#### Tâches

- [ ] Ajouter section "Limites de jeu" dans l'écran Paramètres
- [ ] Inputs pour limite journalière, hebdomadaire, mensuelle
- [ ] Toggle activation/désactivation par limite
- [ ] Section auto-exclusion : sélecteur durée (24h/7j/30j)
- [ ] Message confirmation "Limite mise à jour"
- [ ] Message blocage "Limite journalière atteinte" sur dépôt

#### Définition de fait (Jour 10)

- [ ] Limites configurables depuis paramètres
- [ ] Auto-exclusion avec durée sélectionnable
- [ ] Blocage dépôt si limite atteinte

---

### Jour 11 — Tests wallet complet

**Objectif :** Tester tout le module wallet (dépôt, solde, retrait, limites).

#### Tâches

- [ ] Tests unitaires backend (payment service, limites, optimistic locking)
- [ ] Tests unitaires frontend (DepositScreen, WithdrawScreen, WalletScreen)
- [ ] Tests d'intégration : dépôt → webhook → crédit → solde
- [ ] Tests d'intégration : retrait → approbation admin → notification
- [ ] Tests limites : dépôt refusé si limite atteinte
- [ ] Tests auto-exclusion

#### Définition de fait (Jour 11)

- [ ] `npx vitest run` → tout vert
- [ ] `flutter test` → tout vert
- [ ] Parcours wallet complet testé

---

### Jour 12 — Revue + Rétrospective

**Objectif :** Consolider le sprint.

#### Tâches

- [ ] Revue de code
- [ ] Lint (npm run lint + flutter analyze)
- [ ] Checklist définition of done
- [ ] Rétrospective

---

## Définition of Done (Sprint 5)

- [ ] Dépôt MVola via PaidMada (1 000 - 200 000 Ar)
- [ ] Idempotence des transactions (Redis lock + idempotency_keys)
- [ ] Optimistic locking wallet (colonne version)
- [ ] Solde temps réel < 5s via Socket.IO
- [ ] Cache Hive offline du solde
- [ ] Retrait gains (2 000 - 500 000 Ar) avec validation admin
- [ ] Notification push crédit/débit wallet
- [ ] Limites dépôt configurables (journalière, hebdo, mensuelle)
- [ ] Auto-exclusion (24h/7j/30j)
- [ ] Tests passent
- [ ] Lint passe
