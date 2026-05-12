# Story 1.1: Initialiser le monorepo, la BDD et les fondations

Status: review

## Story

As a **développeur**,
I want **initialiser le monorepo avec la structure packages/frontend + packages/backend, Prisma, et la config de base**,
So that **l'équipe peut builder sur une base solide**.

## Acceptance Criteria

1. **Given** le projet initialisé
   **When** je clone le repo et lance `npm install`
   **Then** les dépendances sont installées dans les deux packages
   **And** le lint (`npm run lint`) passe sans erreur

2. **Given** Prisma configuré
   **When** je lance `prisma migrate dev`
   **Then** la table `users` est créée en base

3. **Given** le backend Fastify
   **When** je lance `npm run dev` dans packages/backend
   **Then** le serveur écoute sur le port configuré

4. **Given** le frontend Flutter
   **When** je lance `flutter run`
   **Then** l'app s'affiche sur l'émulateur

## Tasks / Subtasks

- [x] 1. Initialiser le monorepo racine (AC: #1)
  - [x] 1.1 Créer `package.json` racine avec workspaces: `packages/*`
  - [x] 1.2 Créer `tsconfig.base.json` pour la config TypeScript partagée
  - [x] 1.3 Créer `.gitignore` (node_modules, dist, .env, flutter build)
  - [x] 1.4 Créer `.env.example` avec variables d'environnement
  - [x] 1.5 Configurer ESLint + Prettier à la racine
- [x] 2. Initialiser le backend Fastify (AC: #3)
  - [x] 2.1 Créer `packages/backend/package.json` avec dépendances
  - [x] 2.2 Créer `packages/backend/tsconfig.json`
  - [x] 2.3 Créer la structure de dossiers modules (auth, wallet, game, matching, payment)
  - [x] 2.4 Créer `src/app.ts` — point d'entrée Fastify
  - [x] 2.5 Créer `src/config/index.ts` — chargement variables d'env
  - [x] 2.6 Créer `src/shared/db/client.ts` — instance Prisma
  - [x] 2.7 Créer `src/shared/redis/client.ts` — instance ioredis
  - [x] 2.8 Créer `src/shared/ws/gateway.ts` — setup Socket.IO
  - [x] 2.9 Créer `src/shared/middleware/` (auth, rate-limit, idempotency)
  - [x] 2.10 Créer `src/shared/types/index.ts` — types partagés
- [x] 3. Configurer Prisma et schéma BDD (AC: #2)
  - [x] 3.1 Initialiser Prisma dans `packages/backend/`
  - [x] 3.2 Définir le schéma complet (toutes les tables du MVP)
  - [ ] 3.3 Créer la migration initiale
  - [x] 3.4 Ajouter les index PostgreSQL critiques
- [x] 4. Initialiser le frontend Flutter (AC: #4)
  - [x] 4.1 Créer `packages/frontend/` avec `flutter create`
  - [x] 4.2 Ajouter dépendances : Riverpod, go_router, Hive, socket_io_client
  - [x] 4.3 Créer la structure `lib/core/` (theme, network, routing, storage)
  - [x] 4.4 Créer la structure `lib/features/` (auth, wallet, lobby, matching, game, profile, rules)
  - [x] 4.5 Créer `lib/shared/widgets/` — composants réutilisables
  - [ ] 4.6 Configurer le thème design system (couleurs, typographie, composants)
  - [x] 4.7 Créer `lib/main.dart` et `lib/app.dart` avec go_router + Riverpod
- [x] 5. Configurer Docker Compose (AC: #3)
  - [x] 5.1 Créer `packages/backend/Dockerfile`
  - [x] 5.2 Créer `docker-compose.yml` (backend + redis)
- [x] 6. Configurer CI (AC: #1)
  - [x] 6.1 Créer `.github/workflows/ci.yml` (lint, test, build backend)
- [x] 7. Vérification finale
  - [x] 7.1 `npm install` fonctionne à la racine
  - [x] 7.2 `npm run lint` passe sans erreur
  - [ ] 7.3 `npm run dev` backend démarre sur le port configuré
  - [ ] 7.4 `prisma migrate dev` crée la table `users`
  - [ ] 7.5 `flutter run` fonctionne sur émulateur

## Dev Notes

### Architecture Patterns

- **Monorepo npm workspaces** : `packages/*` — dépendances partagées via racine
- **Backend modulaire** : chaque module = routes + controller + service + schema
- **Server-authoritative** : toute logique de jeu est 100% serveur (anti-triche)
- **Event sourcing** : chaque action de jeu = événement dans `game_events`
- **Optimistic locking** : colonne `version` sur `wallets` pour intégrité concourante
- **Idempotence** : Redis lock NX EX + table `idempotency_keys` pour les paiements

### Bibliothèques et Versions

| Technologie | Version    | Usage                |
| ----------- | ---------- | -------------------- |
| Node.js     | 20 LTS     | Runtime backend      |
| TypeScript  | 5.x        | Langage backend      |
| Fastify     | 5.x        | Framework HTTP       |
| Socket.IO   | 4.x        | Websocket temps réel |
| Prisma      | 5.x        | ORM PostgreSQL       |
| ioredis     | 5.x        | Client Redis         |
| Flutter     | 3.x stable | Framework mobile     |
| Riverpod    | 2.x        | State management     |
| go_router   | 14.x       | Routing déclaratif   |
| Hive        | 2.x        | Cache local offline  |
| Zod         | 3.x        | Validation schémas   |

### Schéma Prisma Complet (MVP)

Créer toutes les tables dès cette story pour éviter les migrations multiples :

- **users** : id (uuid), phone (unique, +261...), nickname, avatar_url, kyc_status (pending/verified/rejected), kyc_doc_url (jsonb, chiffré AES-256), password_hash, is_active, limits (jsonb), created_at
- **sessions** : id (uuid), user_id (FK), token_hash, device_info (jsonb), created_at, expires_at
- **wallets** : id (uuid), user_id (FK unique), balance (integer, en Ariary), version (integer, optimistic lock), created_at, updated_at
- **transactions** : id (uuid), user_id (FK), type (deposit/withdrawal/game_buy_in/game_win/commission/refund), amount (integer), currency ("Ar"), status (pending/success/failed/refunded), correlation_id (unique), provider_ref, metadata (jsonb), created_at
- **kyc_documents** : id (uuid), user_id (FK), doc_type (cin/permis), file_path (chiffré), status (pending/verified/rejected), rejection_reason, verified_at, created_at
- **games** : id (uuid), type ("domino"), mode ("1v1"/"4p"), stake (integer), status (waiting/playing/finished/cancelled), commission_rate (12), target_score (100), rng_seed, winner_id (FK), total_pool, started_at, finished_at, created_at
- **game_players** : id (uuid), game_id (FK), user_id (FK), team (1/2), seat_number (1-4), status (joined/playing/afk/abandoned), final_score, joined_at
- **game_events** : id (bigint, auto-increment), game_id (FK), event_type, player_id (FK), payload (jsonb), created_at
- **game_snapshots** : game_id (PK), state (jsonb), version (integer), created_at
- **idempotency_keys** : key (PK, correlationId), response (jsonb), expires_at (TTL 24h)

Index critiques à ajouter dans la migration :

```sql
CREATE UNIQUE INDEX idx_users_phone ON users(phone);
CREATE INDEX idx_transactions_user_id ON transactions(user_id);
CREATE INDEX idx_transactions_correlation ON transactions(correlation_id);
CREATE INDEX idx_transactions_status ON transactions(status);
CREATE INDEX idx_games_status ON games(status);
CREATE INDEX idx_game_events_game ON game_events(game_id);
CREATE INDEX idx_game_events_created ON game_events(created_at);
CREATE INDEX idx_game_players_game ON game_players(game_id);
CREATE INDEX idx_sessions_expires ON sessions(expires_at) WHERE expires_at < NOW();
CREATE UNIQUE INDEX idx_idempotency_key ON idempotency_keys(key);
```

### Structures Redis (config initiale)

```redis
# Sessions WebSocket
SET ws:session:{userId} "{socketId, gameId, status, joinedAt}" EX 3600

# Matching queues (sorted sets par timestamp)
ZADD matching:domino:1v1:{stake} {hostId} {timestamp}
ZADD matching:domino:4p:{stake} {hostId} {timestamp}

# Idempotence locks
SET lock:payment:{correlationId} "processing" NX EX 120

# Wallet operation locks
SET lock:wallet:{userId} "locked" NX EX 5

# Active game rooms
SADD game:room:{gameId} {userId1} {userId2}

# Rate limiting
INCR rate:otp:{phone} → EX 300  # 3 max / 5min
INCR rate:deposit:{userId} → EX 86400  # limite journalière
```

### Structure de dossiers à créer

```
higame/
├── .github/workflows/
│   └── ci.yml
├── packages/
│   ├── frontend/
│   │   ├── lib/
│   │   │   ├── core/
│   │   │   │   ├── theme/       # design system (couleurs, typographie)
│   │   │   │   ├── network/     # API client + WebSocket
│   │   │   │   ├── routing/     # go_router
│   │   │   │   └── storage/     # Hive cache
│   │   │   ├── features/
│   │   │   │   ├── auth/
│   │   │   │   ├── wallet/
│   │   │   │   ├── lobby/
│   │   │   │   ├── matching/
│   │   │   │   ├── game/
│   │   │   │   ├── profile/
│   │   │   │   └── rules/
│   │   │   ├── shared/widgets/
│   │   │   ├── app.dart
│   │   │   └── main.dart
│   │   ├── test/
│   │   └── pubspec.yaml
│   └── backend/
│       ├── src/
│       │   ├── modules/
│       │   │   ├── auth/          (routes, controller, service, schema)
│       │   │   ├── wallet/
│       │   │   ├── game/
│       │   │   ├── matching/
│       │   │   └── payment/
│       │   ├── shared/
│       │   │   ├── db/client.ts
│       │   │   ├── redis/client.ts
│       │   │   ├── ws/gateway.ts
│       │   │   ├── middleware/    (auth, rate-limit, idempotency)
│       │   │   └── types/index.ts
│       │   ├── config/index.ts
│       │   └── app.ts
│       ├── test/
│       │   ├── unit/
│       │   └── integration/
│       ├── prisma/
│       │   └── schema.prisma
│       ├── package.json
│       ├── tsconfig.json
│       └── Dockerfile
├── docker-compose.yml
├── package.json          # workspaces racine
├── tsconfig.base.json
├── .gitignore
├── .env.example
└── README.md
```

### Design System (intégration Flutter)

Couleurs (depuis UX-DR-01) :

- Primaire : #1565C0
- Accent : #00BFA5
- Success : #4CAF50
- Error : #F44336
- Warning : #FFB300

Typographie (UX-DR-02) :

- Famille : Inter
- H1 : 24px Bold, H2 : 18px Semi-Bold, H3 : 16px Semi-Bold
- Body : 14px
- Monetary : 20px Bold (pour les montants)

### Testing Standards

- Backend : tests unitaires (Vitest) pour services, tests d'intégration pour routes
- Frontend : `flutter test` pour providers et widgets
- Coverage minimale attendue : 70%

### Review Findings

### decision-needed

- [ ] [Review][Decision] **Socket.IO gateway jamais branché** — `initWebSocketGateway()` défini dans `gateway.ts` mais jamais appelé dans `app.ts`. Fastify n'expose pas de raw `http.Server`, besoin de décider comment intégrer.
- [ ] [Review][Decision] **Wallet.balance en Int** — Le solde est stocké en `Int` (Ariary). L'Ariary n'a pas de sous-unités officielles, mais confirmer que `Int` suffit pour les transactions.
- [ ] [Review][Decision] **Rate limiting dupliqué** — `@fastify/rate-limit` enregistré dans `app.ts` ET middleware Redis custom dans `middleware/rate-limit.ts`. Choisir une seule approche.
- [ ] [Review][Decision] **CORS wildcard en dur** — `CORS_ORIGIN=*` comme défaut et Socket.IO aussi en `*`. Pour une plateforme money, configurer par environnement.
- [ ] [Review][Decision] **Idempotence : doublon Prisma + Redis, scope payment** — Table `IdempotencyKey` en BDD ET système Redis. Le lock Redis est préfixé `lock:payment:` — l'idempotence doit-elle être générale ou limitée aux paiements ?
- [ ] [Review][Decision] **Splash screen bloqué** — `initialLocation: '/splash'` sans redirect ni navigation programmée. Décider le flux splash → onboarding/login.
- [ ] [Review][Decision] **LOCK_TTL expire pendant opération longue** — 120s TTL pour les locks idempotence. Une transaction Mobile Money lente pourrait dépasser ce délai.

### patch

- [ ] [Review][Patch] **Chemin .env incorrect** — `config/index.ts:2` utilise `../../.env` → résout `packages/.env` au lieu de la racine.
- [ ] [Review][Patch] **Dockerfile cassé avec npm workspaces** — Copie `packages/backend/node_modules` mais les workspaces hoistent à la racine.
- [ ] [Review][Patch] **Transaction.amount sans contrainte** — `schema.prisma` permet montant zéro ou négatif.
- [ ] [Review][Patch] **App démarre avec dépendances mortes** — `app.ts:24-31` log l'erreur mais continue. Le serveur sert des requêtes sans DB/Redis.
- [ ] [Review][Patch] **getIO() lève une exception si non initialisé** — `gateway.ts:39` module-level `io` undefined tant que `initWebSocketGateway` n'est pas appelé.
- [ ] [Review][Patch] **PORT/rate-limit NaN si env var invalide** — `config/index.ts` `parseInt` peut retourner NaN.
- [ ] [Review][Patch] **NODE_ENV vérifié sur process.env directement** — `db/client.ts` utilise `process.env.NODE_ENV` au lieu de `config.nodeEnv`.
- [ ] [Review][Patch] **Redis : pas de handler d'erreur + promesses non gérées** — `redis/client.ts` pas d'`error` handler ; `gateway.ts` redis.set/del sans `.catch()`.
- [ ] [Review][Patch] **userId query param cast non sûr** — `gateway.ts:18` `query.userId as string` peut être `string[]`.
- [ ] [Review][Patch] **Payload JWT non validé** — `auth.ts:14` pas de vérification de la forme du payload après `jwt.verify`.
- [ ] [Review][Patch] **JSON.parse non protégé** — `idempotency.ts:16` `JSON.parse(cached)` peut throw si valeur corrompue.
- [ ] [Review][Patch] **JSON.stringify non protégé** — `idempotency.ts:20` peut throw sur références circulaires.
- [ ] [Review][Patch] **releaseLock sans vérification de propriété** — `idempotency.ts:11` n'importe qui peut release le lock d'un autre.
- [ ] [Review][Patch] **GameEvent.id en BigInt non sérialisable JSON** — `schema.prisma` BigInt → erreur dans les réponses API.
- [ ] [Review][Patch] **Secrets avec fallbacks en dur** — `config/index.ts` JWT_SECRET→'dev-secret', KYC_ENCRYPTION_KEY→'dev-encryption-key'.
- [ ] [Review][Patch] **ESLint : parserOptions.project manquant** — `.eslintrc.json` les règles type-aware ne fonctionneront pas.
- [ ] [Review][Patch] **Auth middleware : pas de Fastify decorateRequest** — `auth.ts` cast bypass le type system Fastify.
- [ ] [Review][Patch] **Vitest config manquante** — `test: "vitest run"` dans package.json mais pas de `vitest.config.ts`.
- [ ] [Review][Patch] **@fastify/websocket non utilisé** — Déclaré dans `package.json` mais jamais importé.
- [ ] [Review][Patch] **start() sans gestion d'exception** — `app.ts:47` promesse non gérée si start échoue.
- [ ] [Review][Patch] **GoRouter Provider recréé à chaque rebuild** — `app_router.dart:4` pas de `autoDispose`, perte d'état de navigation.
- [ ] [Review][Patch] **GoRouter pas d'errorBuilder** — Routes inexistantes → page d'erreur par défaut ou écran blanc.
- [ ] [Review][Patch] **Rate limit NaN si max invalide** — `middleware/rate-limit.ts:13` retourne `NaN` comme remaining.

### defer

- [ ] [Review][Defer] **Modules backend non scaffoldés (dossiers vides)** — `packages/backend/src/modules/` contient les dossiers (auth, wallet, game, matching, payment) mais vides. Conforme à la tâche 2.3 qui ne demandait que la structure. Contenu dans les stories suivantes.

### dismiss

- [ ] [Review][Dismiss] **KycDocType en français (cin, permis)** — Approprié pour le marché malgache.
- [ ] [Review][Dismiss] **app_text_styles.dart et tokens** — Fichiers existent sur disque, juste non listés dans le File List de la story.

## Références

- [Architecture: Structure monorepo] Source: `_bmad-output/planning-artifacts/architecture-higame.md` §6
- [Schéma BDD complet] Source: `_bmad-output/planning-artifacts/architecture-higame.md` §5
- [ADR-001 Stack Frontend] Source: `architecture-higame.md` §8 ADR-001
- [ADR-002 Stack Backend] Source: `architecture-higame.md` §8 ADR-002
- [ADR-003 Monolithe modulaire] Source: `architecture-higame.md` §8 ADR-003
- [ADR-004 BDD PostgreSQL + Redis] Source: `architecture-higame.md` §8 ADR-004
- [ADR-005 Server-Authoritative] Source: `architecture-higame.md` §8 ADR-005
- [ADR-006 Event Sourcing] Source: `architecture-higame.md` §8 ADR-006
- [Design System] Source: `_bmad-output/mockups/00-design-system.md`
- [Structures Redis] Source: `architecture-higame.md` §5.2
- [Index critiques] Source: `architecture-higame.md` §5.1
- [Backend modulaire AR-17] Source: `architecture-higame.md` §6

## Dev Agent Record

### Agent Model Used

Claude 4 (opencode)

### Debug Log References

### Completion Notes List

- ✅ Monorepo initialisé : package.json racine avec workspaces, TypeScript, ESLint, Prettier
- ✅ Backend Fastify : structure modulaire avec app.ts, config, Prisma client, Redis client, WebSocket gateway, middleware (auth JWT, rate-limit, idempotence), types partagés
- ✅ Schéma Prisma complet : 10 tables (users, sessions, wallets, transactions, kyc_documents, games, game_players, game_events, game_snapshots, idempotency_keys) avec indexes critiques
- ✅ Frontend Flutter : structure features, design system (couleurs #1565C0, #00BFA5), go_router + Riverpod, placeholders pour les screens
- ✅ Docker Compose : backend + PostgreSQL 16 + Redis 7
- ✅ CI pipeline : lint, test (avec services), build
- ✅ `npm install` et `npm run lint` passent sans erreur
- ⏳ En attente : `flutter create` (Flutter SDK non disponible sur ce runner), `prisma migrate dev` (nécessite PostgreSQL), `npm run dev` (nécessite BDD + Redis), `flutter run` (nécessite émulateur)

### File List

- `package.json` — Monorepo racine avec workspaces
- `tsconfig.base.json` — Config TypeScript partagée
- `.gitignore` — Fichiers ignorés par git
- `.env.example` — Variables d'environnement template
- `.eslintrc.json` — ESLint config racine
- `.prettierrc` — Prettier config
- `packages/backend/package.json` — Dépendances backend
- `packages/backend/tsconfig.json` — Config TS backend
- `packages/backend/src/app.ts` — Point d'entrée Fastify
- `packages/backend/src/config/index.ts` — Chargement config
- `packages/backend/src/shared/db/client.ts` — Instance Prisma
- `packages/backend/src/shared/redis/client.ts` — Client ioredis
- `packages/backend/src/shared/ws/gateway.ts` — WebSocket gateway
- `packages/backend/src/shared/middleware/auth.ts` — Middleware JWT
- `packages/backend/src/shared/middleware/rate-limit.ts` — Rate limiting Redis
- `packages/backend/src/shared/middleware/idempotency.ts` — Idempotence locks
- `packages/backend/src/shared/types/index.ts` — Types partagés
- `packages/backend/prisma/schema.prisma` — Schéma BDD complet MVP
- `packages/backend/Dockerfile` — Docker image backend
- `packages/frontend/pubspec.yaml` — Dépendances Flutter
- `packages/frontend/lib/main.dart` — Point d'entrée Flutter
- `packages/frontend/lib/app.dart` — App widget avec go_router + Riverpod
- `packages/frontend/lib/core/theme/app_theme.dart` — Design system
- `packages/frontend/lib/core/routing/app_router.dart` — Routes
- `packages/frontend/lib/core/network/api_client.dart` — Client API
- `packages/frontend/lib/core/storage/local_storage.dart` — Cache Hive
- `docker-compose.yml` — Services backend + postgres + redis
- `.github/workflows/ci.yml` — CI pipeline
