---
sprint_id: "S08"
sprint_duration: "11 jours"
sprint_goal: "CI/CD automatisé, build APK et déploiement final"
stories:
  - "6.2 — GitHub Actions CI"
  - "6.3 — Build APK automatisé"
dev_profile: "Junior solo avec IA assistant"
depends_on: "Sprint 7 (profil, paramètres, historique)"
---

# Sprint 8 Planning — HiGame MVP

## Objectif du Sprint

**"La plateforme est livrée : CI verte sur chaque push, APK buildé automatiquement sur tag, déploiement VPS prêt."**

À la fin de ce sprint :
1. GitHub Actions CI exécute lint + test + build backend sur chaque push
2. GitHub Actions exécute `flutter analyze` + `flutter test` sur le frontend
3. Un tag git v* déclenche le build APK automatisé
4. L'APK signé est disponible en artifact GitHub
5. Docker Compose déploie le backend sur VPS (ou production-ready)
6. Tests E2E finaux valident le MVP complet

---

## Stories du Sprint

| # | Story | ARs | Difficulté | Estimation |
|:-:|-------|:---:|:----------:|:----------:|
| S8.1 | GitHub Actions CI (lint, test, build backend + frontend) | AR-07 | 🟡 Moyen | 4 jours |
| S8.2 | Build APK automatisé | AR-08 | 🟡 Moyen | 3 jours |
| S8.3 | Déploiement VPS + tests finaux MVP | AR-06 | 🟡 Moyen | 3 jours |
| | **Revue + Rétro + Livraison** | | | **1 jour** |
| | **Total** | **3 ARs** | | **11 jours** |

---

## Déroulé Jour par Jour

---

### Jour 1 — CI backend : workflow GitHub Actions

**Story :** 6.2 (partie 1/2)

**Objectif :** Pipeline CI backend avec lint, test, build.

#### Tâches

- [ ] Créer `.github/workflows/ci-backend.yml`
- [ ] Déclencheurs : push sur main, pull request
- [ ] Job `ci-backend` :
  - Checkout code
  - Setup Node.js 22
  - `npm ci` dans packages/backend
  - `npx lint` (ESLint)
  - `npx tsc --noEmit` (type check)
  - `npx vitest run` (tests)
  - `npm run build` (compilation TypeScript)
- [ ] Caching node_modules pour accélérer les runs
- [ ] Test : pousser un commit → vérifier que le pipeline se lance

#### Commandes

```bash
mkdir -p .github/workflows
# Fichier workflow backend
touch .github/workflows/ci-backend.yml
# Tester le lint local
cd packages/backend && npm run lint
```

#### Définition de fait (Jour 1)

- [ ] GitHub Actions CI backend s'exécute sur push
- [ ] Lint + tsc + tests + build passent
- [ ] Cache node_modules actif
- [ ] Pipeline rouge si erreur de lint

---

### Jour 2 — CI frontend : flutter analyze + test

**Story :** 6.2 (partie 2/2)

**Objectif :** Pipeline CI frontend avec flutter analyze et flutter test.

#### Tâches

- [ ] Créer `.github/workflows/ci-frontend.yml`
- [ ] Job `ci-frontend` :
  - Checkout code
  - Setup Flutter (stable)
  - `flutter pub get`
  - `flutter analyze` (0 warnings)
  - `flutter test` (tests unitaires + widget)
  - Cache Flutter/pub
- [ ] Paralléliser : les jobs backend et frontend tournent en parallèle
- [ ] Badge "CI passing" dans le README (optionnel)
- [ ] Test : pousser un commit → vérifier analyse + tests Flutter

#### Définition de fait (Jour 2)

- [ ] CI frontend s'exécute en parallèle du backend
- [ ] flutter analyze → 0 warnings
- [ ] flutter test → tout vert

---

### Jour 3 — Build APK : GitHub Actions

**Story :** 6.3 (partie 1/2)

**Objectif :** Workflow de build APK automatisé sur tag v*.

#### Tâches

- [ ] Créer `.github/workflows/build-apk.yml`
- [ ] Déclencheur : push tag v* (ex: v1.0.0-beta)
- [ ] Job `build-apk` :
  - Checkout code
  - Setup Java 17 + Flutter
  - `flutter pub get`
  - `flutter build apk --release`
  - Upload APK en artifact (actions/upload-artifact)
- [ ] Configurer `android/key.properties` via GitHub Secrets
- [ ] Keystore signé : générer + stocker en secret
- [ ] VersionName = tag git dans build.gradle

#### Commandes

```bash
# Générer keystore pour signature
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
# Base64 keystore pour GitHub Secrets
base64 upload-keystore.jks
```

#### Définition de fait (Jour 3)

- [ ] Workflow build-apk créé
- [ ] Déclenché sur tag v*
- [ ] APK signé généré et uploadé en artifact

---

### Jour 4 — Build APK : signature + distribution

**Story :** 6.3 (partie 2/2)

**Objectif :** Signature APK, test installation, distribution.

#### Tâches

- [ ] Configurer `android/app/build.gradle` avec signingConfigs release
- [ ] Ajouter GitHub Secrets : KEYSTORE_BASE64, KEY_ALIAS, KEY_PASSWORD, STORE_PASSWORD
- [ ] Script de décodage du keystore dans le workflow
- [ ] Version APK = nom du tag git
- [ ] Upload APK dans les release GitHub (actions/create-release)
- [ ] Tester : créer tag v1.0.0-beta.1 → build APK → télécharger → installer sur émulateur
- [ ] Vérifier version affichée dans l'app = tag git

#### Définition de fait (Jour 4)

- [ ] APK signé correctement
- [ ] Installation sur Android 8+ fonctionnelle
- [ ] Version affichée = tag git
- [ ] APK disponible dans GitHub Release

---

### Jour 5 — Déploiement : Docker Compose production

**Objectif :** Docker Compose prêt pour déploiement VPS.

#### Tâches

- [ ] Vérifier Dockerfile et docker-compose.yml (créés Sprint 1)
- [ ] Ajouter healthchecks si manquants
- [ ] Configurer les limites de ressources (mem_limit, cpus)
- [ ] Ajouter service PostgreSQL + Redis (déjà présents)
- [ ] Variables d'environnement : .env.production template
- [ ] Script `deploy.sh` : git pull → docker compose up -d --build
- [ ] Logs : configuration rotation (max 10MB, 3 fichiers)
- [ ] Backup PostgreSQL : script pg_dump quotidien

#### Définition de fait (Jour 5)

- [ ] docker-compose.yml production-ready
- [ ] deploy.sh script fonctionnel
- [ ] Log rotation configurée
- [ ] Backup DB script prêt

---

### Jour 6 — Tests E2E MVP : backend

**Objectif :** Tests de non-régression et validation complète du backend.

#### Tâches

- [ ] Lancer tous les tests backend : `npx vitest run`
- [ ] Tester tous les endpoints API manuellement (ou via collection Postman/Insomnia)
- [ ] Vérifier WebSocket/Socket.IO fonctionnel
- [ ] Vérifier Redis sorted sets matching
- [ ] Tester le parcours complet API :
  - Inscription OTP → KYC → Dashboard → Créer partie → Rejoindre → Jouer → Résultat → Wallet
- [ ] Vérifier les optimistic locking wallet
- [ ] Vérifier idempotence
- [ ] Vérifier rate limiting

#### Définition de fait (Jour 6)

- [ ] Tous les tests backend passent
- [ ] Parcours API complet validé
- [ ] Socket.IO fonctionnel
- [ ] Wallet + idempotence OK

---

### Jour 7 — Tests E2E MVP : frontend

**Objectif :** Validation complète du frontend Flutter.

#### Tâches

- [ ] Lancer tous les tests Flutter : `flutter test`
- [ ] Lancer `flutter analyze` → 0 erreurs
- [ ] Build APK de test : `flutter build apk --debug`
- [ ] Installer sur émulateur Android
- [ ] Tester parcours complet utilisateur :
  - Splash → Onboarding → Inscription → KYC → Dashboard
  - Créer partie → Attendre → Plateau → Jouer → Résultat
  - Wallet (dépôt, solde, retrait, limites)
  - Profil → Paramètres → Historique
  - Reconnexion
- [ ] Vérifier cache Hive offline
- [ ] Vérifier notifications push

#### Définition de fait (Jour 7)

- [ ] flutter test → tout vert
- [ ] flutter analyze → 0 erreurs
- [ ] APK installé et fonctionnel sur émulateur
- [ ] Parcours complet utilisateur validé

---

### Jour 8 — Déploiement VPS

**Objectif :** Déploiement sur VPS de production.

#### Tâches

- [ ] Préparer VPS (Ubuntu 22.04, Docker, Docker Compose)
- [ ] Configurer firewall (ports 3000, 5432, 6379 internes)
- [ ] Copier .env.production avec vraies clés
- [ ] Lancer `docker compose up -d` sur le VPS (ou serveur de prod)
- [ ] Configurer Nginx reverse proxy (ou Caddy pour SSL auto)
- [ ] SSL/TLS 1.3 (Let's Encrypt via Caddy/Nginx)
- [ ] Vérifier `curl https://api.higame.mg/health` → 200
- [ ] Vérifier que Flutter app (APK) communique avec le backend
- [ ] Tests de charge légers : 10-20 connexions simultanées

#### Définition de fait (Jour 8)

- [ ] VPS déployé avec Docker Compose
- [ ] HTTPS actif (TLS 1.3)
- [ ] API accessible publiquement
- [ ] APK communique avec le backend

---

### Jour 9 — Tests finaux + bug fixes

**Objectif :** Dernière vague de tests, correction des bugs résiduels.

#### Tâches

- [ ] Tests de régression complets
- [ ] Vérifier tous les FRs du PRD sont couverts
- [ ] Vérifier toutes les NFRs (performance, sécurité, limites)
- [ ] Vérifier tous les UX-DRs sont implémentés
- [ ] Corriger les bugs mineurs
- [ ] Vérifier les logs serveur (pas d'erreur, pas de crash)
- [ ] Vérifier les perfs : temps de réponse < 500ms pour les endpoints critiques

#### Définition de fait (Jour 9)

- [ ] Tous les FRs du PRD couverts
- [ ] Pas de crash connu
- [ ] Temps de réponse OK
- [ ] Logs propres

---

### Jour 10 — Documentation finale

**Objectif :** Documentation projet complète.

#### Tâches

- [ ] README.md racine : description, stack, prérequis, démarrage rapide
- [ ] README.md backend : API endpoints, variables d'environnement
- [ ] README.md frontend : structure, commandes, build APK
- [ ] `.env.example` complet avec toutes les variables
- [ ] Scripts utiles : `deploy.sh`, `backup-db.sh`, `seed-data.sh`
- [ ] Note de version (v1.0.0-beta) : fonctionnalités, connues, prochaines étapes

#### Définition de fait (Jour 10)

- [ ] READMEs complets et à jour
- [ ] Scripts de déploiement documentés
- [ ] Note de version prête

---

### Jour 11 — Revue finale + Rétrospective MVP

**Objectif :** Livraison du MVP.

#### Tâches

- [ ] Revue de code finale
- [ ] Lint final (npm run lint + flutter analyze)
- [ ] Build APK release final
- [ ] Tag git v1.0.0-beta
- [ ] Release GitHub créée avec APK
- [ ] Rétrospective complète du projet
- [ ] Définition of Done MVP

#### Définition de fait (Jour 11)

- [ ] Tag v1.0.0-beta pushé
- [ ] Release GitHub avec APK
- [ ] Toute la documentation livrée

---

## Définition of Done (Sprint 8) — MVP

- [ ] GitHub Actions CI backend (lint + test + build) sur chaque push
- [ ] GitHub Actions CI frontend (flutter analyze + test) sur chaque push
- [ ] Build APK automatisé sur tag v* avec signature
- [ ] APK publié dans GitHub Release
- [ ] Docker Compose production-ready avec healthchecks
- [ ] Déploiement VPS avec HTTPS (TLS 1.3)
- [ ] Tests E2E du parcours complet validés
- [ ] README documenté (stack, prérequis, démarrage)
- [ ] Scripts deploy.sh + backup-db.sh prêts
- [ ] Aucune régression (tous les tests passent)
- [ ] Lint 0 erreurs (flutter analyze + npm run lint)

---

## MVP HiGame — Récapitulatif

### Fonctionnalités livrées (26 FRs)

| # | FR | Statut |
|:-:|----|:------:|
| FR-01 | Inscription OTP SMS | Sprint 2 ✓ |
| FR-02 | Upload KYC | Sprint 2 ✓ |
| FR-03 | Dépôt MVola | Sprint 5 ✓ |
| FR-04 | Solde wallet temps réel | Sprint 5 ✓ |
| FR-05 | Création partie Domino | Sprint 3 ✓ |
| FR-06 | Rejoindre partie | Sprint 4 ✓ |
| FR-07 | Jouer Domino (plateau, tuiles, tours) | Sprint 3+4 ✓ |
| FR-08 | Pioche | Sprint 3+4 ✓ |
| FR-09 | Résultat + gains | Sprint 4 ✓ |
| FR-10 | Retrait gains MVola | Sprint 5 ✓ |
| FR-11 | Notification tour | Sprint 4 ✓ |
| FR-12 | Reconnexion | Sprint 6 ✓ |
| FR-13 | Historique parties | Sprint 7 ✓ |
| FR-14 | Signalement suspect | Sprint 6 ✓ |
| FR-15 | Limites dépôt | Sprint 5 ✓ |
| FR-16 | Règles du Domino | Sprint 2 ✓ |
| FR-17 | Server-authoritative | Sprint 3 ✓ |
| FR-18 | Mises prédéfinies | Sprint 3 ✓ |
| FR-19 | Gestion abandon | Sprint 6 ✓ |
| FR-20 | Optimisation 2G/3G | Sprint 6 ✓ |
| FR-21 | Logs replay admin | Sprint 6 ✓ |
| FR-22 | Protection données | Sprint 2 ✓ |
| FR-23 | Salon privé | Sprint 4 ✓ |
| FR-24 | Notification crédit wallet | Sprint 4 ✓ |
| FR-25 | Annulation partie | Sprint 4 ✓ |
| FR-26 | Fusion salons 30s | Sprint 4 ✓ |
