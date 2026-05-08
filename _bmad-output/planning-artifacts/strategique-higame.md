---
document_id: "strategique-higame-v1"
document_date: "2026-05-08"
agent: "Mary (bmad-agent-analyst)"
user: "Tahina-bemax"
communication_language: "french"
sources:
  - docs/project-context.md
  - _bmad-output/brainstorming/bp-session-001.md
  - _bmad-output/planning-artifacts/research/market-jeux-traditionnels-malgaches-paris-argent-reel-research-2026-05-08.md
status: "final"
---

# HiGame — Document Stratégique

**Date :** 2026-05-08
**Auteur :** Mary (Analyste d'Affaires)
**Version :** 1.0

---

## Table des Matières

1. Executive Summary
2. Vision & Contexte
3. Analyse de Marché
4. Modèle d'Affaires & Revenus
5. Analyse Concurrentielle & Positionnement
6. Cibles & Comportement Joueurs
7. Architecture Technique & Paiements
8. Benchmark & Cas d'Étude
9. Risques, Légal & Conformité
10. Feuille de Route & Budget
11. Recommandations Stratégiques

---

## 1. Executive Summary

HiGame est un projet de plateforme mobile de jeux traditionnels malgaches (Domino, Ludo, Cartes) avec paris en argent réel, ciblant le marché malgache. Le paiement s'effectue via Mobile Money (MVola, Orange Money, Airtel Money), le moyen de transaction dominant à Madagascar avec 24,27 millions de comptes enregistrés.

**Constat principal** : Le marché malgache des jeux d'argent en ligne est un océan bleu. Aucun opérateur ne combine (1) jeux traditionnels malgaches, (2) paiement Mobile Money direct, et (3) plateforme locale en français. Les concurrents internationaux (Betwinner, 1xBet, 1win) se concentrent sur les paris sportifs et le casino, sans offre adaptée aux jeux de société locaux.

**Marché** : 30 000 – 70 000 joueurs en ligne actifs estimés à Madagascar, avec 120 000+ joueurs non régulés. Revenus iGaming local estimés entre 100 000 $ et 250 000 $ en 2025, avec un GGR global (terrestre + offshore) de ~50 M$.

**Modèle** : Commission de 10-12% sur les parties, vente de terrains virtuels (concept innovant : Bronze/Argent/Or avec commission propriétaire), tournois payants, et items virtuels. Marge réelle estimée à ~9% après frais Mobile Money (3%) et coûts opérationnels.

**Cible réaliste année 1** : 10 000 – 25 000 utilisateurs actifs, générant ~624 M Ar/an de commissions (≈130 000 $).

**Régulation** : Zone grise — aucune loi spécifique pour l'online pur. Recommandation : licence Curaçao comme filet de sécurité + dialogue avec le CJM.

**Recommandation** : Entrée stratégique en 2026-2027, MVP Domino, intégration MVola directe, commission 10-12%, préparation conformité AML/KYC.

---

## 2. Vision & Contexte

### 2.1 La vision HiGame

HiGame est né d'un constat simple : les Malgaches jouent au Domino, au Ludo et aux cartes partout — dans les quartiers, les marchés, les villages — souvent avec de petits paris en argent. Pourtant, il n'existe aucune plateforme digitale qui capte cette pratique culturelle et économique.

**Vision** : Devenir la plateforme #1 de jeux traditionnels malgaches en ligne, en préservant l'esprit social et convivial du jeu traditionnel tout en y ajoutant la sécurité, la praticité et l'accessibilité du mobile.

### 2.2 Problème résolu

- **Avant** : Parties organisées manuellement, risque de conflit sur les gains, disponibilité limitée aux cercles sociaux physiques
- **Après** : Appairage automatique, wallet sécurisé avec Mobile Money, commissions transparentes, jeu 24/7 avec n'importe qui à Madagascar

### 2.3 Contexte projet

| Élément | Description |
|---------|-------------|
| **Projet** | HiGame — Plateforme de jeux traditionnels malgaches avec paris en argent réel |
| **Pays cible** | Madagascar |
| **Jeux** | Domino, Ludo, Cartes (extension progressive) |
| **Paiements** | MVola, Orange Money, Airtel Money |
| **Modèle** | Commission 10-15% + terrains virtuels + tournois |
| **Statut légal** | Zone grise |
| **Concurrents** | Betwinner, 1xBet, 1win, 22Bet, Bet261 |

---

## 3. Analyse de Marché

### 3.1 Macro-indicateurs Madagascar

| Métrique | Valeur | Source |
|----------|--------|--------|
| Population (2024) | 31,96 M | UN / Internet Society |
| Connexions mobiles (2025) | 21,8 M (66,2%) | GSMA / DataReportal 2026 |
| Internautes (2025) | 6,71 M (20,4%) | Kepios / DataReportal 2026 |
| Comptes Mobile Money (2024) | 24,27 M | IMF / FRED |
| Population bancarisée | 17-18% | Visa 2025 |
| Mobile Money → PIB | 47% | GSMA |
| Télécom → PIB | 15,2% (2023) | AfDB |
| Marché télécom (2025) | 0,84 Md$ | Mordor Intelligence |

### 3.2 Marché iGaming malgache

| Indicateur | Estimation | Source |
|------------|-----------|--------|
| Revenus iGaming direct (2025) | 100 000 – 250 000 $ | iGamingToday 2025 |
| GCR global (terrestre + online) | ~50 M$ | GamblingDatabases |
| Joueurs en ligne actifs | 30 000 – 70 000 (peak) | iGamingToday 2025 |
| Joueurs non régulés estimés | 120 000+ | SlotsUp 2025 |
| Croissance annuelle sectorielle | 6-8% CAGR | iGamingToday |
| Budget mensuel joueur régulier | 20 000 – 100 000 Ar | Analyse concurrence |

### 3.3 Marché adressable HiGame

| Métier | Valeur | Calcul |
|--------|--------|--------|
| Cible adressable | ~2,35 M | 6,71 M internautes × 35% joueurs potentiels |
| Cible réaliste année 1 | 10 000 – 25 000 | 0,5-1% du marché adressable |
| Volume financier annuel projeté | ~5,2 Mds Ar (~1,1 M$) | 10k users × 5 parties/sem × 2 000 Ar |
| Commissions annuelles (12%) | ~624 M Ar (~130 000 $) | Après frais MVola 3% → ~9% net |

### 3.4 Pénétration mobile — Contrainte et opportunité

**Contrainte** : Seulement 20,4% de la population a accès à Internet (6,71 M). 79,6% est offline.

**Opportunité** : Les 24,27 M de comptes Mobile Money dépassent largement le nombre d'internautes. Les transactions Mobile Money représentent 47% du PIB. La croissance des connexions mobiles est de +11,1% sur un an.

**Implication HiGame** : Application légère et optimisée pour réseaux 2G/3G, taille réduite, reconnectable. Le Mobile Money est l'interface de paiement, pas la carte bancaire.

---

## 4. Modèle d'Affaires & Revenus

### 4.1 Concept innovant : Terrains Virtuels

Le modèle économique original combine commission de partie et vente de terrains virtuels — inspiré du jeu vidéo mais adapté au contexte.

| Type | Capacité | Pari max | Commission propriétaire | Prix |
|:----:|:--------:|:--------:|:-----------------------:|:----:|
| 🆓 Gratuit | 10 joueurs | 500 Ar | 0% | Gratuit |
| 🥇 Bronze | 50 places | 2 000 Ar | 2% | Payant |
| 🥈 Argent | 200 places | 10 000 Ar | 3% | Payant |
| 🥇 Or | Illimité | Illimité | 5% | Payant |
| 🎯 Tournoi | Événementiel | Buy-in élevé | 7% | Invitation |

**Mécanique** : Les propriétaires de terrains perçoivent une commission sur les parties jouées sur leur terrain. Plus le terrain est premium, plus la capacité et le plafond de mise sont élevés. Le propriétaire attire ses amis (effet viral), et gagne passivement.

### 4.2 Structure des revenus

```
Revenus Plateforme =
   Commission partie (10-15%) — prélevée sur le gagnant
 + Vente de terrains (achat unique, marge élevée)
 + Tournois (buy-in majoré + droit d'entrée)
 + Items virtuels (dés, plateaux, avatars, thèmes)

Détail partie :
   Frais d'entrée (1 000 Ar) → Pool (4 joueurs = 4 000 Ar)
   → Gagnant (85% = 3 400 Ar)
   → Plateforme (15% = 600 Ar)
   → -3% MVola sur flux = 18 Ar
   → Si terrain Bronze : -2% propriétaire = 12 Ar
   → Marge plateforme nette ~9-12%
```

### 4.3 Projection financière année 1

| Poste | Base | Valeur mensuelle | Valeur annuelle |
|-------|------|:----------------:|:----------------:|
| Utilisateurs actifs | 10 000 | — | — |
| Parties/joueur/semaine | 5 | — | — |
| Mise moyenne/partie | 2 000 Ar | — | — |
| Volume de jeu total | — | 400 M Ar | 4,8 Mds Ar |
| Commission brute (12%) | — | 48 M Ar | 576 M Ar |
| Frais MVola (3%) | — | -14,4 M Ar | -172,8 M Ar |
| Marge brute plateforme | ~9% | ~33,6 M Ar | ~403 M Ar |
| Frais opérationnels | ~20 M Ar/mois | -20 M Ar | -240 M Ar |
| **Résultat net estimé** | | **~13,6 M Ar** | **~163 M Ar (~35 000 $)** |

### 4.4 Leviers de croissance

1. Augmentation du nombre de parties/joueur (gamification, notifications)
2. Augmentation de la mise moyenne (terrains premium, tournois)
3. Ventes de terrains (marge élevée, revenu non lié au jeu)
4. Commission propriétaire (désintermédiation = plus de parties)
5. Items virtuels (coût marginal quasi nul)

---

## 5. Analyse Concurrentielle & Positionnement

### 5.1 Matrice concurrentielle

| Plateforme | Paris sportifs | Casino/Slots | Jeux traditionnels | Mobile Money direct | Licence locale |
|:----------:|:--------------:|:------------:|:------------------:|:-------------------:|:--------------:|
| Betwinner | ✅ | ✅ | ❌ (domino slot) | ❌ | Curaçao |
| 1xBet | ✅ | ✅ | ❌ | ❌ | Curaçao |
| 1win | ✅ | ✅ | ❌ | ❌ | Curaçao |
| 22Bet | ✅ | ✅ | ❌ | ❌ | Curaçao |
| Bet261 | ✅ (sports) | ❌ | ❌ | Partiel | CJM/État |
| **HiGame** | ❌ | ❌ | **✅ Domino/Ludo/Cartes** | **✅ MVola/OM/Airtel** | **Curaçao + CJM** |

### 5.2 Positionnement stratégique

**Différenciateurs HiGame :**
- **Culturel** : Jeux que les Malgaches connaissent et jouent déjà en physique
- **Paiement** : Mobile Money natif (pas de carte bancaire requise)
- **Bas stakes** : Adapté au pouvoir d'achat local (500-2 000 Ar par partie)
- **Social** : Terrains virtuels, salons privés, mécanique "inviter ses amis"
- **Langue** : Français + Malgache

**Non-positionnement** : Pas de paris sportifs, pas de casino/slots, pas de jeu avec croupier. Focus total sur le jeu de compétence.

### 5.3 SWOT HiGame

| 🟢 Forces | 🔴 Faiblesses |
|-----------|--------------|
| Premier sur le segment jeux traditionnels | Aucune notoriété initiale |
| Mobile Money natif (24 M comptes) | Dépendance aux API Mobile Money (3% frais) |
| Modèle terrain innovant (effet viral) | Faible pénétration internet (20%) |
| Connaissance du marché local | Pas de licence locale établie |
| Bas stakes → accessible à tous | Équipe technique à constituer |

| 🟡 Opportunités | 🔵 Menaces |
|-----------------|-----------|
| Marché vierge (océan bleu) | Durcissement réglementaire possible |
| Forte croissance mobile (+11%/an) | Taxe mobile money (0,5% des transactions) |
| Régulation à venir → first-mover | Arrivée de concurrents (Betwinner clone) |
| Extension régionale (Comores, Réunion) | Défiance utilisateurs (arnaque perçue) |
| Licence Curaçao possible | Instabilité politique/économique |

---

## 6. Cibles & Comportement Joueurs

### 6.1 Segments de clientèle

| Segment | Profil | Part estimée | Jeux préférés |
|---------|--------|:------------:|:-------------:|
| Joueur occasionnel urbain | 18-35 ans, smartphone, niveau collège/lycée, Antananarivo/Toamasina | 35% | Domino rapide, Ludo |
| Joueur régulier traditionnel | 25-55 ans, joue déjà en physique avec paris, quartiers/marchés | 35% | Domino, Cartes |
| Jeune mobile-first | 18-24 ans, réseaux sociaux, Mobile Money actif, zones urbaines | 20% | Ludo, Cartes rapides |
| Joueur rural | 25-50 ans, téléphone entrée de gamme, usage basique Mobile Money | 10% | Ludo, Domino |

### 6.2 Comportement de jeu attendu

- **Mobile-first** : >90% des sessions sur smartphone
- **Sessions courtes** : parties de 5 à 15 minutes
- **Horaires de pointe** : 18h-23h en semaine + week-end
- **Bas stakes** : mise moyenne 500 – 5 000 Ar
- **Social** : préférence pour jouer avec des connaissances (salons privés)
- **Taux de rétention** : les jeux de société ont un bon taux de rétention organique

### 6.3 Budget joueur

| Type | Budget mensuel | Partie/jour | Mise/partie |
|------|:--------------:|:-----------:|:-----------:|
| Joueur léger | 10 000 – 30 000 Ar | 1-2 | 500-1 000 Ar |
| Joueur régulier | 30 000 – 100 000 Ar | 3-5 | 1 000-3 000 Ar |
| Joueur intensif | 100 000 – 500 000 Ar | 5-10 | 2 000-10 000 Ar |

---

## 7. Architecture Technique & Paiements

### 7.1 Stack technique recommandée

**Frontend : Flutter**
- Performances natives (critique pour jeu temps réel)
- Codebase unique (Android + iOS + Web)
- Paquet `mvola-dart` disponible
- Sécurité native (biométrie, fingerprint)

**Backend : Node.js/TypeScript**
- WebSocket natif pour jeu temps réel
- API REST pour opérations wallet/profil
- Event sourcing pour logs de jeu et litiges

**Base de données : PostgreSQL + Redis**
- PostgreSQL : données persistantes (utilisateurs, parties, wallets)
- Redis : cache, files d'attente, sessions WebSocket

### 7.2 Architecture anti-triche

| Mécanisme | Description | Jeux concernés |
|-----------|-------------|:--------------:|
| Server-authoritative | 100% logique côté serveur | Tous |
| RNG déterministe | Seed vérifiable pour tirage | Domino, Ludo |
| Mental Poker | Engagements cryptographiques SHA-256 | Cartes |
| Détection de bots | ML (Random Forest + LSTM) | Tous |
| Anti-collusion | Patterns de jeu, clustering IP | Tous |
| Logs de replay | Audit complet des parties | Tous |

### 7.3 Paiements Mobile Money

| Provider | Intégration | Frais | Statut |
|----------|-------------|:-----:|:------:|
| MVola (Telma) | API REST + SDK | 3% | ✅ Prioritaire |
| Orange Money | Web Payment API (OTP) | Variable | ✅ |
| Airtel Money | API disponible | Variable | ✅ |

**Solution unifiée recommandée : PaidMada** (github)
- API unique MVola + OM + Airtel
- Auto-détection du provider
- SDK TypeScript
- Webhooks + mode mock
- Sandbox gratuit

**Défis paiements :**
- Transactions asynchrones (30s-2min) → polling + callbacks
- Idempotence obligatoire (correlationId unique)
- Gestion des timeouts → remboursement auto
- Double dépense → verrouillage Redis

### 7.4 Gestion des interruptions réseau

| Problème | Solution |
|----------|----------|
| Coupure réseau | WebSocket heartbeat 5-10s |
| Joueur AFK | Timeout 60s → marquage AFK |
| Reconnexion | `reconnect(sessionId)` → état complet |
| Double action | Idempotence via `actionId` unique |
| Bug système | Event sourcing → remboursement automatique |

**Choix plateforme mobile :** Flutter recommandé (perf native, sécurité, WebSocket natif). PWA possible mais moins de confiance pour l'argent réel.

---

## 8. Benchmark & Cas d'Étude

### 8.1 Marché indien — Le modèle qui marche

| Plateforme | Utilisateurs | Jeux | Modèle | Points clés |
|------------|:-----------:|------|--------|-------------|
| WinZO | 250 M | Ludo, Carrom, Rummy, Domino | Commission + tournois | 12 langues, ₹1 min, +100M$ levés |
| Yono Games | 10 M+ | Ludo, Rummy, Poker, Domino | Tournois cash | 25+ jeux, salon, parrainage |
| Ludo Players | 1,1 M | Ludo | Tournois | RNG iTechLabs, retrait instantané |
| Khelo Ludo | 1 M+ | Ludo | Entry fee | 10 min chrono, retrait UPI |

**Leçons apprises :**
- Les jeux traditionnels (Ludo, Rummy, Domino) sont les plus populaires en argent réel
- Certification RNG = confiance utilisateur
- Retrait instantané = #1 facteur de crédibilité
- Bonus parrainage = moteur de croissance #1
- Langues locales = adoption massive

### 8.2 Marché africain — Marchés émergents

| Plateforme | Pays | Jeu | Modèle | Particularité |
|------------|:----:|:---:|--------|:-------------:|
| 9jaLudo | Nigéria | Ludo | Tournois | Entrée à ₦100+ |
| Ludo Naira | Nigéria | Ludo | Points scoring | 10 min chronométré |
| Ludo Origin | Nigéria | Ludo | Tournois | Classic + custom mode |
| MPL Nigeria | Nigéria | Ludo + Lucky Spin | Free + deposit | Programme parrainage |

**Chiffres clés Afrique :**
- Marché gaming africain : $17,63 Mds (2024)
- Nigeria : $249 M (2021)
- Kenya : $46 M (2021)
- CAGR 4,23% jusqu'en 2029

### 8.3 Cas notables

**Cas 1 : WinZO (Inde, 2018-2026)**
- 250 M utilisateurs en 6 ans
- Levée : +100 M$ en VC
- Modèle : 100+ jeux skill-based, ₹1 min, 12 langues
- Leçon pour HiGame : Localisation + microprix = adoption massive

**Cas 2 : Yalla Ludo (MENA, 2019-)**
- Ludo + Domino + Jackaroo + voice chat
- Abonnement VIP Baron : $39,99/mois
- Leçon pour HiGame : L'aspect social (voice chat, salons) est un puissant moteur de rétention

**Cas 3 : 9jaLudo / Ludo Naira (Nigeria)**
- Un seul jeu (Ludo), argent réel
- Partie chronométrée de 10 minutes
- Leçon pour HiGame : Un jeu unique bien exécuté suffit pour démarrer

**Cas 4 : Kenya BCB**
- Régulateur renforce KYC, reporting temps réel
- Consolidation autour des opérateurs compliant
- Leçon pour HiGame : Construire avec conformité dès le jour 1

**Cas 5 : Jeux africains indigènes (Guardian NG)**
- Défis : 29% accès internet, financement bootstrap, rareté développeurs
- Leçon pour HiGame : Design light, offline-capable, infra modeste

### 8.4 Ce qui fonctionne — Synthèse des benchmarks

| Facteur | Poids | App. HiGame |
|---------|:-----:|:-----------:|
| Mobile-first | Critique | Flutter natif, basse consommation data |
| Mobile Money natif | Critique | MVola/OM/Airtel via PaidMada |
| Retraits instantanés | #1 confiance | Cible < 5 minutes |
| Jeux traditionnels | Élevé | Domino, Ludo, Cartes |
| Bas stakes (micro-prix) | Élevé | 500 Ar minimum |
| Parrainage/affiliation | Élevé | Terrain + referral program |
| Certification RNG | Moyen | iTechLabs (phase 2) |
| Voice chat/social | Moyen | Salons privés, messagerie |

---

## 9. Risques, Légal & Conformité

### 9.1 Cadre légal à Madagascar

| Texte | Année | Contenu |
|-------|:-----:|---------|
| Gambling Act | 1998 | Cadre principal pour casinos terrestres, paris, loteries |
| Loi n°2006-002 | 2006 | Création du Conseil du Jeu de Madagascar (CJM) |
| Décret n°7974/2018 | 2018 | Permet à la loterie d'État d'opérer Bet261 |
| Réforme | 2022 | Autorisation casinos terrestres → extension en ligne |
| Discussion | 2022 | Suggestion code licence complet pour l'online |

### 9.2 Situation actuelle (2026)

- **Zone grise totale pour l'online pur** : pas de licence disponible pour opérateur 100% digital
- **CJM** : noté 2.7/10 en efficacité (GamblingDatabases)
- **Opérateurs offshore** (Betwinner, etc.) : non bloqués, non régulés, non taxés
- **Risque AML** : L'Unité de Renseignement Financier ne peut tracer les flux online
- **Projets de loi** : Aucun calendrier ferme. Réforme possible d'ici 2027
- **Taxe Mobile Money** : Proposition 0,5% sur transactions >150 000 Ar (loi finances 2025, contestée)

### 9.3 Stratégie de conformité recommandée

**Option A (recommandée) — Licence Curaçao + présence locale minimale**
1. Obtenir licence eGaming Curaçao (délai 2-4 mois, coût ~15 000-25 000 €)
2. Société offshore (Seychelles ou Maurice) + représentation fiscale Madagascar
3. Serveurs hors Madagascar (Maurice, Afrique du Sud, ou Europe)
4. Paiement IS Madagascar (23%) déclaré si applicable

**Option B — Partenariat casino terrestre**
1. S'associer avec un des 5 casinos terrestres licenciés
2. Utiliser leur extension online (loi 2022)
3. Partage de revenus (50/50 ou 60/40)
4. Plus compliqué mais couverture légale locale

**Option C — Attente régulation**
1. Surveiller l'évolution législative
2. Engager le dialogue avec le CJM en amont
3. Risque : quelqu'un d'autre prend le marché

### 9.4 Conformité minimale

| Exigence | Application HiGame |
|----------|-------------------|
| KYC obligatoire | Upload CIN ou permis, vérification téléphone |
| Âge minimum | Blocage < 18 ans |
| AML | Plafond de mise, analyse transactions inhabituelles |
| Auto-exclusion | Option joueur, période minimale 72h |
| Publicité | Pas de ciblage mineurs, pas de promesses de gains |
| RGPD | Données personnelles hébergées hors MG, consentement |
| Audit externe | Certification RNG (iTechLabs) phase 2 |
| Limites de dépôt | Optionnel pour le joueur |

### 9.5 Matrice des risques

| Risque | Probabilité | Impact | Score | Atténuation |
|--------|:-----------:|:------:|:-----:|-------------|
| Durcissement réglementaire | Moyenne | Élevé | 12 | Licence Curaçao + dialogue CJM |
| Taxe Mobile Money (0,5%) | Élevée (2025) | Moyen | 9 | Intégrer seuil 150 000 Ar dans modèle |
| Concurrence gros opérateurs | Élevée | Moyen | 9 | Différenciation : jeux locaux + Mobile Money |
| Faible pénétration internet | Certain | Moyen | 8 | Design light, offline, SMS |
| AML / Blanchiment | Moyenne | Élevé | 12 | KYC strict, plafonds, audit |
| Défiance utilisateurs | Élevée | Moyen | 9 | Licence visible, retraits rapides, communication |
| Instabilité politique | Faible | Élevé | 8 | Structure offshore, diversification |
| Triche / Collusion | Moyenne | Moyen | 6 | Server-authoritative + ML + logs replay |
| Frais MVola (3%) | Certain | Faible | 5 | Modélisé dans marge |

---

## 10. Feuille de Route & Budget

### 10.1 Roadmap

```
Mois 0-3  : Phase Préparation
├── Licence Curaçao (2-4 mois)
├── Intégration API MVola (sandbox + production)
├── Constitution société offshore
├── Recrutement équipe technique (1-2 devs Flutter + 1 backend)
└── Définition PRD produit

Mois 4-6  : Phase MVP (Bêta fermée)
├── Développement backend WebSocket + event sourcing
├── Développement client Flutter (Android + iOS + Web)
├── Jeu #1 : Domino multijoueur (mode libre + ranked)
├── Système wallet + intégration PaidMada
├── Anti-triche basique (server-authoritative + logs)
└── Bêta fermée 500 testeurs

Mois 7-9  : Phase Lancement Public
├── Jeu #2 : Ludo
├── Terrains virtuels (Bronze + Argent)
├── Programme parrainage / affiliation
├── Paiement Orange Money + Airtel Money (via PaidMada)
├── Licence visible + KYC obligatoire
└── Lancement grand public + communication

Mois 10-12 : Phase Croissance
├── Jeu #3 : Cartes (jeu 1 traditionnel)
├── Terrains Or + Tournois
├── Items virtuels (dés, plateaux, avatars)
├── Certification RNG (iTechLabs)
├── Vote chat / messagerie
└── Optimisation rétention + monétisation

Mois 13-18 : Phase Extension
├── Jeux supplémentaires
├── Terrains Tournoi
├── Extension régionale (Comores, Réunion, Seychelles)
├── Application iOS App Store + Google Play
└── Levée de fonds seed/amorçage
```

### 10.2 Budget estimé (12 premiers mois)

| Poste | Montant (Ar) | Montant ($) | Détail |
|------|:-----------:|:-----------:|--------|
| Développement (Flutter + backend) | 60 M | 13 000 | 2-3 devs freelance |
| Licence Curaçao | 90 M | 19 500 | 15 000-25 000 € |
| Frais juridiques (offshore + MG) | 30 M | 6 500 | Constitution + avocat |
| Intégration paiements | 15 M | 3 250 | PaidMada, API MVola |
| Hébergement + infrastructure | 24 M | 5 200 | 400$/mois × 12 |
| Marketing + acquisition | 60 M | 13 000 | Ads, influenceurs, events |
| Réserves + divers | 30 M | 6 500 | Imprévus (20%) |
| **Total** | **~309 M** | **~67 000** | |

### 10.3 Seuil de rentabilité

| Métrique | Valeur |
|----------|--------|
| Investissement initial | ~309 M Ar (~67 000 $) |
| Commission mensuelle nette cible (an 1) | ~33,6 M Ar |
| Mois pour rentabilité | ~9-10 mois (avec croissance progressive) |
| Utilisateurs actifs nécessaires pour rentabilité | ~6 000 utilisateurs réguliers |

---

## 11. Recommandations Stratégiques

### 11.1 Priorités immédiates (T0+3 mois)

1. **Licence Curaçao** — Dépôt immédiat (délai 2-4 mois)
2. **Partenariat MVola** — Premier contact API (sandbox déjà disponible)
3. **Équipe technique** — 1 dev Flutter + 1 backend Node.js/TypeScript
4. **PRD Domino** — Définition fonctionnelle du MVP

### 11.2 Priorités produit (T0+6 mois)

1. **MVP Domino** — Un seul jeu, bien fait, plutôt que 3 jeux moyens
2. **Wallet + Mobile Money** — L'intégration paiement est le risque #1, à valider en premier
3. **Expérience réseau** — Reconnexion, timeout, 2G — critique pour le marché
4. **Salons privés** — Fonctionnalité sociale clé (jouer entre amis)

### 11.3 Positionnement marketing

| Message | Cible |
|---------|-------|
| "Joue au Domino avec tes amis et gagne de l'argent" | Joueurs traditionnels |
| "Le jeu malgache, partout, tout le temps" | Jeunes urbains |
| "Gagne tes paris sans risque — paiement sécurisé MVola" | Joueurs hésitants |
| "Crée ton terrain, invite tes amis, gagne passivement" | Prescripteurs |

### 11.4 Indicateurs clés de succès (année 1)

| KPI | Objectif | Criticité |
|-----|:--------:|:---------:|
| Utilisateurs inscrits | 25 000 | 🔴 |
| Utilisateurs actifs mensuels | 10 000 | 🔴 |
| Parties/joueur/semaine | 5 | 🟡 |
| Mise moyenne/partie | 2 000 Ar | 🟡 |
| Commission mensuelle nette | 50 M Ar | 🔴 |
| Rétention M+3 | 40% | 🟡 |
| Délai retrait moyen | < 5 min | 🔴 |
| Taux de triche détecté | < 0,5% | 🟢 |
| Coût acquisition utilisateur | < 5 000 Ar | 🟡 |

### 11.5 Verdict

**HiGame a une fenêtre d'opportunité unique.** Aucun concurrent ne combine les jeux traditionnels malgaches, le Mobile Money direct, et une plateforme locale. Les barrières à l'entrée sont moyennes (technique, licence), mais les barrières de réplication sont élevées une fois la communauté et la confiance établies.

**Les 3 risques majeurs à mitiger dès le jour 1 :**
1. **Paiements** — L'intégration Mobile Money est le chemin critique
2. **Régulation** — Licence Curaçao indispensable comme filet de sécurité
3. **Confiance** — Retraits rapides + licence visible = crédibilité

**Budget nécessaire : ~67 000 $ (309 M Ar) pour 12 mois**
**Seuil de rentabilité : ~9 mois avec 6 000 utilisateurs actifs**

---

*Document généré par Mary — Business Analyst (bmad-agent-analyst)*
*Date : 08/05/2026*
*Sources : brainstorming BP, étude de marché, contexte projet HiGame*
