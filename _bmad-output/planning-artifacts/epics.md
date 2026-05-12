---
stepsCompleted:
  - "step-01-validate-prerequisites"
  - "step-02-design-epics"
  - "step-03-create-stories"
  - "step-04-final-validation"
inputDocuments:
  - "_bmad-output/planning-artifacts/prd-higame-mvp.md"
  - "_bmad-output/planning-artifacts/architecture-higame.md"
  - "_bmad-output/planning-artifacts/strategique-higame.md"
  - "_bmad-output/mockups/00-design-system.md"
  - "_bmad-output/mockups/01-splash.md"
  - "_bmad-output/mockups/02-onboarding.md"
  - "_bmad-output/mockups/03-inscription.md"
  - "_bmad-output/mockups/04-kyc.md"
  - "_bmad-output/mockups/05-dashboard.md"
  - "_bmad-output/mockups/06-wallet.md"
  - "_bmad-output/mockups/07-depot.md"
  - "_bmad-output/mockups/08-retrait.md"
  - "_bmad-output/mockups/09-creer-partie.md"
  - "_bmad-output/mockups/10-rejoindre-prive.md"
  - "_bmad-output/mockups/11-rejoindre-public.md"
  - "_bmad-output/mockups/12-salon-attente.md"
  - "_bmad-output/mockups/13-plateau-domino.md"
  - "_bmad-output/mockups/14-resultat.md"
  - "_bmad-output/mockups/15-profil.md"
  - "_bmad-output/mockups/16-parametres.md"
  - "_bmad-output/mockups/17-regles.md"
  - "_bmad-output/mockups/18-historique.md"
  - "_bmad-output/mockups/19-reconnexion.md"
  - "_bmad-output/mockups/20-premier-depot.md"
  - "docs/project-context.md"
---

# HiGame - Epic Breakdown

## Overview

This document provides the complete epic and story breakdown for HiGame, decomposing the requirements from the PRD, UX Design mockups, and Architecture requirements into implementable stories.

## Requirements Inventory

### Functional Requirements

| ID | Description | Source |
|:--:|-----------|:------:|
| FR-01 | Inscription par téléphone + OTP SMS 4 chiffres | PRD M-01 |
| FR-02 | Upload pièce d'identité (CIN/permis) pour KYC | PRD M-02 |
| FR-03 | Dépôt MVola vers wallet HiGame | PRD M-03 |
| FR-04 | Consultation solde wallet en temps réel | PRD M-04 |
| FR-05 | Création partie Domino avec mise | PRD M-05 |
| FR-06 | Rejoindre une partie existante | PRD M-06 |
| FR-07 | Jouer une partie Domino complète (plateau, tuiles, tours) | PRD M-07 |
| FR-08 | Piocher quand tuile non jouable | PRD M-08 |
| FR-09 | Visualisation résultat partie + détail gains | PRD M-09 |
| FR-10 | Retrait gains vers MVola | PRD M-10 |
| FR-11 | Notification push quand c'est son tour | PRD M-11 |
| FR-12 | Reconnexion après coupure réseau | PRD M-12 |
| FR-13 | Historique des parties | PRD M-13 |
| FR-14 | Signalement joueur suspect | PRD M-14 |
| FR-15 | Paramétrage limites de dépôt | PRD M-15 |
| FR-16 | Consultation règles du Domino depuis l'app | PRD M-16 |
| FR-17 | Logique 100% server-authoritative | PRD M-17 |
| FR-18 | Choix multiples mises prédéfinies (500/1000/2000/5000/10000 Ar) | PRD M-18 |
| FR-19 | Gestion abandon/déconnexion joueur | PRD M-19 |
| FR-20 | Expérience optimisée réseau 2G/3G | PRD M-20 |
| FR-21 | Consultation logs de replay (admin) | PRD M-21 |
| FR-22 | Protection données personnelles | PRD M-22 |
| FR-23 | Salon privé avec code | PRD M-23 |
| FR-24 | Notification crédit gains wallet | PRD M-24 |
| FR-25 | Annulation partie avant début | PRD M-25 |
| FR-26 | Fusion de salons après 30s d'attente | PRD M-26 |

### Non-Functional Requirements

| ID | Description | Source |
|:--:|-----------|:------:|
| NFR-01 | OTP valide 5min, max 3 tentatives, blocage 15min | PRD M-01 |
| NFR-02 | Vérification KYC : < 24h manuel, immédiat si auto | PRD M-02 |
| NFR-03 | Dépôt min 1 000 Ar, max 200 000 Ar, temps total < 2 min | PRD M-03 |
| NFR-04 | Reconnexion < 60s avec restauration état complet | PRD M-12 |
| NFR-05 | Mises prédéfinies : 500, 1 000, 2 000, 5 000, 10 000 Ar | PRD M-18 |
| NFR-06 | App < 30 MB, images compressées, WebSocket heartbeat 10s | PRD M-20 |
| NFR-07 | Chiffrement données sensibles (CIN, numéro téléphone) | PRD M-22 |
| NFR-08 | Rétention données : 3 ans après dernier login | PRD M-22 |
| NFR-09 | 100% logique de jeu côté serveur (server-authoritative) | PRD M-17 |
| NFR-10 | Timeout déconnexion : 60s avant marquage abandon | PRD M-19 |
| NFR-11 | Commission plateforme : 12% du pool total | PRD §6.8 |
| NFR-12 | Matching timeout : 30s avant proposition fusion | PRD M-26 |
| NFR-13 | JWT access token 15 min, refresh token 7 jours | Architecture §9.1 |
| NFR-14 | Rate limiting : OTP 3/5min, API 100/min par IP | Architecture §9.1 |
| NFR-15 | Optimistic locking wallet via colonne version | Architecture §9.2 |
| NFR-16 | Chiffrement AES-256 documents KYC | Architecture §9.3 |
| NFR-17 | Hash bcrypt cost 12 pour mots de passe | Architecture §9.3 |
| NFR-18 | TLS 1.3 pour toutes les communications | Architecture §9.3 |
| NFR-19 | Retrait min 2 000 Ar, max 500 000 Ar | PRD M-10 |
| NFR-20 | Score cible partie : 100 points (configurable) | PRD §6.6 |
| NFR-21 | Traitement retrait sous 24h | PRD §5.5 |
| NFR-22 | Limites dépôt configurables par joueur | PRD M-15 |
| NFR-23 | Temps par coup configurable : 30s, 60s, 120s | PRD §4.10 |
| NFR-24 | Mise à jour solde wallet temps réel < 5s après fin partie | PRD §8.1 |

### Additional Requirements (Architecture)

| ID | Description |
|:--:|-----------|
| AR-01 | Redis sorted sets pour files d'attente matching |
| AR-02 | Event sourcing : chaque action = événement dans game_events |
| AR-03 | RNG déterministe seedé par hash(gameId + createdAt) |
| AR-04 | Snapshots partie dans game_snapshots pour reconnexion rapide |
| AR-05 | Idempotence via correlationId + Redis lock + table idempotency_keys |
| AR-06 | Déploiement Docker Compose (service backend + redis) |
| AR-07 | CI : GitHub Actions (lint + test + build backend) |
| AR-08 | Build APK : GitHub Actions ou Codemagic sur tag v* |
| AR-09 | Socket.IO avec rooms pour broadcast par partie |
| AR-10 | PostgreSQL via Prisma/Kysely |
| AR-11 | Monorepo : packages/frontend/ + packages/backend/ |
| AR-12 | Frontend : Flutter + Riverpod + go_router + Hive (cache offline) |
| AR-13 | Backend : Fastify + TypeScript + modules (auth, wallet, game, matching, payment) |
| AR-14 | Replay partie administrateur via game_events ordonnés par id ASC |
| AR-15 | Optimistic locking wallet : UPDATE wallets SET balance = ?, version = version + 1 WHERE version = ? |
| AR-16 | Chiffrement AES-256 documents KYC avant stockage, clé en env var |
| AR-17 | Structure backend modulaire : auth.routes.ts, auth.controller.ts, auth.service.ts, auth.schema.ts par module |
| AR-18 | Scalabilité : 1 VPS (4GB/2CPU) jusqu'à 1000 connexions simultanées |

### UX Design Requirements

| ID | Description | Sources |
|:--:|-----------|:-------:|
| UX-DR-01 | Design system : palette (#1565C0 primaire, #00BFA5 accent, #4CAF50 success, #F44336 error, #FFB300 warning), espacement grille 8px, border-radius (sm 4px, md 8px, lg 12px) | 00-design-system |
| UX-DR-02 | Typographie : famille Inter, hiérarchie H1 24px Bold, H2 18px Semi-Bold, H3 16px Semi-Bold, Body 14px, Monetary 20px Bold | 00-design-system |
| UX-DR-03 | Composants réutilisables : Button primaire (accent #00BFA5, 48px, radius 12px), Button outline (border #1565C0), Button text, Input (48px, radius 12px, états default/focus/error/success), Card (radius 12px, shadow sm), Wallet Card (gradient #1565C0→#0D47A1) | 00-design-system |
| UX-DR-04 | Bottom navigation 4 tabs : Accueil, Partie, Wallet, Profil (hauteur 64px, icône actif #1565C0, inactif #BDBDBD) | 00-design-system |
| UX-DR-05 | Feedback visuel : Modal/Bottom sheet (radius top 12px), Skeleton loader (shimmer animation), Toast/Snackbar (success/error/warning) | 00-design-system |
| UX-DR-06 | Avatar circulaire (40px défaut, 56px profil, 24px salon), bordure 2px active (vert) ou attente (gris) | 00-design-system |
| UX-DR-07 | Splash screen : fond #1565C0, logo centré, spinner blanc, version v1.0.0-beta, auto-redirect 2s (→ dashboard si token valide, → onboarding sinon) | 01-splash |
| UX-DR-08 | Onboarding 3 slides swipe : slide 1 "Milalao Domino, win vola!", slide 2 "Mobile Money direct", slide 3 "Secure & transparent", dots progression, bouton "Commencer" sur dernier slide, lien "Passer" | 02-onboarding |
| UX-DR-09 | Inscription : input téléphone préfixe +261 fixe, masque XX XX XXX XX, 9 chiffres, bouton "Recevoir le code" désactivé si < 9, OTP 4 inputs séparés, timer renvoi 30s, max 3 tentatives → blocage 15min, checkbox CGU | 03-inscription |
| UX-DR-10 | KYC : sélecteur type pièce (CIN/permis), bouton "Prendre en photo"/"Choisir galerie", preview avant envoi, statuts (horloge attente, check vert vérifié, croix rouge rejeté + motif) | 04-kyc |
| UX-DR-11 | Dashboard : header logo + solde wallet + icône œil (afficher/masquer), bannière bienvenue, section jeux (Domino actif, Ludo/Cartes grisés), section actions (Créer/Rejoindre/Wallet/Historique), bannière orange si KYC en attente | 05-dashboard |
| UX-DR-12 | Wallet : gradient card solde (#1565C0→#0D47A1), montant large Monetary 20px Bold, boutons Déposer (vert) / Retirer (rouge/orange), historique 10 dernières transactions, statuts (Succès/En cours/Échoué) | 06-wallet, 07-depot, 08-retrait |
| UX-DR-13 | Création partie : sélecteurs (jeu, type 1v1/4j, mise, mode public/privé, temps par coup), récapitulatif "Mise X Ar, commission 12%, gain potentiel X Ar" | 09-creer-partie |
| UX-DR-14 | Rejoindre partie : champ code privé 6 caractères, filtres par mise et type, liste salons (type/mise/joueurs/temps/bouton Rejoindre), bannière matching si attente > 10s | 10-rejoindre-prive, 11-rejoindre-public |
| UX-DR-15 | Salon attente : avatars + pseudos joueurs, places vides silhouettées, code privé affiché, bouton "Partager le code", timer recherche, popup fusion après 30s, message changement mise après 60s | 12-salon-attente |
| UX-DR-16 | Plateau domino : fond #1565C0, barre info (timer + joueur actif + score), chaîne centrale scroll horizontale, doubles perpendiculaires, main éventail sélectionnable par tap, boutons Poser/Pioche/Passer, overlay tour adverse, animation domino | 13-plateau-domino |
| UX-DR-17 | Résultat : trophée si victoire, avatar gagnant 80px, gain accent #00BFA5 large, tableau scores (joueur/points/résultat), expandable tuiles restantes, boutons "Revanche !" (recrée partie identique) / "Retour au lobby", animation confettis si victoire | 14-resultat |
| UX-DR-18 | Profil : avatar modifiable, pseudo (1 changement/30 jours), statistiques (parties/victoires/défaites/winrate/gains/pertes), statut KYC, boutons (Historique/Paramètres/Règles/Aide/Déconnexion) | 15-profil |
| UX-DR-19 | Paramètres : sections Compte (pseudo, avatar, KYC), Notifications (push, son, vibration), Limites jeu (dépôt journalier/hebdo/mensuel, auto-exclusion 24h/7j/30j), Affichage (langue), Sécurité (sessions), Suppression compte | 16-parametres |
| UX-DR-20 | Règles du jeu : écran "Règles du Domino", sections (Objectif/Mise en place/Déroulement/Scores/Fin de partie/Variante malgache), illustrations, accessible sans compte | 17-regles |
| UX-DR-21 | Historique parties : liste chronologique (20 parties/page, scroll infini), filtres (Toutes/Victoires/Défaites), chaque ligne (date/type/mise/résultat gain-perte/durée), tap → replay textuel détaillé | 18-historique |
| UX-DR-22 | Reconnexion : détection perte connexion, écran "Reconnexion..." avec spinner, restauration complète plateau après reconnexion, timeout 60s → marquage AFK | 19-reconnexion |

### FR Coverage Map

| FR | Epic | Description |
|:--:|:----:|-----------|
| FR-01 | Epic 1 | Inscription par téléphone + OTP SMS |
| FR-02 | Epic 1 | Upload pièce d'identité (CIN/permis) pour KYC |
| FR-03 | Epic 2 | Dépôt MVola vers wallet HiGame |
| FR-04 | Epic 2 | Consultation solde wallet en temps réel |
| FR-05 | Epic 3 | Création partie Domino avec mise |
| FR-06 | Epic 3 | Rejoindre une partie existante |
| FR-07 | Epic 4 | Jouer une partie Domino complète |
| FR-08 | Epic 4 | Piocher quand tuile non jouable |
| FR-09 | Epic 4 | Visualisation résultat partie + détail gains |
| FR-10 | Epic 2 | Retrait gains vers MVola |
| FR-11 | Epic 4 | Notification push quand c'est son tour |
| FR-12 | Epic 4 | Reconnexion après coupure réseau |
| FR-13 | Epic 5 | Historique des parties |
| FR-14 | Epic 4 | Signalement joueur suspect |
| FR-15 | Epic 2 | Paramétrage limites de dépôt |
| FR-16 | Epic 1 | Consultation règles du Domino depuis l'app |
| FR-17 | Epic 4 | Logique 100% server-authoritative |
| FR-18 | Epic 3 | Choix multiples mises prédéfinies |
| FR-19 | Epic 4 | Gestion abandon/déconnexion joueur |
| FR-20 | Epic 4 | Expérience optimisée réseau 2G/3G |
| FR-21 | Epic 4 | Consultation logs de replay (admin) |
| FR-22 | Epic 1 | Protection données personnelles |
| FR-23 | Epic 3 | Salon privé avec code |
| FR-24 | Epic 4 | Notification crédit gains wallet |
| FR-25 | Epic 3 | Annulation partie avant début |
| FR-26 | Epic 3 | Fusion de salons après 30s d'attente |

## Epic List

### Epic 1: Auth & Onboarding
Le joueur crée son compte par téléphone (OTP SMS), upload sa pièce d'identité pour KYC, et accepte les CGU. Il peut aussi consulter les règles du jeu sans être connecté.
**FRs couvertes :** FR-01, FR-02, FR-16, FR-22
**NFRs :** NFR-01, NFR-02, NFR-07, NFR-08, NFR-13, NFR-14, NFR-17, NFR-18
**UX-DRs :** UX-DR-07, UX-DR-08, UX-DR-09, UX-DR-10, UX-DR-20

### Epic 2: Wallet Mobile Money
Le joueur dépose de l'argent depuis MVola, consulte son solde en temps réel, retire ses gains, et configure ses limites de dépôt.
**FRs couvertes :** FR-03, FR-04, FR-10, FR-15
**NFRs :** NFR-03, NFR-15, NFR-19, NFR-21, NFR-22, NFR-24
**UX-DRs :** UX-DR-12

### Epic 3: Lobby & Matching
Le joueur navigue sur le dashboard, crée ou rejoint une partie (publique/privée), choisit sa mise, et l'attente est optimisée par fusion de salons Redis.
**FRs couvertes :** FR-05, FR-06, FR-18, FR-23, FR-25, FR-26
**NFRs :** NFR-05, NFR-12
**UX-DRs :** UX-DR-11, UX-DR-13, UX-DR-14, UX-DR-15

### Epic 4: Domino Game (Plateau + Résultat + Reconnexion)
Le joueur joue une partie de Domino complète — pose de tuiles, pioche, timer, résultat avec commission 12%, notification de gain, reconnexion après coupure, et signalement anti-triche. L'administrateur peut consulter les logs de replay.
**FRs couvertes :** FR-07, FR-08, FR-09, FR-11, FR-12, FR-14, FR-17, FR-19, FR-20, FR-21, FR-24
**NFRs :** NFR-04, NFR-06, NFR-09, NFR-10, NFR-11, NFR-20, NFR-23
**UX-DRs :** UX-DR-16, UX-DR-17, UX-DR-22

### Epic 5: Profil, Paramètres & Historique
Le joueur consulte son historique de parties, modifie son profil et avatar, paramètre ses notifications et ses limites de jeu.
**FRs couvertes :** FR-13
**UX-DRs :** UX-DR-18, UX-DR-19, UX-DR-21

### Epic 6: Infrastructure & CI/CD
La plateforme est déployée avec Docker Compose, le monorepo structuré, les workflows CI actifs, et l'APK buildée automatiquement.
**ARs :** AR-06, AR-07, AR-08, AR-11

## Epic 1: Auth & Onboarding

Le joueur crée son compte par téléphone (OTP SMS), upload sa pièce d'identité pour KYC, et consulte les règles. L'infrastructure monorepo et BDD est initialisée en foundation.

**FRs couvertes :** FR-01, FR-02, FR-16, FR-22
**NFRs :** NFR-01, NFR-02, NFR-07, NFR-08, NFR-13, NFR-14, NFR-17, NFR-18
**UX-DRs :** UX-DR-07, UX-DR-08, UX-DR-09, UX-DR-10, UX-DR-20

### Story 1.1: Initialiser le monorepo, la BDD et les fondations

As a **développeur**,
I want **initialiser le monorepo avec la structure packages/frontend + packages/backend, Prisma, et la config de base**,
So that **l'équipe peut builder sur une base solide**.

**Acceptance Criteria:**

**Given** le projet initialisé
**When** je clone le repo et lance `npm install`
**Then** les dépendances sont installées dans les deux packages
**And** le lint (`npm run lint`) passe sans erreur

**Given** Prisma configuré
**When** je lance `prisma migrate dev`
**Then** la table `users` est créée en base

**Given** le backend Fastify
**When** je lance `npm run dev` dans packages/backend
**Then** le serveur écoute sur le port configuré

**Given** le frontend Flutter
**When** je lance `flutter run`
**Then** l'app s'affiche sur l'émulateur

### Story 1.2: Écran Splash + Onboarding 3 slides

As a **nouveau joueur**,
I want **voir un splash screen puis un onboarding de 3 slides**,
So that **je comprends la valeur de l'app avant de m'inscrire**.

**Acceptance Criteria:**

**Given** l'app lancée sans session
**When** le splash s'affiche 2s
**Then** l'écran d'onboarding apparaît avec les 3 slides

**Given** l'app lancée avec token JWT valide
**When** le splash s'affiche 2s
**Then** le dashboard s'affiche directement

**Given** l'écran d'onboarding
**When** je swype à gauche
**Then** le slide suivant s'affiche avec les dots mis à jour

**Given** le dernier slide
**When** je tape "Commencer"
**Then** l'écran d'inscription s'affiche

**Given** l'app lancée sans réseau
**When** le splash essaie de vérifier le token
**Then** le message "Vérifie connexion" s'affiche

### Story 1.3: Inscription par téléphone (OTP SMS)

As a **nouveau joueur**,
I want **m'inscrire avec mon numéro de téléphone et recevoir un code OTP par SMS**,
So that **je crée un compte sécurisé**.

**Acceptance Criteria:**

**Given** l'écran d'inscription
**When** je saisis un numéro de 9 chiffres avec préfixe +261
**Then** le bouton "Recevoir le code" devient actif

**Given** un numéro valide
**When** je tape "Recevoir le code"
**Then** un SMS OTP 4 chiffres est envoyé et les inputs OTP apparaissent

**Given** le code OTP reçu
**When** je saisis les 4 chiffres
**Then** la validation est automatique et le compte est créé avec JWT (access 15min, refresh 7 jours)

**Given** un code incorrect
**When** je saisis 4 chiffres erronés
**Then** un message d'erreur rouge s'affiche et les inputs sont réinitialisés

**Given** 3 tentatives échouées
**When** je tente un 4e code
**Then** le compte est bloqué 15 minutes avec message explicite

**Given** le timer de renvoi
**When** j'attends 30s
**Then** le bouton "Renvoyer" devient actif

**Given** les CGU non acceptées
**When** je tente d'envoyer le code sans cocher la checkbox
**Then** un message d'erreur bloque l'envoi

### Story 1.4: Upload KYC (CIN/permis)

As a **joueur inscrit**,
I want **uploader ma pièce d'identité (CIN ou permis)**,
So that **mon compte soit vérifié et je puisse jouer avec de l'argent réel**.

**Acceptance Criteria:**

**Given** l'écran KYC post-inscription
**When** j'arrive sur l'écran
**Then** je vois le sélecteur de type pièce (CIN/permis) et les boutons "Prendre en photo" / "Choisir galerie"

**Given** une photo prise/sélectionnée
**When** l'image est prête
**Then** l'aperçu s'affiche avec possibilité de recadrage

**Given** l'upload confirmé
**When** l'image est envoyée
**Then** elle est chiffrée AES-256 avant stockage et le statut passe à "En attente de vérification"

**Given** le statut "En attente"
**When** la vérification manuelle est faite
**Then** le joueur reçoit une notification et le statut passe à "Vérifié" ou "Rejeté" avec motif

**Given** un rejet KYC
**When** le joueur consulte l'écran
**Then** le motif du rejet est affiché et un bouton permet de re-soumettre

### Story 1.5: Page Règles du Domino + Protection des données

As a **joueur**,
I want **consulter les règles du Domino (variante malgache) et comprendre comment mes données sont protégées**,
So that **je comprends le jeu et j'ai confiance dans la plateforme**.

**Acceptance Criteria:**

**Given** l'écran Règles
**When** j'ouvre depuis le menu ou le profil
**Then** les sections suivantes s'affichent : Objectif, Mise en place, Déroulement, Scores, Fin de partie, Variante malgache

**Given** l'écran Règles
**When** je ne suis pas connecté
**Then** les règles sont accessibles sans authentification

**Given** l'inactivité du joueur
**When** 3 ans après le dernier login
**Then** les données personnelles sont automatiquement anonymisées

**Given** l'authentification
**When** l'utilisateur se connecte
**Then** le hash de session utilise bcrypt cost 12 et TLS 1.3 pour toutes les communications

## Epic 2: Wallet Mobile Money

Le joueur dépose depuis MVola, consulte son solde en temps réel, retire ses gains et configure ses limites de dépôt.

**FRs couvertes :** FR-03, FR-04, FR-10, FR-15
**NFRs :** NFR-03, NFR-15, NFR-19, NFR-21, NFR-22, NFR-24
**UX-DRs :** UX-DR-12

### Story 2.1: Dépôt MVola vers wallet HiGame

As a **joueur vérifié KYC**,
I want **déposer de l'argent depuis MVola vers mon wallet HiGame**,
So that **je puisse miser sur des parties**.

**Acceptance Criteria:**

**Given** l'écran Dépôt
**When** je sélectionne un montant entre 1 000 et 200 000 Ar
**Then** une requête de dépôt est envoyée avec correlationId unique

**Given** la requête envoyée
**When** PaidMada initie la transaction MVola
**Then** l'utilisateur reçoit une notification d'approbation sur son téléphone (push USSD MVola)

**Given** la transaction approuvée
**When** PaidMada envoie le callback
**Then** le solde wallet est crédité et la transaction passe en statut "Succès"

**Given** un dépôt en cours
**When** le timeout de 2 min est dépassé
**Then** la transaction est marquée "Échoué" et le joueur peut réessayer

**Given** la même requête soumise deux fois (même correlationId)
**When** le callback arrive
**Then** l'idempotence (Redis lock + table idempotency_keys) empêche le double crédit

**Given** le solde du wallet
**When** le dépôt est crédité
**Then** l'optimistic locking (colonne version) garantit l'intégrité du solde

### Story 2.2: Consultation solde wallet en temps réel

As a **joueur**,
I want **voir mon solde wallet en temps réel**,
So that **je sache combien je peux miser**.

**Acceptance Criteria:**

**Given** le dashboard ou l'écran Wallet
**When** la vue s'affiche
**Then** le solde est affiché au format "Ar XX XXX" avec la typographie Monetary (20px Bold)

**Given** un changement de solde (dépôt, gain, retrait)
**When** l'événement Socket.IO est émis
**Then** le solde se met à jour en temps réel (< 5s)

**Given** l'app en mode offline
**When** je consulte le solde
**Then** la dernière valeur connue est affichée depuis le cache Hive

**Given** le cache hors-ligne prolongé
**When** la dernière mise à jour date de plus de 5min
**Then** un message "Hors connexion" est affiché

### Story 2.3: Retrait des gains vers MVola

As a **joueur vérifié**,
I want **retirer mes gains vers mon compte MVola**,
So that **je puisse utiliser mon argent en dehors de la plateforme**.

**Acceptance Criteria:**

**Given** l'écran Retrait
**When** je saisis un montant entre 2 000 et 500 000 Ar
**Then** la demande est créée avec statut "En cours"

**Given** un retrait créé
**When** l'administrateur valide le transfert manuel
**Then** le statut passe à "Succès" et le joueur reçoit une notification push

**Given** un retrait créé
**When** l'administrateur refuse
**Then** le statut passe à "Échoué" avec motif et le montant est remis sur le wallet

**Given** le traitement du retrait
**When** le délai dépasse 24h
**Then** une alerte admin est levée

**Given** le solde insuffisant
**When** je tente un retrait > solde disponible
**Then** un message d'erreur "Solde insuffisant" bloque la transaction

### Story 2.4: Paramétrage des limites de dépôt

As a **joueur responsable**,
I want **configurer mes limites de dépôt (journalière, hebdomadaire, mensuelle)**,
So that **je contrôle mon budget de jeu**.

**Acceptance Criteria:**

**Given** l'écran Paramètres > Limites
**When** je modifie une limite
**Then** la nouvelle valeur est persistée et appliquée immédiatement

**Given** une limite journalière de 50 000 Ar
**When** je tente un dépôt de 30 000 Ar après avoir déjà déposé 25 000 Ar
**Then** le dépôt est refusé avec message "Limite journalière atteinte"

**Given** une limite baissée
**When** le montant déjà déposé aujourd'hui dépasse la nouvelle limite
**Then** les dépôts sont bloqués jusqu'au prochain cycle

**Given** l'option d'auto-exclusion
**When** je sélectionne une durée (24h / 7j / 30j)
**Then** les dépôts sont bloqués pour la durée choisie

## Epic 3: Lobby & Matching

Le joueur navigue sur le dashboard, crée ou rejoint une partie (publique/privée), choisit sa mise, et l'attente est optimisée par fusion de salons Redis.

**FRs couvertes :** FR-05, FR-06, FR-18, FR-23, FR-25, FR-26
**NFRs :** NFR-05, NFR-12
**UX-DRs :** UX-DR-11, UX-DR-13, UX-DR-14, UX-DR-15

### Story 3.1: Dashboard principal

As a **joueur connecté**,
I want **voir le dashboard avec mon solde, les jeux disponibles, et les actions rapides**,
So that **je puisse naviguer facilement dans l'app**.

**Acceptance Criteria:**

**Given** le dashboard
**When** je suis connecté
**Then** le header affiche le logo + solde wallet + icône œil (afficher/masquer)

**Given** le dashboard
**When** j'arrive
**Then** une bannière "Bienvenue" ou promo s'affiche

**Given** les jeux disponibles
**When** le dashboard charge
**Then** Domino est visible et actif, Ludo/Cartes sont grisés

**Given** les actions rapides
**When** je vois le dashboard
**Then** 4 boutons : Créer / Rejoindre / Wallet / Historique

**Given** le KYC en attente
**When** je consulte le dashboard
**Then** une bannière orange "KYC en attente" s'affiche en haut

**Given** la bottom navigation
**When** je tape sur un onglet
**Then** la vue correspondante s'affiche (Accueil / Partie / Wallet / Profil)

### Story 3.2: Créer une partie Domino

As a **joueur**,
I want **créer une partie Domino avec mise, type (1v1/4j), mode (public/privé) et temps par coup**,
So that **je joue exactement comme je veux**.

**Acceptance Criteria:**

**Given** l'écran "Créer partie"
**When** j'arrive
**Then** je vois les sélecteurs : jeu (Domino), type (1v1/4j), mise, mode (public/privé), temps (30s/60s/120s)

**Given** les mises disponibles
**When** j'ouvre le sélecteur
**Then** les options sont : 500 / 1 000 / 2 000 / 5 000 / 10 000 Ar

**Given** la sélection complète
**When** tout est configuré
**Then** un récapitulatif s'affiche : "Mise X Ar, commission 12%, gain potentiel X Ar"

**Given** le bouton "Créer"
**When** je confirme
**Then** la salle est créée dans Redis, je rejoins automatiquement, et l'écran d'attente s'affiche

**Given** le mode privé
**When** la salle est créée
**Then** un code à 6 caractères est généré et affiché

**Given** le mode public
**When** la salle est créée
**Then** la salle est ajoutée à la file d'attente Redis (sorted set par mise)

### Story 3.3: Rejoindre partie publique + Fusion 30s

As a **joueur**,
I want **voir la liste des salons publics disponibles et attendre si aucun n'est libre**,
So that **je trouve rapidement une partie adaptée**.

**Acceptance Criteria:**

**Given** l'écran "Rejoindre partie publique"
**When** j'arrive
**Then** une liste des salons ouverts s'affiche avec filtres par mise et par type (1v1/4j)

**Given** un salon dans la liste
**When** je vois ses infos
**Then** le type, mise, nombre joueurs, temps par coup et un bouton "Rejoindre" sont affichés

**Given** un salon non plein
**When** je tape "Rejoindre"
**Then** je suis redirigé vers le salon d'attente

**Given** aucun salon disponible
**When** je suis mis en attente
**Then** un timer "Recherche..." s'affiche avec animation

**Given** 30s d'attente sans match
**When** le timeout est atteint
**Then** une popup propose de fusionner avec un autre salon de même mise ou changer de mise

**Given** la fusion acceptée
**When** les joueurs des deux salons sont regroupés
**Then** un nouveau salon unique est créé avec tous les joueurs

### Story 3.4: Rejoindre partie privée + Annulation

As a **joueur invité**,
I want **rejoindre un salon privé avec un code à 6 caractères**,
So that **je joue uniquement avec mes amis**.

**Acceptance Criteria:**

**Given** l'écran "Rejoindre privé"
**When** je saisis un code à 6 caractères
**Then** le salon correspondant est trouvé et je peux le rejoindre

**Given** un code invalide
**When** je tente de rejoindre
**Then** un message "Code invalide" s'affiche

**Given** le créateur du salon
**When** je tape "Annuler la partie" avant qu'elle ne commence
**Then** tous les joueurs sont notifiés et le salon est détruit

**Given** un salon annulé
**When** aucun joueur n'a misé
**Then** aucune transaction n'est effectuée

**Given** un joueur non-créateur
**When** je quitte le salon avant le début
**Then** la place est libérée pour un autre joueur

## Epic 4: Domino Game (Plateau + Résultat + Reconnexion)

Le joueur joue une partie de Domino complète — pose de tuiles, pioche, timer, résultat avec commission 12%, notification de gain, reconnexion après coupure, signalement anti-triche, et logs de replay admin.

**FRs couvertes :** FR-07, FR-08, FR-09, FR-11, FR-12, FR-14, FR-17, FR-19, FR-20, FR-21, FR-24
**NFRs :** NFR-04, NFR-06, NFR-09, NFR-10, NFR-11, NFR-23
**UX-DRs :** UX-DR-16, UX-DR-17, UX-DR-22

### Story 4.1: Moteur Domino server-authoritative + RNG

As a **joueur**,
I want **que la logique du Domino soit gérée 100% côté serveur avec un RNG déterministe**,
So that **le jeu soit équitable et infalsifiable**.

**Acceptance Criteria:**

**Given** une partie créée
**When** le nombre requis de joueurs est atteint
**Then** le serveur initialise les tuiles double-6 (28 tuiles), distribue 7 par joueur (1v1) ou 5 (4j), et détermine le premier joueur

**Given** le moteur Domino
**When** un joueur pose une tuile
**Then** le serveur valide la compatibilité des extrémités, met à jour la chaîne, et passe au joueur suivant via Socket.IO

**Given** une tuile non jouable
**When** le joueur pioche
**Then** le serveur pioche depuis le talon et vérifie si la tuile est jouable

**Given** le RNG
**When** les tuiles sont distribuées
**Then** le seed = hash(gameId + createdAt) garantit la reproductibilité

**Given** le score cible (100 points défaut)
**When** un joueur atteint 100+
**Then** la partie se termine et les scores sont calculés

**Given** un "Domino!" (dernière tuile posée)
**When** la manche se termine
**Then** le score = somme des points des tuiles restantes des adversaires

**Given** le timer configuré
**When** le temps par coup atteint 0
**Then** le serveur passe automatiquement le tour (ou pioche si obligatoire)

### Story 4.2: Plateau Domino UI + Tour notifications

As a **joueur**,
I want **voir le plateau de jeu complet et savoir quand c'est mon tour**,
So that **je puisse jouer mes tuiles et suivre la partie en temps réel**.

**Acceptance Criteria:**

**Given** le plateau de jeu
**When** la partie commence
**Then** l'écran affiche : fond #1565C0, barre info (timer + joueur actif + score), chaîne domino centrale, main en éventail

**Given** les tuiles du joueur
**When** je tape sur une tuile
**Then** elle se soulève (sélectionnée) avec un effet d'ombre

**Given** une tuile sélectionnée
**When** je tape "Poser"
**Then** la tuile est envoyée au serveur via Socket.IO, validée, et la chaîne est mise à jour pour tous les joueurs

**Given** le bouton "Pioche"
**When** je tape alors qu'il reste des tuiles au talon
**Then** une tuile est piochée et ajoutée à ma main

**Given** ce n'est pas mon tour
**When** l'adversaire joue
**Then** un overlay "Tour de [joueur]" s'affiche et les actions sont désactivées

**Given** c'est mon tour
**When** je reçois la main
**Then** une notification push est envoyée et le téléphone vibre

**Given** la chaîne longue
**When** les tuiles dépassent l'écran
**Then** le scroll horizontal est activé

**Given** les doubles
**When** posés
**Then** ils sont affichés perpendiculairement à la chaîne

### Story 4.3: Résultat, Commission 12% & Crédit wallet

As a **joueur**,
I want **voir le résultat de ma partie et être crédité automatiquement si j'ai gagné**,
So that **je reçoive mon gain après déduction de la commission**.

**Acceptance Criteria:**

**Given** une partie terminée
**When** le résultat est calculé
**Then** l'écran de résultat affiche : avatar gagnant (80px), gain en #00BFA5, tableau des scores

**Given** le gagnant
**When** le calcul est fait
**Then** le gain net = pool total × 0,88 (commission 12% prélevée sur le pool)

**Given** le gain calculé
**When** la partie est validée
**Then** le wallet du gagnant est crédité via optimistic locking et une notification "Gain de X Ar crédité" est envoyée

**Given** l'écran de résultat
**When** c'est une victoire
**Then** une animation de confettis s'affiche

**Given** le bouton "Revanche !"
**When** je tape
**Then** un nouveau salon est créé avec les mêmes paramètres

**Given** le détail
**When** je tape "Voir tuiles restantes"
**Then** les tuiles non jouées de chaque adversaire sont affichées

### Story 4.4: Reconnexion après coupure + Timeout abandon

As a **joueur avec une connexion instable**,
I want **me reconnecter automatiquement après une coupure et retrouver l'état exact de ma partie**,
So that **je ne perde pas ma partie à cause du réseau**.

**Acceptance Criteria:**

**Given** une perte de connexion détectée
**When** le heartbeat ne répond plus pendant 10s
**Then** le client affiche un écran "Reconnexion..." avec spinner

**Given** la reconnexion
**When** le client envoie `reconnect(sessionId)`
**Then** le serveur restaure l'état complet depuis game_snapshots

**Given** le snapshot restauré
**When** l'état est reçu
**Then** le plateau, la main, le timer et le score sont identiques à avant la coupure

**Given** un joueur déconnecté
**When** le timeout de 60s est atteint
**Then** le joueur est marqué "Abandon" et la partie continue sans lui

**Given** l'inactivité (AFK)
**When** un joueur n'agit pas pendant son tour pendant 60s
**Then** le serveur passe automatiquement son tour

### Story 4.5: Signalement joueur suspect

As a **joueur**,
I want **signaler un joueur suspect (triche, comportement anormal)**,
So that **l'équipe puisse enquêter et maintenir l'intégrité de la plateforme**.

**Acceptance Criteria:**

**Given** une partie en cours ou terminée
**When** je tape sur le profil d'un joueur
**Then** un bouton "Signaler" est disponible

**Given** le bouton "Signaler"
**When** je tape
**Then** une liste de motifs apparaît : Triche suspectée / Comportement abusif / Collusion / Autre

**Given** la sélection d'un motif
**When** j'envoie le signalement
**Then** l'événement est enregistré avec les game_events liés

**Given** un joueur signalé 3+ fois en 24h
**When** le seuil est atteint
**Then** une alerte admin est levée pour investigation

### Story 4.6: Logs de replay administrateur

As a **administrateur**,
I want **consulter les logs de replay d'une partie via l'event sourcing**,
So that **je puisse auditer les parties litigieuses et détecter les anomalies**.

**Acceptance Criteria:**

**Given** une partie terminée ou en cours
**When** l'admin consulte les logs
**Then** la séquence complète des game_events est affichée (triée par id ASC)

**Given** les events
**When** le replay est chargé
**Then** chaque action (pose, pioche, pass) est affichée avec timestamp et joueur

**Given** un litige signalé
**When** l'admin consulte le replay
**Then** il peut rejouer la partie pas à pas depuis les events

**Given** la table game_events
**When** un event est créé
**Then** il contient : gameId, playerId, actionType, payload, timestamp, id (auto-incrément)

## Epic 5: Profil, Paramètres & Historique

Le joueur consulte son profil et ses statistiques, paramètre ses préférences, et parcourt l'historique de ses parties.

**FRs couvertes :** FR-13
**UX-DRs :** UX-DR-18, UX-DR-19, UX-DR-21

### Story 5.1: Écran Profil + Statistiques

As a **joueur**,
I want **voir mon profil avec mes statistiques de jeu**,
So that **je suive mes performances**.

**Acceptance Criteria:**

**Given** l'écran Profil
**When** j'arrive
**Then** l'avatar, pseudo, statut KYC, et les stats sont affichés

**Given** les statistiques
**When** le profil charge
**Then** parties jouées, victoires, défaites, winrate, gains totaux et pertes sont visibles

**Given** le bouton modifier avatar
**When** je tape
**Then** je choisis entre photo ou galerie

**Given** le pseudo
**When** je tente de le modifier
**Then** la limite est de 1 changement tous les 30 jours

**Given** les boutons d'action
**When** je scrolle
**Then** Historique, Paramètres, Règles, Aide et Déconnexion sont accessibles

### Story 5.2: Paramètres (notifications, limites, sécurité)

As a **joueur**,
I want **configurer mes paramètres : notifications, limites de jeu, langue et sécurité**,
So that **l'app soit adaptée à mes préférences**.

**Acceptance Criteria:**

**Given** l'écran Paramètres
**When** j'arrive
**Then** les sections sont : Compte, Notifications, Limites jeu, Affichage, Sécurité, Suppression compte

**Given** la section Notifications
**When** je modifie les toggles
**Then** push, son et vibration sont activés/désactivés

**Given** la section Affichage
**When** je change la langue
**Then** l'interface passe en français ou malgache

**Given** la section Sécurité
**When** je consulte
**Then** la liste des sessions actives est affichée avec déconnexion distante possible

**Given** la suppression de compte
**When** je confirme
**Then** le compte est désactivé après 7 jours de grâce

### Story 5.3: Historique des parties + Filtres

As a **joueur**,
I want **consulter mon historique de parties avec des filtres**,
So that **je suive mon activité et analyse mes performances passées**.

**Acceptance Criteria:**

**Given** l'écran Historique
**When** j'arrive
**Then** les 20 dernières parties sont affichées en ordre chronologique inverse (scroll infini)

**Given** chaque ligne de l'historique
**When** je vois une partie
**Then** date, type (1v1/4j), mise, résultat (gain/perte) et durée sont affichés

**Given** les filtres
**When** je sélectionne un filtre
**Then** "Toutes", "Victoires", "Défaites" sont disponibles

**Given** une partie dans l'historique
**When** je tape dessus
**Then** un replay textuel détaillé s'affiche (coups, scores par manche)

**Given** le scroll infini
**When** j'atteins le bas
**Then** les 20 parties suivantes sont chargées automatiquement

## Epic 6: Infrastructure & CI/CD

La plateforme est déployée avec Docker Compose, le monorepo structuré, les workflows CI actifs, et l'APK buildée automatiquement.

**ARs :** AR-06, AR-07, AR-08, AR-11

### Story 6.1: Docker Compose (backend + Redis)

As a **devops**,
I want **dockeriser le backend et Redis avec Docker Compose**,
So that **le déploiement soit reproductible sur un VPS**.

**Acceptance Criteria:**

**Given** le Dockerfile backend
**When** je lance `docker build`
**Then** l'image Node.js/TypeScript est construite avec les dépendances de production uniquement

**Given** le docker-compose.yml
**When** je lance `docker compose up`
**Then** les services backend (Fastify) et Redis démarrent

**Given** la configuration
**When** les services sont up
**Then** le backend écoute sur le port configuré et Redis est accessible

**Given** le déploiement VPS
**When** je déploie avec docker compose
**Then** le service est accessible publiquement et les logs sont collectés

**Given** la scalabilité visée
**When** le VPS est configuré (4GB/2CPU)
**Then** il supporte jusqu'à 1000 connexions simultanées

### Story 6.2: GitHub Actions CI (lint, test, build backend)

As a **devops**,
I want **un pipeline CI qui exécute lint, tests et build sur chaque push**,
So that **la qualité du code soit garantie en continu**.

**Acceptance Criteria:**

**Given** un push sur main
**When** le pipeline CI se déclenche
**Then** les étapes sont : checkout → install → lint → test → build

**Given** le lint
**When** une erreur de style est détectée
**Then** le pipeline échoue avec le message d'erreur

**Given** les tests
**When** tous passent
**Then** le build backend est compilé avec succès

**Given** le frontend Flutter
**When** le pipeline CI est configuré
**Then** `flutter analyze` et `flutter test` sont exécutés

### Story 6.3: Build APK automatisé

As a **devops**,
I want **builder l'APK Android automatiquement sur tag v***,
So that **les testeurs reçoivent une build prête à installer**.

**Acceptance Criteria:**

**Given** un tag git v*
**When** le tag est poussé
**Then** GitHub Actions (ou Codemagic) déclenche le build APK

**Given** le build réussi
**When** l'APK est généré
**Then** il est disponible en artifact ou uploadé vers un canal de distribution

**Given** le build APK
**When** l'application est installée
**Then** la version affichée correspond au tag git

**Given** l'APK signé
**When** il est installé sur un appareil Android 8+
**Then** l'application s'exécute sans erreur
