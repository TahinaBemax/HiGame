---
session_id: "bp-session-001"
session_date: "2026-05-08"
session_active: false
workflow_completed: true
skill: "bmad-brainstorming"
agent: "bmad-agent-analyst (Mary)"
user: "Tahina-bemax"
communication_language: "french"
session_topic: "Plateforme de jeux traditionnels malgaches en ligne avec paris en argent réel"
session_goals:
  - "Avoir une idée claire sur comment le faire (technique)"
  - "Comprendre comment gagner de l'argent (modèle de revenus)"
  - "Identifier les difficultés et défis"
approach: "ai-recommended"
techniques:
  - "Contrainte Mapping"
  - "Assumption Reversal"
  - "Cross-Pollination"
  - "First Principles Thinking"
  - "Failure Analysis"
steps_completed: [1, 2, 3, 4]
total_ideas_generated: 15
total_themes_identified: 6
prioritized_concepts: 3
---

# Session de Brainstorming : Plateforme de Jeux Malgaches en Ligne

## Session Overview

**Facilitateur :** Mary (Analyste d'Affaires)
**Participant :** Tahina-bemax
**Date :** 2026-05-08
**Langue :** Français

**Sujet :** Informatisation des jeux traditionnels malgaches (Domino, Ludo, jeux de cartes) avec paris en argent réel — accessibles partout et à tout moment à Madagascar.

**Objectifs de la session :**
1. Clarifier le modèle technique et business
2. Comprendre le modèle de revenus (commission par partie)
3. Identifier les défis et difficultés potentiels

---

## 1. Contrainte Mapping — Cartographie des Contraintes

### Contraintes Légales
- **Zone grise juridique** — Aucune loi complète ne régule le jeu en ligne à Madagascar. La loi principale date de 1971. Aucune licence locale disponible pour un opérateur 100% en ligne.
- **Âge minimum** : 18 ans et plus
- **KYC** : Upload de CIN ou permis de conduire
- **Mobile Money** : Utilisable (Mvola, Orange Money)
- **Seul chemin légal existant** : Posséder un casino terrestre → extension en ligne (loi 2022)
- **Opérateurs offshore** : Betwinner, 1xBet servent Madagascar sous licence Curaçao sans être inquiétés
- **Risque réglementaire futur** : Possible loi interdisant les jeux d'argent en ligne (comme l'Inde 2025)
- **Taxes** : Impôt sur les sociétés 23%, pas de taxe spécifique sur le jeu en ligne

### Contraintes Techniques — Anti-Triche
- **Server-authoritative** : 100% de la logique côté serveur. Le client envoie juste ses actions.
- **RNG déterministe** avec seed vérifiable pour Domino et Ludo
- **Protocole Mental Poker** pour les jeux de cartes (engagements cryptographiques SHA-256)
- **Détection de bots** par analyse de timing (ML : Random Forest, LSTM — ~90% précision)
- **Anti-collusion** : Analyse statistique des patterns de jeu, détection IP, clustering
- **Logs de replay** complets pour audit et résolution de litiges

### Contraintes Techniques — Mobile Money
| Provider | API | Sandbox | Frais | Documentation |
|----------|-----|---------|-------|---------------|
| MVola (Telma) | REST API + SDK multi-langages | ✅ developer.mvola.mg | **3%** par transaction | Complète |
| Orange Money | Web Payment API (OTP) | ✅ developer.orange.com | Variable | Swagger/OpenAPI |
| Airtel Money | API disponible | ✅ | Variable | Limitée |

- **Solution recommandée** : PaidMada (github) — API unifiée MVola + OM + Airtel avec auto-détection du provider, SDK TypeScript, webhooks, mode mock
- **Défis** : Transactions asynchrones (30s-2min), idempotence requise, gestion des timeouts, disponibilité des API

### Contraintes Techniques — Gestion des Interruptions Réseau
- **WebSocket** persistent avec heartbeat 5-10s
- **Timeout** : 60s avant marquage AFK
- **Event sourcing** : Chaque action = événement horodaté avec actionId unique
- **Reconnexion** : Le client envoie `reconnect(sessionId)`, le serveur renvoie l'état complet
- **Idempotence** : Chaque action a un `actionId` unique côté client → pas de double exécution

### Contrainte — Développement Mobile
- **PWA** : Léger, pas de store, fonctionne sur 2G — mais moins de confiance pour l'argent réel
- **Natif (Flutter/React Native)** : Recommandé pour la confiance, la sécurité (biométrie, fingerprint), et les WebSockets natifs
- **Recommandation** : Flutter (perf native, un seul codebase, paquet mvola-dart existe)

---

## 2. Cross-Pollination — Inspirations des Marchés Similaires

### Marché Indien (le plus pertinent)
| Plateforme | Jeux | Modèle | Chiffres clés |
|------------|------|--------|---------------|
| Junglee Games (Flutter) | Rummy, Ludo, Carrom, Poker | Commission + tournois | $600M GTV, 150M users — fermé en 2025 (loi) |
| Yono Games | Ludo, Rummy, Poker, Domino | Commission + items | 25+ jeux dans 1 app |
| GameZo | Ludo, 8 Ball Pool, Cartes | Commission + tournois | Multi-plateforme |
| Ludo League | Ludo | Commission | 1M+ users, 10L+ daily winnings |

**Modèle standard validé :**
```
Frais d'entrée (1 000 Ar) → Pool (4 joueurs = 4 000 Ar)
→ Gagnant (85% = 3 400 Ar) → Plateforme (15% = 600 Ar)
→ -3% MVola → Marge réelle ~12%
```

### Marché Africain (Betika, SportyBet)
- Mobile-first extrême (app légère, basse consommation data)
- Mobile Money natif (M-Pesa / Mvola / OM)
- Programme d'affiliation : 25-40% de commission
- Localisation poussée (langue, promotions)

### Yalla Ludo (Moyen-Orient)
- Ludo + Domino + Cartes dans la même app
- VIP Subscription (abonnement premium)
- Voice chat communautaire → forte rétention

---

## 3. First Principles — Modèle Economique Final

### Concept innovant : Terrains Virtuels
| Type | Capacité | Pari max | Commission propriétaire | Prix |
|------|---------|----------|----------------------|------|
| 🆓 Terrain gratuit | 10 joueurs | 500 Ar | 0% | Gratuit |
| 🥇 Bronze | 50 places | 2 000 Ar | 2% | Payant |
| 🥈 Argent | 200 places | 10 000 Ar | 3% | Payant |
| 🥇 Or | Illimité | Illimité | 5% | Payant |
| 🎯 Tournoi | Événementiel | Buy-in élevé | 7% | Sur invitation |

### Sources de revenus de la plateforme
```
Revenus Plateforme =
   Commission partie (10-15%) — prélevée sur le gagnant
 + Vente de terrains (achat unique)
 + Tournois (buy-in majoré + droit d'entrée)
 + Items virtuels (dés, plateaux, avatars)
```
*Note : La plateforme ne prend pas de commission sur les locations de terrains — celle-ci revient entièrement au propriétaire du terrain.*

---

## 4. Failure Analysis — Analyse des Risques et Mitigations

### Risques Élevés
| Risque | Mitigation |
|--------|-----------|
| Loi interdisant les jeux d'argent en ligne | Structure offshore (licence Curaçao), argument jeu de compétence (skill-based), bascule free-to-play préparée |
| Problèmes avec les autorités fiscales | Comptabilité transparente, paiement IS (23%), avocat fiscaliste malgache |
| Commission trop élevée | Modéliser : marge plateforme réelle = 12% après déduction des 3% MVola |

### Risques Moyens
| Risque | Mitigation |
|--------|-----------|
| Détection de triche non détectée | Server-authoritative + logs replay + ML + modération utilisateur |
| Bug dans la gestion des parties | Event sourcing + tests automatisés + remboursement automatique |
| Détournement des fonds (sécurité wallet) | Pas de hot wallet centralisé, compte MVola/OM marchand dédié, audit externe, séparation des rôles |

---

## 5. Idées Organisées par Thème

### Thème 1 : Modèle d'Affaires & Revenus
- Commission plateforme (10-15%) sur chaque partie
- Vente de terrains virtuels (achat unique — Bronze/Argent/Or)
- Commission aux propriétaires de terrains (sur les parties jouées sur leur terrain)
- Tournois avec buy-in majoré
- Items virtuels (dés, plateaux, avatars, thèmes)

### Thème 2 : Architecture Technique
- Server-authoritative (anti-triche)
- Protocole Mental Poker + RNG déterministe pour les cartes
- WebSockets + heartbeat + event sourcing
- Natif avec Flutter (recommandé)
- ML pour détection de bots (patterns de jeu)

### Thème 3 : Gestion des Parties & Réseau
- Reconnexion automatique après coupure réseau
- Timeout 60s puis mode AFK/IA
- Event sourcing pour rejouer l'état exact
- Remboursement automatique en cas de bug système

### Thème 4 : Paiements Mobile Money
- API MVola (3% frais) + Orange Money + Airtel Money
- PaidMada comme solution unifiée open-source
- Idempotence via correlationId unique
- Callbacks webhooks + polling + retry automatique
- Sandbox gratuit pour tester sans credentials réels

### Thème 5 : Légal & Réglementaire
- Zone grise à Madagascar (pas d'interdiction explicite)
- Mitigation : société offshore, licence Curaçao, serveurs hors MG
- Argument jeu de compétence (skill-based)
- Prévoir bascule free-to-play si la loi change

### Thème 6 : Croissance & Acquisition
- Programme d'affiliation (25-40% commission)
- Parrainage (Refer & Earn)
- Terrain comme produit viral — chaque propriétaire attire ses amis
- Pratique gratuite avant passage au payant

---

## 6. Résultats de Priorisation

### Top 3 Thèmes Priorisés par le Participant

**1. Modèle d'Affaires & Revenus** (Priorité #1)
**2. Architecture Technique** (Priorité #2)
**3. Gestion des Parties & Réseau** (Priorité #3)

---

## 7. Plans d'Action

### Plan d'Action : Thème 1 — Modèle d'Affaires

| Priorité | Action | Ressources | Timeline |
|----------|--------|-----------|----------|
| 1 | Définir grille tarifaire terrains (Bronze/Argent/Or) et commission (%) | Étude de marché MG | 1 semaine |
| 2 | Modéliser l'économie unitaire : Commission - 3% MVola - coûts = marge | Tableur financier | 1 semaine |
| 3 | Développer système wallet + commission automatique | Backend dév | 4-6 semaines |
| 4 | Lancer bêta avec 1 jeu (Domino) pour valider le modèle | MVP dév | 8-12 semaines |

### Plan d'Action : Thème 2 — Architecture Technique

| Priorité | Action | Ressources | Timeline |
|----------|--------|-----------|----------|
| 1 | Choisir la stack : Flutter (recommandé) ou React Native | Tech lead décision | 1 semaine |
| 2 | Backend server-authoritative Node.js/TypeScript (WebSocket + API REST) | Backend dév | 4-6 semaines |
| 3 | Implémenter event sourcing (logs de replay) | Backend dév | 2 semaines |
| 4 | Intégrer PaidMada pour paiements unifiés MVola/OM/Airtel | Backend dév | 2 semaines |
| 5 | Anti-triche : RNG déterministe + ML détection + Mental Poker | Backend + Data | 6-8 semaines |

### Plan d'Action : Thème 3 — Gestion des Parties & Réseau

| Priorité | Action | Ressources | Timeline |
|----------|--------|-----------|----------|
| 1 | Protocole WebSocket : heartbeat 5s, timeout 60s, reconnexion auto | Architecture | 1 semaine |
| 2 | Event sourcing : chaque action = événement horodaté avec actionId | Backend | 2-3 semaines |
| 3 | Gestion parties interrompues : écran attente + timer reconnexion | Frontend + Backend | 2 semaines |
| 4 | Remboursement automatique en cas d'abandon ou bug | Backend | 1 semaine |
| 5 | Tests sous conditions réseau simulées (2G, coupures) | QA | 2 semaines |

---

## 8. Session Insights

**Points clés de la session :**
- **15 idées générées** à travers 5 techniques créatives
- **6 thèmes** identifiés couvrant tous les aspects du projet
- **3 thèmes prioritaires** sélectionnés avec plans d'action concrets
- **Innovation clé** : Concept de terrain virtuel avec commission pour le propriétaire — un modèle économique original qui combine achat unique, revenus passifs, et mécanique virale
- **Zone grise légale** identifiée et mitigée (offshore, skill-based argument, bascule free-to-play)
- **Solution de paiement unifiée** trouvée (PaidMada)
- **Timeline estimée** : 1-3 mois pour MVP, 6-8 mois pour plateforme complète

---

## 9. Prochaines Étapes Recommandées

1. **Semaine 1** : Valider la grille tarifaire et la stack technique
2. **Semaine 2-4** : Développer le backend server-authoritative avec event sourcing
3. **Semaine 4-6** : Intégrer PaidMada + système de wallet
4. **Semaine 8-12** : Lancer MVP (1 jeu : Domino) en bêta fermée
5. **Moins 3-4** : Ajouter Ludo et jeux de cartes
6. **Moins 6** : Lancer le programme d'affiliation et les tournois

---

*Document généré par Mary — Business Analyst (bmad-agent-analyst)*
*Session de brainstorming complétée le 08/05/2026*
