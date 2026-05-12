---
sprint_id: "S01"
sprint_duration: "7 jours"
sprint_goal: "Stack opérationnelle + premier écran visible"
stories:
  - "1.1 — Initialiser le monorepo, la BDD et les fondations"
  - "1.2 — Écran Splash + Onboarding 3 slides"
  - "6.1 — Docker Compose (backend + Redis)"
dev_profile: "Junior solo avec IA assistant"
---

# Sprint 1 Planning — HiGame MVP

## Objectif du Sprint

**"Faire tourner l'app sur l'émulateur, backend qui répond, splash visible."**

À la fin de ce sprint, le développeur doit être capable de :
- Lancer l'app Flutter sur un émulateur Android
- Voir le splash screen, swiper l'onboarding, arriver à l'écran d'inscription
- Le backend Fastify répond sur `/health`
- PostgreSQL + Redis tournent dans Docker
- Palette et composants design system sont prêts dans Flutter

---

## Stories du Sprint

| # | Story | Story dans epics.md | FRs | Difficulté | Estimation |
|:-:|-------|:-------------------:|:---:|:----------:|:----------:|
| S1.1 | Initialiser le monorepo, Prisma et les fondations | Epic 1 — Story 1.1 | — | 🔵 Facile | 3 jours |
| S1.2 | Splash + Onboarding 3 slides | Epic 1 — Story 1.2 | — | 🟡 Moyen | 2 jours |
| S1.3 | Docker Compose (backend + Redis) | Epic 6 — Story 6.1 | — | 🔵 Facile | 1 jour |
| | **Tests + Revue + Rétro** | | | | 1 jour |
| | **Total** | | | | **7 jours** |

---

## Déroulé Jour par Jour

---

### Jour 1 — Structure Monorepo

**Story :** 1.1 (partie 1/3)

**Objectif :** Créer la structure de dossiers, installer les dépendances, vérifier que tout compile.

#### Tâches

- [ ] Créer l'arborescence du monorepo
- [ ] Initialiser le backend (packages/backend)
- [ ] Initialiser le frontend (packages/frontend)
- [ ] Configurer les outils de développement (tsconfig, eslint, prettier)
- [ ] Vérifier que tout compile

#### Commandes

```bash
# Depuis la racine du projet
mkdir -p packages/backend/src/modules/{auth,wallet,game,matching,payment}
mkdir -p packages/backend/src/lib
mkdir -p packages/frontend

# Backend
cd packages/backend
npm init -y
npm install fastify @fastify/cors @fastify/jwt @fastify/websocket socket.io @prisma/client redis zod dotenv
npm install -D typescript @types/node tsx prisma eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin vitest

# Frontend — Créer le projet Flutter
cd ../frontend
flutter create --org com.higame --project-name higame_app .
flutter pub add flutter_riverpod riverpod_annotation go_router hive_flutter dio socket_io_client flutter_local_notifications
flutter pub add -d riverpod_generator build_runner hive_generator
```

#### Prompts IA

<details>
<summary>Prompt 1 : Structure monorepo complète</summary>

```
Génère la structure complète d'un monorepo Node.js/TypeScript pour un projet Fastify + Flutter.

Structure :
- Racine : package.json avec "workspaces": ["packages/backend", "packages/frontend"]
- Racine : tsconfig.base.json avec strict: true, paths alias "@higame/*"
- Racine : .gitignore (node_modules, .env, build, dist, .dart_tool, .flutter-plugins)
- Racine : .prettierrc (singleQuote, semi, printWidth 100)
- packages/backend/package.json avec les dépendances : fastify, @fastify/cors, @fastify/jwt, @fastify/websocket, socket.io, prisma, @prisma/client, redis, zod, dotenv. DevDeps : typescript, @types/node, tsx, vitest, eslint.
- packages/backend/tsconfig.json qui étend tsconfig.base.json, outDir: ./dist
- packages/backend/src/index.ts : point d'entrée Fastify avec CORS, JWT, et un plugin pour les modules (auto-register depuis /modules)
- packages/backend/src/lib/env.ts : validation Zod des variables d'environnement (PORT=3000, DATABASE_URL, REDIS_URL, JWT_SECRET, PAIDMADA_API_KEY)

Le but est d'avoir un monorepo qui compile et où le backend peut démarrer avec "npm run dev" (tsx watch src/index.ts).
```
</details>

<details>
<summary>Prompt 2 : Initialisation Flutter avec dépendances</summary>

```
Je crée un projet Flutter pour une app de jeux mobile (HiGame).
Voici les dépendances à ajouter dans pubspec.yaml :

- flutter_riverpod : gestion d'état
- riverpod_annotation : code generation
- go_router : navigation déclarative  
- hive_flutter : cache local offline
- dio : client HTTP
- socket_io_client : WebSocket
- flutter_local_notifications : notifications push

Dev dependencies :
- riverpod_generator
- build_runner
- hive_generator

Donne le bloc pubspec.yaml complet avec les bonnes versions (vérifie les dernières stables).
Structure de dossiers Flutter :
lib/
  app/
    app.dart          (ProviderScope + MaterialApp.router)
    router.dart       (GoRouter - routes vides pour l'instant)
    theme.dart        (thème Material 3)
  features/
    auth/             (splash, onboarding, login, kyc)
    wallet/           (wallet screen)
    game/             (lobby, plateau domino)
    profile/          (profil, paramètres, historique)
  core/
    network/          (dio client, socket client)
    storage/          (hive helper)
    models/           (DTOs partagés)
```
</details>

<details>
<summary>Prompt 3 : Configuration ESLint/Prettier TypeScript</summary>

```
Génère les fichiers de configuration ESLint et Prettier pour un projet TypeScript avec Fastify.

- packages/backend/.eslintrc.json : règles strictes TypeScript, import sorting, no-unused-vars error
- packages/backend/.prettierrc : singleQuote, semi, printWidth 100, trailingComma all
- scripts de package.json : "lint": "eslint src/", "lint:fix": "eslint src/ --fix", "format": "prettier --write src/"
- Le lint doit être exécutable avec "npm run lint"

Ajoute aussi un tsconfig.json optimisé pour Node.js 20+ avec :
- target: ES2022
- module: NodeNext  
- moduleResolution: NodeNext
- strict: true
- outDir: ./dist
- rootDir: ./src
- paths: { "@/*": ["./src/*"] }
```
</details>

#### Définition de fait (Jour 1)

- [ ] `npm run lint` passe sans erreur dans packages/backend
- [ ] `tsc --noEmit` passe dans packages/backend
- [ ] `flutter analyze` passe dans packages/frontend
- [ ] La structure monorepo est créée

---

### Jour 2 — Base de données + Backend Hello World

**Story :** 1.1 (partie 2/3)

**Objectif :** Configurer Prisma, créer la première migration, backend Fastify qui répond.

#### Tâches

- [ ] Initialiser Prisma avec PostgreSQL
- [ ] Écrire le schéma Prisma (table users + kyc_documents)
- [ ] Créer la première migration
- [ ] Implémenter le endpoint GET /health
- [ ] Démarrer le serveur et tester

#### Commandes

```bash
cd packages/backend
npx prisma init --datasource-provider postgresql
# Editer le fichier .env avec DATABASE_URL
npx prisma migrate dev --name init
# Démarrer le serveur
npx tsx src/index.ts
# Tester
curl http://localhost:3000/health
```

#### Prompts IA

<details>
<summary>Prompt 1 : Schéma Prisma complet</summary>

```
Génère le schéma Prisma pour la base de données HiGame (MVP Domino).

Tables nécessaires :
1. users
   - id: UUID (default généré)
   - phone: String (unique, format +261XXXXXXXXX)
   - pseudo: String (nullable, défault = "Joueur" + 4 chiffres)
   - statusKyc: Enum (NOT_SUBMITTED, PENDING, VERIFIED, REJECTED)
   - refreshToken: String (nullable, hashé)
   - createdAt: DateTime
   - updatedAt: DateTime

2. kyc_documents
   - id: UUID
   - userId: UUID (relation users)
   - documentType: Enum (CIN, PERMIS)
   - filePath: String (chemin fichier chiffré)
   - status: Enum (PENDING, VERIFIED, REJECTED)
   - rejectionReason: String (nullable)
   - createdAt: DateTime
   - updatedAt: DateTime

Ajoute les indexes nécessaires (phone, userId).
Ajoute les relations (User a plusieurs kyc_documents).
Le datasource est PostgreSQL.
```
</details>

<details>
<summary>Prompt 2 : Endpoint GET /health avec vérification DB + Redis</summary>

```
Complète le fichier packages/backend/src/index.ts avec :

1. Plugin Prisma : instance PrismaClient, hook onClose pour déconnexion
2. Plugin Redis : client ioredis ou redis (npm redis), hook onClose
3. Route GET /health qui retourne :
   {
     status: "ok",
     timestamp: ISO 8601,
     uptime: process.uptime(),
     db: "connected" | "disconnected" (test via prisma.$queryRaw SELECT 1),
     redis: "connected" | "disconnected" (test via redis.ping())
   }
4. Gestion des erreurs : si DB ou Redis est down, retourner 503 au lieu de 200
5. Logger pino pour les requêtes

Le port est chargé depuis process.env.PORT (défaut 3000).
Le tout doit être typé avec TypeScript strict.
```
</details>

<details>
<summary>Prompt 3 : Variables d'environnement avec Zod validation</summary>

```
Crée un fichier packages/backend/src/lib/env.ts qui valide les variables d'environnement avec Zod.

Schéma d'env :
- PORT: string (defaut "3000")
- DATABASE_URL: string (url PostgreSQL)
- REDIS_URL: string (defaut "redis://localhost:6379")
- JWT_SECRET: string (min 32 caractères)
- JWT_REFRESH_SECRET: string (min 32 caractères)
- PAIDMADA_API_KEY: string (nullable, défaut "sandbox")
- NODE_ENV: enum ["development", "production", "test"] (defaut "development")

Exporte un objet typé `env` avec les valeurs parsées.
Utilise process.loadEnvFile() ou dotenv pour charger .env.
Affiche un message d'erreur clair si une variable est manquante et exit(1).
```
</details>

#### Définition de fait (Jour 2)

- [ ] `npx prisma migrate dev --name init` crée les tables users + kyc_documents
- [ ] `curl localhost:3000/health` retourne 200 avec status "ok"
- [ ] Si PostgreSQL est arrêté → retourne 503

---

### Jour 3 — Flutter App + Routes + Thème

**Story :** 1.1 (partie 3/3)

**Objectif :** App Flutter structurée avec routing, thème, palette, et les dépendances bien configurées.

#### Tâches

- [ ] Créer le thème Material 3 avec la palette HiGame
- [ ] Configurer GoRouter avec toutes les routes (écrans vides)
- [ ] Mettre en place Riverpod (ProviderScope)
- [ ] Configurer Hive pour le cache offline
- [ ] Créer les composants design system de base

#### Prompts IA

<details>
<summary>Prompt 1 : Thème Flutter Material 3 complet HiGame</summary>

```
Génère un fichier lib/app/theme.dart pour l'app Flutter HiGame.
Le thème doit utiliser Material 3 avec les couleurs suivantes :

Palette HiGame :
- Primaire (primary): #1565C0 (bleu)
- Primaire clair: #42A5F5
- Primaire foncé: #0D47A1
- Accent (secondary): #00BFA5 (teal)
- Success: #4CAF50
- Error: #F44336
- Warning: #FFB300
- Fond page: #F5F5F5
- Surface: #FFFFFF

Typographie : Inter (Google Fonts)
- H1: 24px Bold
- H2: 18px SemiBold
- H3: 16px SemiBold
- Body: 14px Regular
- Button: 15px SemiBold
- Monetary: 20px Bold (pour les montants d'argent)

Boutons :
- Primaire : fond #00BFA5, 48px height, radius 12px, full width, text white 15px SemiBold
- Outline : border #1565C0, text #1565C0
- Text : #757575, pas de fond/bordure

Input :
- 48px height, radius 12px, padding horizontal 16px
- border default #E0E0E0, focus #1565C0, error #F44336

Cards :
- radius 12px, shadow sm (0 2px 8px rgba(0,0,0,0.08)), padding 16px

Le thème doit gérer le mode clair uniquement pour le MVP.
Utilise GoogleFonts.inter() pour la typographie.
```
</details>

<details>
<summary>Prompt 2 : GoRouter avec toutes les routes HiGame</summary>

```
Génère un fichier lib/app/router.dart avec GoRouter pour HiGame.

Routes :
1. /splash → SplashScreen (pas d'auth requise)
2. /onboarding → OnboardingScreen (pas d'auth requise)
3. /login → LoginScreen (inscription + OTP, pas d'auth requise)
4. /kyc → KycScreen (auth requise - redirect vers /login si pas de token)
5. /dashboard → DashboardScreen (auth requise)
6. /wallet → WalletScreen (auth requise)
7. /game/create → CreateGameScreen (auth requise)
8. /game/lobby → LobbyScreen (auth requise)
9. /game/board → GameBoardScreen (auth requise)
10. /game/result → GameResultScreen (auth requise)
11. /profile → ProfileScreen (auth requise)
12. /settings → SettingsScreen (auth requise)
13. /history → HistoryScreen (auth requise)
14. /rules → RulesScreen (pas d'auth requise)

Pour l'instant, tous les écrans sont des pages temporaires "En construction" sauf :
- /splash (sera développée Jour 4)
- /onboarding (sera développée Jour 5)
- /login (sera développée Sprint 2)
- /rules (sera développée Sprint 2)

Le redirect auth check : vérifie si un token JWT existe dans Hive.
Si pas de token et route protégée → redirect /login.
Si token et route publique (login) → redirect /dashboard.
```
</details>

<details>
<summary>Prompt 3 : Composants design system réutilisables</summary>

```
Génère les composants UI réutilisables HiGame dans lib/core/widgets/ :

1. HiButton.dart — Bouton primaire :
   - height 48px, radius 12px, full width
   - Couleur #00BFA5, text white
   - États : normal, pressed (opacity 0.8), disabled (gris), loading (spinner)
   - Propriétés : label, onPressed, isLoading, isDisabled

2. HiOutlineButton.dart — Bouton outline :
   - border #1565C0 2px, text #1565C0
   - height 48px, radius 12px, full width

3. HiInput.dart — Input avec label :
   - height 48px, radius 12px, padding 16px
   - border #E0E0E0 (default), #1565C0 (focus), #F44336 (error)
   - label, hint, error message, suffix icon optionnel
   - Affiche le message d'erreur en rouge en dessous

4. HiCard.dart — Card :
   - radius 12px, shadow, padding 16px
   - child widget

5. WalletCard.dart — Carte wallet avec gradient :
   - gradient linéaire #1565C0 → #0D47A1
   - Solde en blanc 24px Bold, label "Solde" en 12px
   - Boutons Déposer / Retirer (outline blanc)
   - radius 12px, padding 20px

6. BottomNav.dart — Barre de navigation basse :
   - 4 tabs : Accueil, Partie, Wallet, Profil
   - Hauteur 64px, icône actif #1565C0, inactif #BDBDBD

Tous les composants doivent être typés, documentés, et suivre le thème défini dans theme.dart.
```
</details>

<details>
<summary>Prompt 4 : Configuration Hive pour le cache offline</summary>

```
Génère un helper Hive dans lib/core/storage/hive_helper.dart pour HiGame.

Fonctions :
- init() : initialiser Hive avec le path, enregistrer les adapters
- setToken(String token) : sauvegarder le JWT
- getToken() : récupérer le JWT (nullable)
- removeToken() : supprimer le JWT (déconnexion)
- setOnboardingCompleted(bool) : marquer l'onboarding comme vu
- isOnboardingCompleted() : bool
- setKycStatus(String status) : sauvegarder le statut KYC
- getKycStatus() : String (nullable)
- setWalletBalance(double balance) : cache offline du solde
- getWalletBalance() : double (nullable)
- clear() : tout supprimer (déconnexion totale)

Exporte un provider Riverpod hiviProvider qui expose ces fonctions.
Ajoute la gestion d'erreur : si Hive n'est pas initialisé, retourner des valeurs par défaut.
```
</details>

#### Définition de fait (Jour 3)

- [ ] Le thème Material 3 s'applique sur tous les écrans
- [ ] La navigation GoRouter fonctionne (redirect /splash si pas de token)
- [ ] Les composants design system sont prêts
- [ ] Hive s'initialise sans erreur

---

### Jour 4 — Splash Screen

**Story :** 1.2 (partie 1/2)

**Objectif :** Écran splash fonctionnel qui redirige vers onboarding ou dashboard.

#### Tâches

- [ ] Créer SplashScreen avec logo + spinner
- [ ] Logique de redirection automatique (2s)
- [ ] Vérification token JWT dans Hive
- [ ] État "pas de réseau"

#### Prompts IA

<details>
<summary>Prompt 1 : SplashScreen complet avec redirection</summary>

```
Génère un SplashScreen Flutter Riverpod complet.

Layout :
- Fond #1565C0 (primary color)
- Centré verticalement :
  - Logo HiGame : icône domino personnalisée + texte "HiGame" 24px Bold white
  - Sous-titre : "Jeux malgaches, argent réel" 14px white 80% opacity
  - Spinner blanc (CircularProgressIndicator valueColor: white)
- En bas : version "v1.0.0-beta" en caption white 60%

Logique (dans un Riverpod AsyncNotifier) :
- Au montage, attendre 2 secondes
- Pendant l'attente, vérifier la connexion réseau (dio GET /health avec timeout 3s)
- Après 2s :
  - Si pas de réseau → afficher Snackbar "Vérifie connexion" et rester sur splash
  - Si réseau OK + token JWT dans Hive → naviguer /dashboard
  - Si réseau OK + pas de token → naviguer /onboarding
- Utiliser go_router pour la navigation (context.go())

Tests à inclure dans le même fichier (commentaires) :
- "Splash affiche logo" → vérifier présence du texte HiGame
- "Splash sans token navigue vers onboarding"
- "Splash avec token navigue vers dashboard"
- "Splash sans réseau affiche snackbar erreur"

Utilise flutter_hooks ou un StateNotifier pour le timer de 2s.
```
</details>

<details>
<summary>Prompt 2 : Provider Riverpod pour le statut Auth</summary>

```
Génère un provider Riverpod lib/features/auth/providers/auth_provider.dart

State : AuthState = {
  status: enum (unknown, authenticated, unauthenticated, loading)
  user: User? 
  error: String?
}

User model : { id: String, phone: String, pseudo: String, statusKyc: String }

Fonctions exposées :
- checkAuth() : lit le token Hive, si présent vérifie sa validité via GET /auth/me
  - Si 200 → status = authenticated, user = response
  - Si 401 → supprime token, status = unauthenticated
  - Pas de token → status = unauthenticated
- login(String token) : sauvegarde token dans Hive, appelle checkAuth()
- logout() : supprime token Hive, status = unauthenticated

GoRouter redirect doit utiliser ce provider :
- Si status unknown → redirect /splash (continue splash)
- Si status authenticated + sur /login ou /onboarding → redirect /dashboard
- Si status unauthenticated + route protégée → redirect /login

Astuce : utilise ProviderScope et watch() pour le redirect.
```
</details>

#### Définition de fait (Jour 4)

- [ ] Splash s'affiche avec logo + spinner
- [ ] Après 2s : pas de token → onboarding
- [ ] Après 2s : token valide → dashboard (écran vide "En construction")
- [ ] Pas de réseau → snackbar + reste sur splash

---

### Jour 5 — Onboarding 3 slides

**Story :** 1.2 (partie 2/2)

**Objectif :** 3 slides avec swipe, dots, bouton "Commencer".

#### Tâches

- [ ] Créer les 3 slides avec leur contenu
- [ ] PageView + dots indicateurs
- [ ] Bouton "Suivant" / "Commencer"
- [ ] Lien "Passer"
- [ ] Séquence : fin Onboarding → Inscription

#### Prompts IA

<details>
<summary>Prompt 1 : OnboardingScreen avec PageView et dots</summary>

```
Génère un OnboardingScreen Flutter avec PageView.builder pour HiGame.

3 slides avec PageController :

Slide 1 - "Milalao Domino, win vola !"
  - Illustration : tuiles domino + pièces d'or (assets/SVGs à référencer)
  - Titre H2 "Milalao Domino, win vola !" noir #212121
  - Sous-texte Body "Affronte joueurs Madagascar, gagne money réel." gris #757575

Slide 2 - "Mobile Money direct"
  - Illustration : logos MVola + Orange Money + Airtel Money (assets/SVGs)
  - Titre H2 "Mobile Money direct" #212121
  - Sous-texte Body "Dépose, retire via MVola, OM, Airtel — 1 clic." #757575

Slide 3 - "Secure & transparent"
  - Illustration : bouclier + cadenas
  - Titre H2 "Secure & transparent" #212121
  - Sous-texte Body "Parties équitables, commission 12% claire, retrait instantané." #757575

Éléments communs (bas de chaque slide) :
- Dots indicateurs : PageView dots (actif #1565C0, inactif #E0E0E0, 8px size)
- Bouton "Suivant" → slide suivant (ou "Commencer" si dernier slide)
  - Style : HiButton (accent #00BFA5, 48px, radius 12px, full width, margin horizontal 24px)
  - Dernier slide : sauvegarde onboarding_completed=true dans Hive, puis context.go('/login')
- Lien "Passer" → text button #757575, centré sous le bouton
  - Skip l'onboarding, va directement vers /login

État "dernier slide" : le bouton change de "Suivant" à "Commencer".
```
</details>

<details>
<summary>Prompt 2 : Assets SVG pour les slides (placeholder)</summary>

```
Je dois créer des illustrations SVG simples pour l'onboarding de HiGame.

Génère 3 fichiers SVG simples (peuvent être des placeholders) :

1. assets/svgs/onboarding_domino.svg
   - Une tuile de domino blanche avec points noirs
   - Une pièce d'or circulaire avec "Ar" à côté
   - Style minimaliste, lignes fines, couleurs #1565C0 et #FFB300

2. assets/svgs/onboarding_money.svg
   - 3 petits logos ronds : MVola (vert), Orange Money (orange), Airtel (rouge)
   - Flèche pointant vers un téléphone
   - Style minimaliste

3. assets/svgs/onboarding_security.svg  
   - Un bouclier stylisé avec un cadenas à l'intérieur
   - Couleur #1565C0 et #00BFA5
   - Style minimaliste

Ajoute aussi les assets dans pubspec.yaml :
flutter:
  assets:
    - assets/svgs/

Format SVG minimal, pas de viewBox complexe, optimisé pour écran mobile (120x120px).
```
</details>

#### Définition de fait (Jour 5)

- [ ] 3 slides visibles, swipe horizontal fonctionnel
- [ ] Dots se mettent à jour
- [ ] "Suivant" → slide suivant, "Commencer" (slide 3) → /login
- [ ] "Passer" → /login depuis n'importe quel slide
- [ ] onboarding_completed=true sauvegardé dans Hive

---

### Jour 6 — Docker Compose

**Story :** 6.1

**Objectif :** Backend, PostgreSQL et Redis tournent dans Docker.

#### Tâches

- [ ] Créer le Dockerfile du backend
- [ ] Créer le docker-compose.yml
- [ ] Tester le déploiement complet
- [ ] Vérifier que tout communique

#### Prompts IA

<details>
<summary>Prompt 1 : Dockerfile multi-stage pour Node.js/TypeScript</summary>

```
Génère un Dockerfile multi-stage pour le backend Fastify (packages/backend/Dockerfile).

Stage 1 — Build :
- Image node:22-alpine
- WORKDIR /app
- Copier package.json + package-lock.json
- npm ci (clean install, pas de devDependencies... en fait si, on a besoin de typescript)
- npm install (tout, y compris devDeps)
- Copier tsconfig.json et tout le src/
- npx tsc (compiler le TypeScript)

Stage 2 — Production :
- Image node:22-alpine
- WORKDIR /app  
- Copier dist/ depuis stage 1
- Copier package.json + package-lock.json
- npm ci --production (seulement les prodDeps)
- npx prisma generate
- EXPOSE 3000
- CMD ["node", "dist/index.js"]

Le Dockerfile doit être optimisé pour utiliser le cache Docker :
- Copier package.json en premier, npm install, puis le reste du code
```
</details>

<details>
<summary>Prompt 2 : docker-compose.yml complet</summary>

```
Génère un docker-compose.yml à la racine du projet (pas dans packages/).

Services :

1. backend :
   build: ./packages/backend
   ports: "3000:3000"
   env_file: .env
   depends_on: postgres, redis
   networks: [higame-net]
   restart: unless-stopped
   healthcheck: test ["CMD", "curl", "-f", "http://localhost:3000/health"]

2. postgres :
   image: postgres:16-alpine
   environment: POSTGRES_USER=higame, POSTGRES_PASSWORD=higame_pass, POSTGRES_DB=higame
   volumes: postgres_data:/var/lib/postgresql/data
   ports: "5432:5432"
   networks: [higame-net]
   healthcheck: test ["CMD-SHELL", "pg_isready -U higame"]

3. redis :
   image: redis:7-alpine
   ports: "6379:6379"
   volumes: redis_data:/data
   networks: [higame-net]
   command: redis-server --appendonly yes
   healthcheck: test ["CMD", "redis-cli", "ping"]

Volumes : postgres_data, redis_data
Networks : higame-net (driver bridge)

Inclut un fichier .env.example commenté à la racine avec toutes les variables nécessaires.
```
</details>

<details>
<summary>Prompt 3 : .env.example complet</summary>

```
Génère un fichier .env.example à la racine du projet avec des valeurs par défaut pour le développement local.

# HiGame — Environment Variables
# Copier ce fichier en .env et adapter les valeurs

# Server
PORT=3000
NODE_ENV=development

# Database PostgreSQL
DATABASE_URL=postgresql://higame:higame_pass@localhost:5432/higame

# Redis
REDIS_URL=redis://localhost:6379

# JWT
JWT_SECRET=dev-secret-key-minimum-32-characters-long
JWT_REFRESH_SECRET=dev-refresh-secret-key-minimum-32-characters

# PaidMada (sandbox par défaut pour le dev)
PAIDMADA_API_KEY=sandbox
PAIDMADA_WEBHOOK_SECRET=sandbox-webhook-secret

# Frontend URL (pour les webhooks)
FRONTEND_URL=http://localhost:3000
```
</details>

#### Définition de fait (Jour 6)

- [ ] `docker compose up` démarre les 3 services
- [ ] `curl localhost:3000/health` → 200 OK, db + redis connected
- [ ] `docker compose down` arrête proprement
- [ ] Les volumes persistent les données

---

### Jour 7 — Tests, Revue et Rétro

**Objectif :** Consolider le sprint, tester, documenter.

#### Tâches

- [ ] Écrire les tests du splash screen
- [ ] Écrire les tests du health endpoint
- [ ] Revue de code de tout le sprint
- [ ] Checklist de fin de sprint
- [ ] Rétrospective

#### Prompts IA

<details>
<summary>Prompt 1 : Tests Flutter pour SplashScreen</summary>

```
Génère des tests Flutter pour le SplashScreen dans test/features/auth/splash_test.dart.

Tests unitaires (utilise flutter_test) :
1. "Affiche le logo HiGame" → vérifie que le texte "HiGame" est présent
2. "Affiche le spinner" → vérifie CircularProgressIndicator
3. "Affiche la version" → vérifie "v1.0.0-beta"

Tests d'intégration (avec Hive mocké) :
4. "Redirige vers /onboarding après 2s si pas de token" → mock Hive token = null, pumpAndSettle avec duration 2.5s, vérifier que la route est /onboarding  
5. "Redirige vers /dashboard après 2s si token présent" → mock Hive token = "fake-jwt", pumpAndSettle 2.5s, vérifier route /dashboard
6. "Affiche snackbar si pas de réseau" → mock DioException de connection refused, vérifier SnackBar "Vérifie connexion"

Utilise NetworkAssetImage pour les assets ou mock les images.
Priorité : tester les 3 cas de redirection (session, pas session, pas réseau).
```
</details>

<details>
<summary>Prompt 2 : Tests Vitest pour le backend</summary>

```
Génère des tests d'intégration pour le backend Fastify dans packages/backend/src/__tests__/health.test.ts.

Framework : Vitest (avec @fastify/test-helper ou une instance Fastify dédiée).

Tests :
1. "GET /health retourne 200" → vérifier status 200
2. "GET /health a le bon format" → vérifier body a les champs : status, timestamp, uptime, db, redis
3. "GET /health retourne 503 si DB est down" → mock prisma.$queryRaw pour lancer une erreur, vérifier 503
4. "GET /health_status est sensible à la casse" → GET /Health → 404

Utilise un fichier setup.ts qui :
- Charge les variables d'env de test
- Crée une instance Fastify avec les mêmes plugins que l'app
- Cleanup après chaque test

Astuce : crée une fonction buildApp() dans src/app.ts qui retourne l'instance Fastify configurée sans le démarrage, pour pouvoir la tester.
```
</details>

<details>
<summary>Prompt 3 : Checklist de fin de sprint</summary>

```
Génère une checklist de fin de sprint pour le Sprint 1 de HiGame.

Fonctionnalités :
- [ ] L'app Flutter se lance sur émulateur Android
- [ ] Splash s'affiche 2s puis redirige (token → dashboard, pas token → onboarding)
- [ ] Onboarding 3 slides swipeables
- [ ] Dernier slide "Commencer" → écran d'inscription (page vide "En construction")
- [ ] "Passer" → écran d'inscription
- [ ] Backend Fastify répond sur GET /health
- [ ] Test backend : curl localhost:3000/health → 200

Technique :
- [ ] npm run lint → 0 erreurs dans packages/backend
- [ ] flutter analyze → 0 erreurs dans packages/frontend
- [ ] npx tsc --noEmit → 0 erreurs
- [ ] docker compose up → 3 services opérationnels
- [ ] Tests Flutter : flutter test → vert
- [ ] Tests backend : npx vitest run → vert

Qualité :
- [ ] Pas de clé API ou secret dans le code
- [ ] .gitignore complet (node_modules, .env, build, .dart_tool)
- [ ] README.md de base avec instructions de démarrage
- [ ] Les composants design system sont réutilisables
```
</details>

#### Définition de fait (Jour 7)

- [ ] `flutter test` → tout vert
- [ ] `npx vitest run` → tout vert
- [ ] Checklist complétée
- [ ] README.md mis à jour

---

## Ressources d'apprentissage pour le junior

Si le développeur découvre un concept, voici les prompts à copier-coller à l'IA :

| Concept | Prompt |
|---------|--------|
| Riverpod | *"Explique Riverpod AsyncNotifierProvider avec un exemple simple. Je veux gérer l'état d'authentification. Donne le provider, le state, et comment l'utiliser dans un widget."* |
| GoRouter redirect | *"Comment fonctionne le redirect dans GoRouter ? Je veux rediriger vers /login si l'utilisateur n'est pas authentifié, et vers /dashboard s'il est déjà connecté."* |
| Prisma migrations | *"Je viens de modifier mon schéma Prisma. Quelle est la commande pour créer une migration et l'appliquer ? Commet gérer les conflits de migration ?"* |
| Fastify plugins | *"Comment organiser mon code Fastify en plugins ? Donne un exemple avec des routes, des hooks, et des décorateurs."* |
| Docker Compose pour débutant | *"Explique docker-compose.yml ligne par ligne. Qu'est-ce qu'un service, un volume, un network, un healthcheck ? Donne un exemple simple."* |
| Socket.IO basique | *"Comment fonctionne Socket.IO avec Fastify ? Donne un exemple serveur qui crée une room et diffuse un événement, et un client Flutter qui se connecte et écoute."* |

---

## Définition of Done (Sprint 1)

- [ ] L'application Flutter s'affiche sur émulateur Android
- [ ] Splash screen → Onboarding → prêt pour l'inscription
- [ ] Backend Fastify répond sur GET /health (200)
- [ ] PostgreSQL + Redis tournent dans Docker
- [ ] Thème Material 3 et composants design system prêts
- [ ] Hive opérationnel pour le cache offline
- [ ] Tests passent (flutter test + vitest)
- [ ] Ci-dessous lint du code (flutter analyze + npm run lint)
- [ ] README.md avec instructions "comment lancer le projet"

---

## Prochain Sprint (Aperçu)

Le Sprint 2 couvrira :
- Inscription OTP SMS (Story 1.3)
- KYC upload (Story 1.4)
- Règles du jeu (Story 1.5)
- Backend auth complet (JWT, refresh token, rate limiting)
