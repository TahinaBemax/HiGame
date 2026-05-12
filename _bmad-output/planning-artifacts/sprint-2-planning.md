---
sprint_id: "S02"
sprint_duration: "10 jours (2 semaines)"
sprint_goal: "Auth complète — un joueur peut s'inscrire, se connecter, uploader son KYC et voir les règles"
stories:
  - "1.3 — Inscription par téléphone (OTP SMS)"
  - "1.4 — Upload KYC (CIN/permis)"
  - "1.5 — Page Règles du Domino + Protection des données"
dev_profile: "Junior solo avec IA assistant"
depends_on: "Sprint 1 (monorepo, splash, onboarding, Docker)"
---

# Sprint 2 Planning — HiGame MVP

## Objectif du Sprint

**"Un joueur s'inscrit avec son téléphone, reçoit un OTP, valide son compte, upload son CIN, et peut lire les règles."**

À la fin de ce sprint, le flow suivant est fonctionnel :
1. L'utilisateur saisit son numéro +261
2. Il reçoit un code OTP par SMS
3. Il valide → son compte est créé avec JWT
4. Il upload sa pièce d'identité (CIN/permis)
5. Son KYC passe en "En attente de vérification"
6. Il peut consulter les règles du Domino

---

## Stories du Sprint

| # | Story | FRs | NFRs | UX-DRs | Difficulté | Estimation |
|:-:|-------|:---:|:----:|:------:|:----------:|:----------:|
| S2.1 | Inscription OTP — Backend (auth module, JWT, SMS) | FR-01 | NFR-01, NFR-13, NFR-14, NFR-17, NFR-18 | UX-DR-09 | 🟡 Moyen | 3 jours |
| S2.2 | Inscription OTP — Frontend (écran, inputs, validation) | FR-01 | — | UX-DR-09 | 🟡 Moyen | 2 jours |
| S2.3 | Upload KYC — Backend (chiffrement, upload, statuts) | FR-02 | NFR-02, NFR-07, NFR-16 | UX-DR-10 | 🟡 Moyen | 2 jours |
| S2.4 | Upload KYC — Frontend (camera, preview, statuts) | FR-02 | — | UX-DR-10 | 🔵 Facile | 1 jour |
| S2.5 | Règles du Domino + Protection des données | FR-16, FR-22 | NFR-08, NFR-17, NFR-18 | UX-DR-20 | 🔵 Facile | 1 jour |
| | **Tests + Revue + Rétro** | | | | | 1 jour |
| | **Total** | **4 FRs** | **8 NFRs** | **3 UX-DRs** | | **10 jours** |

---

## Déroulé Jour par Jour

---

### Jour 1 — Auth Backend : structure du module

**Story :** 1.3 (partie 1/4)

**Objectif :** Créer le module auth backend complet avec les routes, le service, et la génération OTP.

#### Tâches

- [ ] Créer la structure du module auth (routes, controller, service, schema)
- [ ] Implémenter POST /auth/register (phone number validation)
- [ ] Générer et stocker le code OTP en Redis (expire 5min)
- [ ] Implémenter POST /auth/verify-otp (validation OTP, création user)
- [ ] Générer JWT access + refresh tokens
- [ ] Implémenter POST /auth/refresh (nouveau access token)
- [ ] Logger les tentatives pour rate limiting

#### Prompts IA

<details>
<summary>Prompt 1 : Structure complète du module auth backend</summary>

```
Génère la structure complète du module auth pour le backend Fastify.

Créer les fichiers dans packages/backend/src/modules/auth/ :

1. auth.routes.ts — 5 routes :
   - POST /auth/register → registerHandler (body: { phone: string })
   - POST /auth/verify-otp → verifyOtpHandler (body: { phone: string, otp: string })
   - POST /auth/refresh → refreshHandler (body: { refreshToken: string })
   - GET /auth/me → meHandler (protégée par JWT, retourne l'utilisateur courant)
   - POST /auth/logout → logoutHandler (invalide le refresh token)

2. auth.controller.ts — handlers qui appellent authService
   - Chaque handler valide le body avec Zod (auth.schema.ts)
   - Wrappe dans try/catch, retourne les erreurs standard

3. auth.service.ts — logique métier :
   - register(phone) : normalise le numéro (+261XXXXXXXXX), vérifie si déjà existant, génère OTP 4 chiffres (random 1000-9999), stocke en Redis avec clé "otp:{phone}", expire 5min, retourne { message: "OTP envoyé" }
   - verifyOtp(phone, otp) : lit le code Redis, compare, si OK crée l'utilisateur en base (pseudo auto "Joueur" + 4 chiffres aléatoires), génère JWT access+refresh, supprime le code OTP de Redis, retourne { accessToken, refreshToken, user }
   - refresh(refreshToken) : vérifie le refresh token JWT, vérifie qu'il existe en base (users.refreshToken), génère un nouveau access token
   - generateTokens(userId) : accessToken 15min, refreshToken 7 jours

4. auth.schema.ts — schémas Zod pour valider chaque body

Le service doit être testable : injecte Prisma + Redis en dépendance.
```
</details>

<details>
<summary>Prompt 2 : Génération OTP avec stockage Redis</summary>

```
Ajoute au module auth la génération et validation OTP avec Redis.

1. Dans auth.service.ts, fonction generateOtp(phone: string) :
   - Génère un code aléatoire entre 1000 et 9999 (Math.random() × 9000 + 1000)
   - Stocke dans Redis avec la clé "otp:{phone_normalisé}" (EX: 300 secondes = 5min)
   - Log le code en console pour le dev (car le vrai SMS n'existe pas encore)
   - Dans le log : "[OTP] Pour {phone} → code: {code}"

2. Fonction verifyOtp(phone, code) :
   - Récupère depuis Redis la clé "otp:{phone}"
   - Si pas trouvé → throw "Code expiré ou inexistant"
   - Si code != code stocké → throw "Code incorrect", incrémente "otp_attempts:{phone}"
   - Si code match → supprime la clé Redis, efface "otp_attempts:{phone}"
   
3. Fonction getOtpAttempts(phone) : 
   - Lit le compteur Redis "otp_attempts:{phone}"
   - Si ≥ 3 → throw "Trop de tentatives, bloqué 15min"
   - Stocker le blocage avec une clé "otp_blocked:{phone}" EX: 900 (15min)
   - Vérifier le blocage avant chaque tentative

4. Le controller register vérifie d'abord "otp_blocked:{phone}" avant d'autoriser une nouvelle tentative.
```
</details>

<details>
<summary>Prompt 3 : JWT generation + refresh token</summary>

```
Ajoute la gestion des tokens JWT dans le module auth.

1. Dans auth.service.ts :
   - generateAccessToken(userId: string) :
     * Payload: { sub: userId, iat, type: "access" }
     * Sign avec JWT_SECRET (env), expiresIn: "15m"
     * Utilise l'API @fastify/jwt.sign()

   - generateRefreshToken(userId: string) :
     * Payload: { sub: userId, iat, type: "refresh" }
     * Sign avec JWT_REFRESH_SECRET (env), expiresIn: "7d"
     * Hash le token avec bcrypt (cost 12) et stocke dans user.refreshToken
     * Retourne le token non-hashé (c'est celui qu'on donne au client)

   - verifyRefreshToken(token: string) :
     * Jwt.verify avec JWT_REFRESH_SECRET (gère expiration → throw 401)
     * Vérifie le hash bcrypt match le refreshToken stocké en base
     * Si match → génère nouveau accessToken

2. Décorateur Fastify :
   - Crée un plugin Fastify qui ajoute authenticate décorateur
   - Vérifie le header "Authorization: Bearer <token>"
   - Décode le JWT, attache l'utilisateur à request.user
   - Si token invalide/expiré → 401 { error: "Token invalide", code: "TOKEN_EXPIRED" }

3. Middleware rate limiting :
   - Compteur Redis par IP : "rate_limit:{ip}" incrémente, expire 60s
   - Limite : 100 requêtes/minute/IP
   - Si dépassé → 429 Too Many Requests
```
</details>

<details>
<summary>Prompt 4 : Normalisation téléphone + validation</summary>

```
Crée une fonction utilitaire de validation téléphone dans packages/backend/src/lib/phone.ts.

Règles :
1. formatPhone(phone: string) → string normalisée :
   - Supprime tous les caractères non-digitaux
   - Si commence par "0" → remplacer "0" par "+261"
   - Si commence par "261" → ajouter "+" devant
   - Si commence par "+261" → garder tel quel
   - À la fin : format "+261XXXXXXXXX" (13 caractères avec indicatif)
   - Lancer Error si le format final n'est pas valide

2. isValidPhone(phone: string) → boolean :
   - Vérifie le format final "+261" suivi de 9 chiffres
   - Doit commencer par 032, 033, 034, 037, 038 (opérateurs malgaches)

3. maskPhone(phone: string) → string masquée pour logs :
   - "+261 34 XX XX 67" → afficher les 4 derniers chiffres

Exporte les 3 fonctions. Teste avec des cas :
- "0341234567" → "+261341234567" ✓
- "+261 34 12 34 56" → "+261341234567" ✓
- "0321234567" → "+261321234567" ✓
```
</details>

#### Définition de fait (Jour 1)

- [ ] POST /auth/register → OTP stocké dans Redis, log en console
- [ ] POST /auth/verify-otp → si code OK → retour JWT + user
- [ ] POST /auth/refresh → nouveau access token
- [ ] GET /auth/me avec Bearer → retourne l'utilisateur
- [ ] 3 tentatives OTP → blocage 15min
- [ ] Rate limiting 100/min/IP → 429 si dépassé

---

### Jour 2 — Auth Backend : tests + hooks Prisma

**Story :** 1.3 (partie 2/4)

**Objectif :** Tester le module auth, ajouter les hooks Prisma (password hash auto), et préparer le refresh token en base.

#### Tâches

- [ ] Ajouter le champ refreshToken (hashé) dans la table users
- [ ] Ajouter un hook Prisma pour hasher automatiquement
- [ ] Écrire les tests du module auth
- [ ] Tester les cas d'erreur (phone invalide, OTP expiré, trop de tentatives)
- [ ] Ajouter le endpoint GET /auth/me avec l'utilisateur complet

#### Prompts IA

<details>
<summary>Prompt 1 : Migration Prisma pour refreshToken + hook bcrypt</summary>

```
1. Crée une migration Prisma pour ajouter le champ refreshToken à la table users :
   - refreshToken: String? (nullable, stocke le hash bcrypt du refresh token)
   - Ajoute aussi lastLoginAt: DateTime? et blockedUntil: DateTime?

2. Crée un fichier packages/backend/src/lib/prisma.ts qui exporte :
   - L'instance PrismaClient étendue avec des middlewares (hooks)
   - Hook "beforeSave" sur le champ refreshToken : si modifié, le hasher avec bcrypt (cost 12)
   - Pas de hook sur users.password (pas de password dans notre auth OTP)

3. Le middleware :
   - Ne hasher que si la valeur a changé
   - Utiliser bcrypt.genSalt(12) + bcrypt.hash(token, salt)
   - Ne pas hasher si null ou undefined (cas de logout)

Commande : npx prisma migrate dev --name add_refresh_token
```
</details>

<details>
<summary>Prompt 2 : Tests Vitest pour le module auth</summary>

```
Génère des tests d'intégration pour le module auth dans packages/backend/src/__tests__/auth.test.ts.

Framework : Vitest + une instance Fastify de test (app.ts).

Setup :
- Avant tous les tests : lancer les migrations de test (ou utiliser une DB de test)
- Créer une instance Fastify avec le module auth enregistré
- Nettoyer la base et Redis après chaque test

Tests :
1. "POST /auth/register avec un numéro valide" → 201, { message: "OTP envoyé" }, vérifier que Redis contient le code

2. "POST /auth/register avec un numéro invalide" → 400, { error: "Numéro invalide" }
   - "+261" trop court → 400
   - "abcd" → 400
   - "034" → 400

3. "POST /auth/verify-otp avec un bon code" → 200, { accessToken, refreshToken, user }
   - D'abord register, récupérer le code depuis Redis mock, puis verify

4. "POST /auth/verify-otp avec mauvais code" → 401, { error: "Code incorrect" }

5. "POST /auth/verify-otp après 3 tentatives" → 429, { error: "Bloqué 15 minutes" }

6. "POST /auth/verify-otp avec code expiré (après 5min)" → 401, { error: "Code expiré" }
   - Mock Redis pour retourner null

7. "GET /auth/me avec token valide" → 200, { id, phone, pseudo, statusKyc }

8. "GET /auth/me sans token" → 401

9. "GET /auth/me avec token invalide" → 401

10. "POST /auth/refresh avec refresh token valide" → 200, { accessToken }

Mock Redis dans les tests : crée un mock RedisClient ou utilise une instance Redis de test.
```
</details>

<details>
<summary>Prompt 3 : Plugin Fastify pour l'authentification</summary>

```
Génère un plugin Fastify pour l'authentification JWT.

Fichier : packages/backend/src/plugins/auth.ts

Le plugin :
1. Enregistre @fastify/jwt avec les secrets depuis env (JWT_SECRET, JWT_REFRESH_SECRET)
2. Ajoute un décorateur fastify.authenticate qui :
   - Vérifie le header Authorization: Bearer <token>
   - Décode le JWT (vérifie expiration + signature)
   - Vérifie que le type du token est "access" (pas "refresh")
   - Charge l'utilisateur depuis Prisma (users.findUnique)
   - Attache l'utilisateur à request.user
   - Si erreur → 401 avec { error: "Non authentifié", code: "UNAUTHORIZED" }
3. Ajoute un décorateur request.getUser() qui retourne l'utilisateur (typé)

Utilisation dans une route :
```typescript
app.get('/auth/me', {
  preHandler: [app.authenticate]
}, async (request, reply) => {
  return request.user
})
```

Ajoute aussi la gestion des CORS pour que le frontend Flutter puisse appeler l'API.
```
</details>

#### Définition de fait (Jour 2)

- [ ] `npx vitest run` → tests auth passent
- [ ] refreshToken hashé en base avec bcrypt
- [ ] GET /auth/me retourne l'utilisateur avec token valide
- [ ] GET /auth/me retourne 401 sans token

---

### Jour 3 — Auth Frontend : écran login (UI)

**Story :** 1.3 (partie 3/4)

**Objectif :** Créer l'écran d'inscription avec input téléphone.

#### Tâches

- [ ] Créer LoginScreen avec header et input téléphone
- [ ] Masque de saisie +261 XX XX XXX XX
- [ ] Validation 9 chiffres, bouton activé/désactivé
- [ ] Checkbox CGU avec lien
- [ ] État "envoi OTP" avec loading

#### Prompts IA

<details>
<summary>Prompt 1 : Écran Login avec input téléphone + masque</summary>

```
Génère un LoginScreen Flutter complet.

Layout :
- Fond #F5F5F5
- Header "Créer compte" H1 #212121 avec back arrow (Navigator.pop)
- Carte blanche (Card radius 12px, padding 24px)
  - Label "Numéro téléphone" Body #757575
  - Input phone : préfixe fixe "+261" affiché à gauche, input de 9 chiffres max
    - Format automatique : XX XX XXX XX (espaces tous les 2 chiffres)
    - Clavier : numeric seulement
    - Border #E0E0E0 (defaut) / #1565C0 (focus) / #F44336 (erreur)
    - Afficher "⚠ Numéro invalide" si pas 9 chiffres après perte de focus
  - Checkbox "J'accepte les CGU et Privacy" (body small)
    - Les mots CGU et Privacy sont des liens bleus #1565C0
    - Checkbox Material avec style custom
  - Button "Recevoir le code" (accent #00BFA5, disabled if < 9 chiffres OR checkbox pas cochée)
    - Loader spinner quand loading

Logique Riverpod :
- phoneProvider : StateNotifier<String> avec validation temps réel
- cguAcceptedProvider : StateProvider<bool>
- Envoi : appeller POST /auth/register via Dio
  - Succès → cacher l'input phone, afficher la section OTP
  - Erreur 429 → toast "Trop de demandes, réessayez dans 15 minutes"
  - Erreur réseau → toast "Erreur réseau"
```
</details>

<details>
<summary>Prompt 2 : Provider Riverpod pour l'inscription</summary>

```
Génère un provider Riverpod pour la logique d'inscription.

Fichier : lib/features/auth/providers/register_provider.dart

State : RegisterState
  - phone: String (format +261XXXXXXXXX après normalisation)
  - phoneError: String? (null si valide, message si invalide)
  - step: enum { PHONE_INPUT, OTP_INPUT, LOADING, SUCCESS, ERROR }
  - otpCode: String (4 chiffres)
  - otpError: String?
  - timerSeconds: int (countdown renvoi OTP, 30s)
  - errorMessage: String?

Functions :
  - setPhone(rawPhone) : nettoie, normalise, valide, met à jour phoneError
  - sendOtp() : POST /auth/register, passe à step OTP_INPUT, démarre timer 30s
  - setOtpDigit(index, digit) : remplit un digit
  - verifyOtp() : POST /auth/verify-otp
    - Succès → sauvegarde token dans Hive, step = SUCCESS, navigue /kyc
    - Erreur → otpError = message, reset inputs
    - 429 → step = ERROR "Trop de tentatives"
  - resendOtp() : réinitialise le timer et renvoie
  - startTimer() : Timer.periodic 1s, décrémente, à 0 permet renvoi

Utilise DioService (un provider Dio partagé) pour les appels API.
```
</details>

<details>
<summary>Prompt 3 : Client HTTP Dio configuré pour l'API</summary>

```
Génère un provider Dio partagé dans lib/core/network/dio_provider.dart.

Configuration :
- Base URL depuis env ou défaut "http://10.0.2.2:3000" (Android emulator → host)
- Timeout connect: 10s, receive: 30s
- Interceptor pour ajouter le header Authorization: Bearer <token> depuis Hive
- Interceptor pour loguer les requêtes en dev (method, url, status)
- Interceptor pour gérer les erreurs 401 : supprimer token Hive, naviguer /login

Fonctions utilitaires :
- apiGet<T>(path, queryParams) → T
- apiPost<T>(path, body) → T
- apiPut<T>(path, body) → T
- apiDelete<T>(path) → T

Les types T sont les DTOs définis dans lib/core/models/.

Fournit un provider Riverpod dioProvider qui retourne l'instance Dio.
```
</details>

#### Définition de fait (Jour 3)

- [ ] Écran "Créer compte" visible avec input téléphone
- [ ] Masque +261 XX XX XXX XX fonctionnel
- [ ] Bouton "Recevoir le code" désactivé si < 9 chiffres
- [ ] Checkbox CGU requise
- [ ] Appel API POST /auth/register fonctionnel

---

### Jour 4 — Auth Frontend : OTP + validation

**Story :** 1.3 (partie 4/4)

**Objectif :** Écran OTP 4 chiffres, validation auto, timer renvoi, gestion d'erreurs.

#### Tâches

- [ ] Créer la section OTP (4 inputs séparés)
- [ ] Auto-validation quand 4 chiffres saisis
- [ ] Timer "Renvoyer dans Xs" avec bouton
- [ ] Gestion des erreurs (code incorrect, expiré)
- [ ] Blocage 15 minutes (état max tentatives)
- [ ] Redirection vers KYC après succès

#### Prompts IA

<details>
<summary>Prompt 1 : Section OTP avec 4 inputs + auto-validation</summary>

```
Génère le widget OTPInput et l'écran OTP pour HiGame.

OTPInput Widget :
- 4 champs de texte séparés, chacun 48×48px, border radius 12px
- Bordure #E0E0E0 (defaut), #1565C0 (focus), #F44336 (erreur)
- Focus automatique : quand je saisis un chiffre dans le champ 1, le focus passe au champ 2
- Backspace sur champ vide → focus sur champ précédent
- Clavier : numeric, max 1 chiffre par champ
- Layout : Row centré avec spacing 12px entre chaque input

Écran OTP (s'affiche après l'envoi du code) :
- Texte "Code OTP reçu par SMS" en Body
- Sous-texte "Renvoyer dans {X}s" (timer) ou bouton "Renvoyer" (actif après 30s)
- Message d'erreur "Code incorrect" en rouge si erreur (bordure inputs + texte)
- Message "Bloqué 15 minutes" si max tentatives atteint
- Loader : quand la validation est en cours

Logique :
- `provider.otpCode` est un StateNotifier avec 4 slots (chiffres)
- Quand le 4e digit est saisi, déclencher auto verifyOtp()
- Si erreur : vider les inputs, focus premier champ, afficher erreur
- Timer : utilise Timer.periodic(1s) dans le provider, décrémente de 30 à 0
  - À 0 : isResendAvailable = true, bouton "Renvoyer" cliquable
  - Renvoyer → POST /auth/register, reset timer
```
</details>

<details>
<summary>Prompt 2 : Gestion des erreurs + navigation post-inscription</summary>

```
Ajoute la gestion des erreurs dans le provider d'inscription et la navigation post-succès.

1. Dans register_provider.dart, ajoute la gestion des cas d'erreur OTP :
   - 400 "Code incorrect" → afficher message rouge, reset inputs
   - 401 "Code expiré" → rediriger vers l'écran phone (recommencer)
   - 429 "Trop de tentatives" → désactiver tout, afficher "Bloqué 15 minutes"
   - Timeout réseau → toast "Erreur de connexion"
   - Autre → toast "Erreur inattendue, réessayez"

2. Après verifyOtp succès :
   - Sauvegarder accessToken et refreshToken dans Hive
   - Naviguer vers /kyc (remplacement, pas push : context.go('/kyc'))
   - Mettre à jour le provider d'auth global (auth_provider.dart)

3. Écran "max tentatives" :
   - Afficher un message d'erreur bloquant
   - Bouton "Retour" → revenir à l'écran phone
   - Compter le temps restant avant déblocage (depuis le message d'erreur)

4. Toast/Snackbar :
   - Succès enregistrement → Snackbar vert "Compte créé !"
   - Erreur réseau → Snackbar rouge "Vérifie connexion"
   - Code renvoyé → Snackbar jaune "Nouveau code envoyé"
```
</details>

#### Définition de fait (Jour 4)

- [ ] 4 inputs OTP, focus automatique, auto-validation
- [ ] Timer 30s avant renvoi
- [ ] Code incorrect → message rouge + reset
- [ ] 3 tentatives → blocage 15min
- [ ] OTP valide → JWT sauvegardé + redirection /kyc

---

### Jour 5 — KYC Backend

**Story :** 1.4 (partie 1/2)

**Objectif :** Backend d'upload KYC avec chiffrement AES-256, statuts, et endpoint admin.

#### Tâches

- [ ] Créer le module KYC backend
- [ ] Endpoint POST /kyc/upload (multipart, AES-256)
- [ ] Endpoint GET /kyc/status (retourne statut actuel)
- [ ] Endpoint PUT /kyc/verify (admin uniquement)
- [ ] Endpoint GET /kyc/pending (admin, liste des KYC en attente)
- [ ] Stockage des fichiers chiffrés

#### Prompts IA

<details>
<summary>Prompt 1 : Module KYC backend complet</summary>

```
Génère le module KYC backend dans packages/backend/src/modules/auth/ (ou un sous-dossier kyc/).

1. kyc.schema.ts — Schémas Zod :
   - uploadBody: { documentType: enum("CIN", "PERMIS") }
   - verifyBody: { kycId: string, status: enum("VERIFIED", "REJECTED"), rejectionReason?: string }

2. kyc.service.ts :
   - uploadKyc(userId, documentType, fileBuffer) :
     1. Vérifier que l'utilisateur n'a pas déjà un KYC PENDING ou VERIFIED
     2. Si oui, throw "KYC déjà soumis"
     3. Chiffrer le buffer du fichier avec AES-256-GCM (clé depuis env KYC_ENCRYPTION_KEY)
     4. Stocker le fichier chiffré dans uploads/kyc/{userId}_{timestamp}.enc
     5. Créer un enregistrement kyc_documents en base (status: PENDING)
     6. Mettre à jour users.statusKyc = "PENDING"
     7. Retourner { status: "PENDING", message: "Document soumis" }
   
   - getKycStatus(userId) : retourne le dernier kyc_document de l'utilisateur
   
   - verifyKyc(kycId, status, rejectionReason?) :
     1. Mettre à jour le kyc_document (VERIFIED/REJECTED)
     2. Mettre à jour users.statusKyc
     3. Si VERIFIED : débloquer toutes les fonctionnalités
     4. Si REJECTED : permettre au joueur de re-soumettre
   
   - getPendingKycs(page, limit) : liste paginée des KYC en attente

3. kyc.controller.ts — Handlers avec :
   - Validation du body avec Zod
   - Gestion du multipart (fastify-multipart ou @fastify/multipart)
   - Vérification que le fichier est une image (< 10MB)
   - Types acceptés : jpg, png
   - Compression d'image avant upload (optionnel)

4. kyc.routes.ts — Routes :
   - POST /kyc/upload (auth requise)
   - GET /kyc/status (auth requise)
   - PUT /kyc/verify (auth + rôle admin)
   - GET /kyc/pending (auth + rôle admin)
```
</details>

<details>
<summary>Prompt 2 : Chiffrement AES-256 des fichiers KYC</summary>

```
Génère un module de chiffrement dans packages/backend/src/lib/encryption.ts.

Fonctions :
1. encryptFile(buffer: Buffer, key: string) → { encrypted: Buffer, iv: string, authTag: string }
   - Algorithme : aes-256-gcm
   - Générer un IV aléatoire (16 bytes)
   - Dériver la clé : utiliser crypto.createHash('sha256').update(key).digest() pour avoir 32 bytes
   - Encrypter avec crypto.createCipheriv
   - Retourner le buffer chiffré + IV (hex) + authTag (hex)

2. decryptFile(encrypted: Buffer, iv: string, authTag: string, key: string) → Buffer
   - Même dérivation de clé
   - Utiliser crypto.createDecipheriv
   - Vérifier l'authTag pour l'intégrité

3. generateEncryptionKey() → string
   - crypto.randomBytes(32).toString('hex')
   - Utility pour générer une clé à mettre dans .env

Exporte les 3 fonctions. Ajoute la gestion d'erreur :
- Si IV invalide → throw "Données corrompues"
- Si authTag ne match pas → throw "Intégrité compromise"

.env ajoute : KYC_ENCRYPTION_KEY=<32-bytes-hex>
```
</details>

<details>
<summary>Prompt 3 : Gestion des fichiers uploadés avec Fastify</summary>

```
Ajoute la gestion des fichiers multipart dans Fastify.

1. Enregistre le plugin @fastify/multipart dans le serveur :
   - limits: { fileSize: 10 * 1024 * 1024 } (max 10MB)
   - addToBody: false

2. Dans le handler POST /kyc/upload :
   - Lire le fichier depuis la requête (request.file())
   - Vérifier le type MIME : image/jpeg, image/png seulement
   - Vérifier la taille (< 10MB, déjà fait par le plugin)
   - Convertir le fichier en Buffer
   - Appeler encryptFile() puis stocker sur disque
   
3. Stockage :
   - Créer le dossier uploads/kyc/ à la racine du backend
   - Nom du fichier : {userId}_{timestamp}.enc
   - Utiliser fs.promises.writeFile
   - Le chemin stocké en base est relatif (uploads/kyc/{filename})

4. Crée un dossier uploads/ avec un .gitkeep dedans
   - Ajouter uploads/ dans .gitignore (on ne commit pas les fichiers uploadés)
```

#### Définition de fait (Jour 5)

- [ ] POST /kyc/upload → fichier chiffré AES-256 stocké, statut PENDING
- [ ] Fichier non déchiffrable sans la clé (tester en ouvrant le fichier .enc)
- [ ] GET /kyc/status → retourne le statut actuel
- [ ] Fichier > 10MB ou mauvais type → rejeté

---

### Jour 6 — KYC Frontend + Profil statut

**Story :** 1.4 (partie 2/2)

**Objectif :** Écran KYC avec camera/gallery, preview, statuts.

#### Tâches

- [ ] Écran KYC avec sélecteur type pièce
- [ ] Bouton "Prendre en photo" / "Choisir galerie"
- [ ] Preview de l'image avant envoi
- [ ] Statuts visuels (attente, vérifié, rejeté)
- [ ] Appel API POST /kyc/upload

#### Prompts IA

<details>
<summary>Prompt 1 : Écran KYC avec camera + galerie + preview</summary>

```
Génère un KycScreen Flutter complet.

Layout (fond #F5F5F5) :
- Header "Vérification d'identité" H1 #212121
- Carte blanche :
  - Sélecteur type pièce : deux chips/badges "Carte d'identité (CIN)" / "Permis de conduire"
    - Selected: fond #1565C0 text white
    - Unselected: fond #E0E0E0 text #757575
  - Zone photo : carré gris (border dashed #BDBDBD, radius 12px)
    - Si pas de photo : icône appareil photo + texte "Prendre en photo"
    - Si photo sélectionnée : preview de l'image
  - Deux boutons :
    - "Prendre en photo" → ouvre camera native (image_picker)
    - "Choisir galerie" → ouvre galerie (image_picker)
  - Button "Envoyer" (accent #00BFA5, disabled si pas de photo)

Logique :
- image_picker package pour camera/gallery
- Recadrage optionnel (image_cropper)
- Preview de l'image avant envoi
- Appel POST /kyc/upload (multipart) via Dio
- Pendant l'upload : spinner sur le bouton
- Succès → afficher statut "En attente" avec horloge

Statuts KYC (3 écrans différents) :
1. PENDING (horloge orange) : icône horloge + "Vérification en cours...", "Nous vérifions votre pièce d'identité"
2. VERIFIED (check vert) : icône check #4CAF50 + "Vérifié !", "Vous pouvez jouer avec de l'argent réel"
3. REJECTED (croix rouge) : icône croix #F44336 + "Rejeté" + motif, bouton "Réessayer" → re-upload

Provider Riverpod : kyc_provider.dart avec fetchStatus(), uploadKyc(type, file), les 3 états.
```
</details>

<details>
<summary>Prompt 2 : Intégration image_picker + compression</summary>

```
Ajoute la gestion de la camera et galerie dans le KYC.

1. Dans pubspec.yaml, ajouter :
   - image_picker: ^1.1.0
   - image_cropper: ^7.0.0 (pour recadrer l'image)
   - (optionnel) flutter_image_compress: ^2.3.0 (pour réduire la taille avant upload)

2. Fonctions dans kyc_provider.dart :
   - pickFromCamera() : ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1024, maxHeight: 1024, imageQuality: 80)
   - pickFromGallery() : ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1024, maxHeight: 1024, imageQuality: 80)
   - cropImage(path) : ImageCropper().cropImage(sourcePath: path, aspectRatio: 3/4)
   - compressImage(path) : optionnel, si besoin de réduire la taille

3. Upload via multipart :
   - Créer FormData avec le fichier + le documentType
   - Dio().post('/kyc/upload', data: formData, options: Options(contentType: 'multipart-form-data'))
   - Afficher la progression (optionnel)
   - Gérer les erreurs (taille > 10MB, type invalide)

4. États de l'image :
   - Aucune : placeholder gris
   - Sélectionnée : preview rectangulaire (aspect ratio ~3:4 comme une carte d'identité)
   - Uploading : spinner overlay sur l'image
   - Uploaded : miniature + badge "Envoyé"
```
</details>

#### Définition de fait (Jour 6)

- [ ] Écran KYC avec sélecteur type + camera/gallery
- [ ] Preview de l'image avant envoi
- [ ] Upload → statut "En attente"
- [ ] Statuts visuels (attente/vérifié/rejeté)
- [ ] Rejet → motif affiché + bouton réessayer

---

### Jour 7 — Règles du Domino + Protection données

**Story :** 1.5

**Objectif :** Écran règles et mesures de protection des données.

#### Tâches

- [ ] Créer RulesScreen avec sections
- [ ] Contenu complet des règles malgaches
- [ ] Accessible sans authentification
- [ ] Protection données (frontend : mention, backend : hook)

#### Prompts IA

<details>
<summary>Prompt 1 : Écran Règles du Domino complet</summary>

```
Génère un RulesScreen Flutter avec tout le contenu des règles du Domino.

Layout :
- Header "Règles du Domino" H1 #212121 avec back arrow
- ScrollView avec sections expansibles (ExpansionTile Material) :

1. "Objectif" — Être le premier joueur à poser toutes ses tuiles, ou avoir le score le plus bas si blocage

2. "Mise en place" — 28 tuiles double-6, mélangées. 1v1 → 7 tuiles chacun. 4 joueurs → 5 tuiles chacun. Le reste = talon (pioche)

3. "Déroulement" — Le joueur avec le double le plus fort commence. À chaque tour : poser une tuile sur une extrémité compatible. Si pas de tuile jouable → piocher. Si pioche vide → passer.

4. "Extrémités" — On pose en alignant les points. Les doubles se posent perpendiculairement.

5. "Pioche" — Quand tu n'as pas de tuile jouable. Tu pioches jusqu'à avoir une tuile jouable ou que le talon soit vide.

6. "Blocage" — Si personne ne peut jouer et talon vide → la manche est bloquée. Calcul des points restants.

7. "Fin de manche" — Domino! (dernière tuile posée) OU Blocage. Le gagnant marque la somme des points des tuiles des adversaires.

8. "Score" — Le premier à atteindre 100 points gagne la partie. (Configurable selon salon.)

9. "Variante malgache" — Règles spécifiques : on peut poser sur les 4 extrémités après un double. Le double compte pour son nombre de points x2. (Ajoute tes règles locales ici.)

Chaque section a un petit icône à gauche (émoticône ou MaterialIcon).
Fond #F5F5F5, cards blanches radius 12px pour chaque section.
```
</details>

<details>
<summary>Prompt 2 : Protection données + mentions légales + hooks backend</summary>

```
1. Frontend — Ajoute une section "Protection des données" dans le RulesScreen (dernière section) :
   - "Tes données sont protégées par AES-256"
   - "Connexion sécurisée TLS 1.3"
   - "Tes documents (CIN/permis) sont chiffrés"
   - "Données anonymisées après 3 ans d'inactivité"
   - "Tu peux demander la suppression de ton compte à tout moment"
   - Icône bouclier #1565C0

2. Backend — Ajoute dans l'app Fastify :
   - Hook onRequest pour vérifier que toutes les communications sont en TLS (en production)
   - Ajouter les headers de sécurité :
     - X-Content-Type-Options: nosniff
     - X-Frame-Options: DENY
     - Strict-Transport-Security: max-age=31536000 (si HTTPS)
   - Rate limiting sur toutes les routes (déjà commencé Jour 1)
   - Logger les tentatives de connexion suspectes (IP, timestamp, route)

3. Backend — Hook pour l'anonymisation des données :
   - Script cron ou fonction lancée quotidiennement :
   - SELECT users WHERE updatedAt < NOW() - INTERVAL '3 years'
   - Anonymiser : phone = "anonymized_{id}", pseudo = "Anonyme", vider refreshToken, supprimer kyc_documents
```
</details>

#### Définition de fait (Jour 7)

- [ ] Règles du Domino complètes, accessibles sans login
- [ ] Sections expansibles avec icônes
- [ ] Section protection des données présente
- [ ] Headers de sécurité sur le backend

---

### Jour 8 — Intégration + Tests de parcours complet

**Story :** 1.3 + 1.4 + 1.5

**Objectif :** Tester le parcours complet de bout en bout.

#### Tâches

- [ ] Parcours complet : splash → onboarding → inscription (phone + OTP) → KYC → règles
- [ ] Tester tous les cas d'erreur
- [ ] Tester la persistance JWT (fermer/rouvrir l'app)
- [ ] Tester KYC (upload, statuts, rejet)
- [ ] Vérifier AES-256 (fichier illisible sans clé)

#### Prompts IA

<details>
<summary>Prompt 1 : Test d'intégration du parcours complet</summary>

```
Génère un test d'intégration Flutter qui couvre tout le parcours utilisateur initial.

Fichier : test/integration/auth_flow_test.dart

Utilise integration_test de Flutter (pas unit test).

Scénario 1 — Nouvel utilisateur :
1. Lancer l'app (pas de token)
2. Splash → Onboarding (vérifier slide 1)
3. Swipe → slide 2, swipe → slide 3
4. Tape "Commencer" → écran inscription
5. Saisir "+261 34 12 34 56" (9 chiffres)
6. Cocher CGU
7. Tape "Recevoir le code" → inputs OTP visibles
8. (Mock) Récupérer le code depuis Redis du backend
9. Saisir les 4 chiffres → redirection vers KYC
10. Sélectionner "CIN", prendre une photo (mock)
11. Tape "Envoyer" → statut "En attente"

Scénario 2 — Utilisateur avec token existant :
1. Token JWT valide dans Hive
2. Lancer l'app → Splash 2s → Dashboard directement

Scénario 3 — OTP incorrect :
1. Répéter inscription jusqu'à l'OTP
2. Saisir 0000 → message rouge "Code incorrect"
3. 3 tentatives → message "Bloqué 15 minutes"

Mock le backend avec un serveur de test (ou utilise un vrai backend de test).
```
</details>

<details>
<summary>Prompt 2 : Tests de sécurité — Vérification AES-256</summary>

```
Génère un test unitaire pour vérifier le chiffrement AES-256 des fichiers KYC.

Fichier : packages/backend/src/__tests__/encryption.test.ts

Tests :
1. "encryptFile retourne un buffer différent de l'original" :
   - Prendre un buffer de 1KB aléatoire
   - Chiffrer avec une clé fixe
   - Vérifier que le résultat n'est pas égal au buffer original

2. "decryptFile restore exactement le buffer original" :
   - Prendre un buffer connu
   - Chiffrer → déchiffrer
   - Vérifier que le résultat est identique à l'original

3. "decryptFile avec mauvais IV lance une erreur" :
   - Chiffrer un buffer
   - Déchiffrer avec un IV modifié
   - Vérifier que ça lance "Données corrompues"

4. "decryptFile avec mauvaise clé produit un résultat différent" :
   - Chiffrer avec clé A
   - Déchiffrer avec clé B
   - Vérifier que le résultat n'est pas l'original (ou que ça throw une erreur)

5. "encryptFile avec le même buffer et même clé produit des résultats différents" :
   - Chiffrer 2 fois le même buffer avec la même clé
   - Vérifier que les IV sont différents (donc les ciphertexts aussi)
```
</details>

#### Définition de fait (Jour 8)

- [ ] Parcours complet fonctionnel de bout en bout
- [ ] Tests d'intégration passent
- [ ] Tests de chiffrement passent
- [ ] Aucune régression sur le Sprint 1

---

### Jour 9 — Tests unitaires + Revue

**Story :** Toutes

**Objectif :** Tests unitaires, revue de code, documentation.

#### Tâches

- [ ] Tests unitaires Flutter (LoginScreen, OTPInput, KycScreen)
- [ ] Tests unitaires backend (auth service, kyc service)
- [ ] Revue de code
- [ ] Documentation API (README)

#### Prompts IA

<details>
<summary>Prompt 1 : Tests unitaires Flutter (LoginScreen + OTPInput + KycScreen)</summary>

```
Génère des tests unitaires Flutter pour les écrans du Sprint 2.

Fichier 1 : test/features/auth/login_screen_test.dart
- "Affiche le titre 'Créer compte'" → vérifier le texte
- "Affiche l'input téléphone avec préfixe +261"
- "Le bouton est désactivé si moins de 9 chiffres" → entrer "034", vérifier bouton disabled
- "Le bouton est activé si 9 chiffres + CGU cochée"
- "CGU non cochée → bouton désactivé même avec 9 chiffres"
- "Appel API register au tap du bouton" → mock Dio

Fichier 2 : test/features/auth/otp_input_test.dart
- "4 inputs vides au démarrage"
- "Saisie du 1er chiffre → focus passe au 2e input"
- "Saisie de 4 chiffres → déclenche auto-validation"
- "Backspace sur champ vide → focus précédent"
- "Affichage du timer 30s"

Fichier 3 : test/features/kyc/kyc_screen_test.dart
- "Affiche le sélecteur de type pièce (CIN/permis)"
- "Preview image après sélection"
- "Bouton Envoyer désactivé si pas de photo"
- "Statut 'En attente' après upload"
- "Statut 'Vérifié' avec check vert"
- "Statut 'Rejeté' avec motif + bouton réessayer"
```
</details>

<details>
<summary>Prompt 2 : Documentation API du module auth</summary>

```
Génère la documentation de l'API pour les modules auth et kyc.

Format : Markdown, à placer dans packages/backend/README.md

## API Endpoints

### Auth

**POST /auth/register**
- Description: Envoyer un code OTP par SMS au numéro donné
- Body: { "phone": "+261341234567" }
- Success (201): { "message": "OTP envoyé" }
- Errors:
  - 400: { "error": "Numéro invalide" }
  - 429: { "error": "Trop de demandes" }

**POST /auth/verify-otp**
- Description: Valider le code OTP et créer la session
- Body: { "phone": "+261341234567", "otp": "1234" }
- Success (200): { "accessToken": "eyJ...", "refreshToken": "eyJ...", "user": { id, phone, pseudo, statusKyc } }
- Errors:
  - 401: { "error": "Code incorrect" }
  - 401: { "error": "Code expiré" }
  - 429: { "error": "Trop de tentatives" }

**POST /auth/refresh**
- Description: Rafraîchir le token d'accès
- Body: { "refreshToken": "eyJ..." }
- Success (200): { "accessToken": "eyJ..." }
- Error: 401 { "error": "Token invalide" }

**GET /auth/me**
- Description: Récupérer l'utilisateur connecté
- Headers: Authorization: Bearer <token>
- Success (200): { "id": "...", "phone": "...", "pseudo": "...", "statusKyc": "..." }
- Error: 401 { "error": "Non authentifié" }

### KYC

**POST /kyc/upload**
- Headers: Authorization + Content-Type: multipart/form-data
- Body: { documentType: "CIN" | "PERMIS", file: (image jpg/png, < 10MB) }
- Success (200): { "status": "PENDING", "message": "Document soumis" }

**GET /kyc/status**
- Success (200): { "status": "PENDING" | "VERIFIED" | "REJECTED", "rejectionReason"?: string }
```
</details>

#### Définition de fait (Jour 9)

- [ ] Tests unitaires Flutter passent
- [ ] Tests unitaires backend passent
- [ ] README API documenté
- [ ] Revue de code effectuée

---

### Jour 10 — Rétrospective + Livraison

**Story :** Toutes

**Objectif :** Vérifier la complétude du sprint, checklist, rétro.

#### Checklist de fin de sprint

<details>
<summary>Checklist Sprint 2</summary>

Fonctionnalités :
- [ ] Inscription OTP complète (phone → OTP → JWT)
- [ ] KYC upload avec chiffrement AES-256
- [ ] Statuts KYC (attente/vérifié/rejeté) avec UI
- [ ] Règles du Domino accessibles sans auth
- [ ] Protection des données (chiffrement, TLS, anonymisation)
- [ ] Rate limiting (OTP 3/5min, API 100/min)
- [ ] JWT access 15min / refresh 7 jours
- [ ] Blocage 15 min après 3 tentatives OTP

Tests :
- [ ] `flutter test` → tout vert
- [ ] `npx vitest run` → tout vert
- [ ] Test parcours complet (inscription → KYC) OK
- [ ] Test chiffrement AES-256 OK
- [ ] Test 3 tentatives OTP → blocage OK
- [ ] Test token expiré → refresh OK

Technique :
- [ ] npm run lint → 0 erreurs
- [ ] flutter analyze → 0 erreurs
- [ ] npx tsc --noEmit → 0 erreurs
- [ ] docker compose up → services OK

Sécurité :
- [ ] Pas de clé dans le code
- [ ] Fichiers KYC chiffrés au repos
- [ ] Rate limiting actif
- [ ] Headers de sécurité (CORS, HSTS)
- [ ] Refresh token hashé en base (bcrypt cost 12)
</details>

#### Rétrospective

Questions à se poser :
- Qu'est-ce qui a pris plus de temps que prévu ?
- L'IA a-t-elle bien aidé sur les parties complexes (chiffrement AES, JWT) ?
- Y a-t-il des parties du code à refactorer avant le Sprint 3 ?
- Le backend est-il prêt pour le Socket.IO (Sprint 3) ?

---

## Ressources d'apprentissage pour le junior

| Concept | Prompt |
|---------|--------|
| JWT | *"Explique JWT (access token + refresh token). Pourquoi 15min pour l'access et 7 jours pour le refresh ? Comment implémenter le refresh en Flutter avec Dio interceptor ?"* |
| AES-256-GCM | *"Explique AES-256-GCM : qu'est-ce que le IV, l'authTag, pourquoi GCM plutôt que CBC ? Donne un exemple Node.js crypto.createCipheriv."* |
| OTP avec Redis | *"Comment gérer un code OTP avec Redis en Node.js ? TTL, compteur de tentatives, blocage temporaire. Donne un exemple complet avec ioredis."* |
| Fastify multipart | *"Comment gérer l'upload de fichier avec Fastify et @fastify/multipart ? Valider le type MIME, la taille, et convertir en Buffer."* |
| Hive en Flutter | *"Explique Hive pour le stockage local Flutter. Comment stocker un token JWT, le lire, le supprimer. Donne un exemple complet."* |
| Sécurité mobile | *"Quelles sont les bonnes pratiques de sécurité pour une app Flutter qui manipule de l'argent réel ? Stockage sécurisé, certificat SSL pinning, obfuscation."* |

---

## Définition of Done (Sprint 2)

- [ ] L'utilisateur peut s'inscrire avec son téléphone → OTP SMS
- [ ] L'utilisateur peut uploader son CIN/permis → KYC chiffré
- [ ] L'utilisateur peut consulter les règles du Domino
- [ ] JWT + refresh token fonctionnels
- [ ] Rate limiting et blocage actifs
- [ ] Données protégées (AES-256, bcrypt, TLS)
- [ ] Tests passent
- [ ] Lint passe

---

## Prochain Sprint (Aperçu)

Le Sprint 3 couvrira :
- Dashboard principal (Story 3.1)
- Créer une partie Domino avec Redis (Story 3.2)
- Moteur Domino server-authoritative (Story 4.1 — le plus complexe)
