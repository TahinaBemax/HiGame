---
document_id: "prd-higame-mvp-v1"
document_date: "2026-05-08"
agent: "John (bmad-agent-pm)"
user: "Tahina-bemax"
communication_language: "french"
status: "draft"
sources:
  - docs/project-context.md
  - _bmad-output/brainstorming/bp-session-001.md
  - _bmad-output/planning-artifacts/research/market-jeux-traditionnels-malgaches-paris-argent-reel-research-2026-05-08.md
  - _bmad-output/planning-artifacts/strategique-higame.md
---

# HiGame — Product Requirements Document (MVP)

**Date :** 2026-05-08
**Auteur :** John (Product Manager)
**Version :** 1.0
**Statut :** Draft

---

## Table des Matières

1. Vision Produit
2. Personas
3. User Stories (MoSCoW)
4. Spécifications UI Textuelles
5. Flows UX Critiques
6. Règles Métier — Domino (Variante Malgache)
7. Dépendances Techniques Critiques
8. Critères d'Acceptation MVP
9. Backlog V2/V3
10. Métriques Produit

---

## 1. Vision Produit

### 1.1 Executive Summary

HiGame est une plateforme mobile de jeux traditionnels malgaches avec paris en argent réel. Le MVP couvre le Domino multijoueur (2 ou 4 joueurs) avec paiement via Mobile Money (MVola, Orange Money, Airtel Money). La plateforme prélève une commission de 12% sur le gagnant de chaque partie.

### 1.2 Positionnement

| Élément | Valeur |
|---------|--------|
| **Problème** | Les Malgaches jouent au Domino avec paris en physique — conflits, disponibilité limitée, pas de traçabilité |
| **Solution** | Plateforme mobile avec appairage automatique, wallet sécurisé, commissions transparentes |
| **Différenciation** | 1er opérateur combinant jeux traditionnels + Mobile Money direct + plateforme locale |
| **Marché** | Madagascar, 30k-70k joueurs en ligne actifs, marché vierge sur ce segment |
| **Modèle** | Commission 12% + terrains virtuels (V2) + tournois (V3) |

### 1.3 Objectifs MVP

| Objectif | Critère de succès |
|----------|-------------------|
| Lancer Domino multijoueur (2j + 4j) avec argent réel | 500 bêta-testeurs actifs pendant 30 jours |
| Intégration paiement Mobile Money (MVola en priorité) | Dépôt et retrait en < 5 minutes |
| Expérience fiable sur réseau 2G/3G | Taux de reconnexion > 95% |
| Anti-triche niveau 1 (server-authoritative) | 0 faille de triche exploitable |
| Wallet sécurisé avec solde en temps réel | Précision des transactions = 100% |

### 1.4 Périmètre MVP vs Hors Périmètre

| Dans le périmètre MVP | Hors périmètre MVP |
|-----------------------|--------------------|
| Domino 2 joueurs (1v1) | Ludo |
| Domino 4 joueurs (équipes de 2) | Jeux de cartes |
| Inscription par numéro de téléphone | Terrains virtuels |
| KYC (upload CIN) | Tournois |
| Wallet + Dépôt MVola | Items virtuels |
| Retrait vers Mobile Money | Messagerie / Voice chat |
| Salons privés (inviter des amis) | Classements globaux |
| Historique des parties | Parrainage / Affiliation |
| Commission 12% sur le gagnant | Mode free-to-play |

---

## 2. Personas

### 2.1 Faly — Joueur occasionnel urbain

| Attribut | Valeur |
|----------|--------|
| **Âge** | 22 ans |
| **Localisation** | Antananarivo |
| **Profession** | Étudiant |
| **Smartphone** | Samsung Galaxy A-series, Android |
| **Forfait data** | 500 MB - 1 GB/jour (Telma) |
| **Mobile Money** | MVola actif |
| **Budget jeu/mois** | 10 000 - 30 000 Ar |
| **Comportement** | Joue au Domino avec ses amis le week-end. Connaît les règles de base. A déjà perdu de l'argent dans des parties physiques sans pouvoir contester. |
| **Frustrations** | Pas toujours facile de trouver 4 joueurs disponibles en même temps. Conflits sur les règles. Pas de traçabilité des gains. |
| **Objectif HiGame** | Jouer au Domino à distance avec ses amis, gagner un peu d'argent, éviter les conflits. |
| **Utilisation** | 3-5 parties/semaine, surtout le soir (18h-23h), sessions de 15-30 min |

### 2.2 Dada — Joueur régulier traditionnel

| Attribut | Valeur |
|----------|--------|
| **Âge** | 42 ans |
| **Localisation** | Toamasina |
| **Profession** | Commerçant |
| **Smartphone** | Tecno Spark, Android entrée de gamme |
| **Forfait data** | 200 MB/jour (Orange) |
| **Mobile Money** | Orange Money principal, MVola secondaire |
| **Budget jeu/mois** | 50 000 - 100 000 Ar |
| **Comportement** | Joue au Domino 5-6 fois/semaine dans son quartier avec des amis. Mise 1 000-5 000 Ar par partie. Connaît toutes les variantes malgaches. |
| **Frustrations** | Parfois des joueurs ne paient pas après une défaite. La zone grise légale le rend méfiant des plateformes en ligne. |
| **Objectif HiGame** | Jouer en ligne quand ses partenaires physiques ne sont pas disponibles. Gagner de l'argent. Fonctionnalité "salon privé" pour jouer avec ses connaissances. |
| **Utilisation** | 10-15 parties/semaine, horaires variables (après-midi + soirée) |

### 2.3 Miora — Jeune mobile-first

| Attribut | Valeur |
|----------|--------|
| **Âge** | 19 ans |
| **Localisation** | Antsirabe |
| **Profession** | Lycéenne |
| **Smartphone** | iPhone SE (prêté par un parent) |
| **Forfait data** | WiFi à la maison + forfait data limité |
| **Mobile Money** | Airtel Money |
| **Budget jeu/mois** | 5 000 - 15 000 Ar |
| **Comportement** | Joue au Ludo et Domino sur des apps gratuites. N'a jamais joué avec argent réel. Attirée par les tournois et défis sociaux. |
| **Frustrations** | Les apps gratuites sont ennuyeuses (pas d'enjeu). Pas confiance pour mettre de l'argent en ligne. |
| **Objectif HiGame** | Découvrir le jeu avec petits enjeux (500 Ar). Fonctionnalités sociales. Design attrayant. |
| **Utilisation** | 2-3 parties/semaine, plutôt le week-end |

### 2.4 Solofo — Prescripteur / Propriétaire de terrain

| Attribut | Valeur |
|----------|--------|
| **Âge** | 35 ans |
| **Localisation** | Antananarivo |
| **Profession** | Agent immobilier |
| **Smartphone** | Xiaomi Redmi Note, Android |
| **Forfait data** | 2 GB/jour (Airtel) |
| **Mobile Money** | MVola + Orange Money |
| **Budget jeu/mois** | 100 000 - 300 000 Ar |
| **Comportement** | Joue au Domino, Ludo et cartes. A un large cercle social de joueurs. Organise des parties physiques avec paris chez lui. |
| **Frustrations** | Organiser des parties physiques demande du temps et de l'organisation. Veut monétiser son réseau. |
| **Objectif HiGame** | Acheter un terrain virtuel (V2) pour y attirer ses amis et gagner une commission sur leurs parties. Devient prescripteur de la plateforme. |

---

## 3. User Stories (MoSCoW)

### 3.1 Légende

| Tag | Signification | Quantité MVP |
|:---:|:-------------:|:------------:|
| **M** | Must-have — critique pour le lancement | 25 |
| **S** | Should-have — important, pas bloquant | 10 |
| **C** | Could-have — nice to have | 8 |
| **W** | Won't-have — pas avant V2/V3 | 7+ |

### 3.2 Must-Have (MVP)

| ID | User Story | Critères d'Acceptation |
|:--:|-----------|------------------------|
| M-01 | En tant que joueur, je veux créer un compte avec mon numéro de téléphone pour accéder à la plateforme. | 1. Saisie du numéro (+261). 2. Réception SMS avec code OTP à 4 chiffres. 3. Validation du code. 4. Redirection vers le KYC ou le dashboard. 5. Durée de validité OTP : 5 minutes. 6. Max 3 tentatives avant blocage 15 min. |
| M-02 | En tant que joueur, je veux uploader ma pièce d'identité (CIN ou permis) pour être vérifié (KYC). | 1. Capture photo ou sélection dans la galerie. 2. Support CIN recto/verso et permis de conduire. 3. Confirmation visuelle avant envoi. 4. Statut "En vérification" affiché. 5. Notification push quand vérifié (délai max 24h en manuel, immédiat si auto). 6. Sans KYC validé, pas de dépôt ni jeu possible. |
| M-03 | En tant que joueur, je veux déposer de l'argent depuis MVola vers mon wallet HiGame pour pouvoir jouer. | 1. Saisie du montant (min 1 000 Ar, max 200 000 Ar). 2. Redirection vers l'interface MVola (URL ou deep link). 3. Confirmation de la transaction côté MVola. 4. Mise à jour du wallet en temps réel. 5. Historique de transaction visible. 6. Notification de confirmation. 7. Temps total < 2 minutes. |
| M-04 | En tant que joueur, je veux voir mon solde wallet en temps réel pour savoir combien je peux miser. | 1. Solde affiché en Ar sur le dashboard. 2. Mise à jour après chaque dépôt, retrait, gain, perte. 3. Historique des 50 dernières transactions consultable. 4. Distinction solde disponible / en attente de validation. |
| M-05 | En tant que joueur, je veux créer une partie de Domino avec mise pour inviter d'autres joueurs. | 1. Choix du type de partie (1v1 ou 4 joueurs). 2. Saisie de la mise (500, 1 000, 2 000, 5 000, 10 000 Ar). 3. Option salon privé (code à partager) ou public. 4. Temps par coup (30s, 60s, 120s). 5. Commission 12% affichée. 6. Montant déduit du wallet à la création pour couvrir la mise. |
| M-06 | En tant que joueur, je veux rejoindre une partie existante pour commencer à jouer. | 1. Liste des parties publiques filtrée par mise. 2. Saisie d'un code pour salon privé. 3. Visualisation du nombre de places disponibles. 4. Montant de la mise affiché avant de rejoindre. 5. Confirmation avant déduction du wallet. |
| M-07 | En tant que joueur, je veux jouer une partie de Domino complète avec l'interface de jeu. | 1. Affichage des tuiles du joueur en bas de l'écran. 2. Plateau de jeu au centre avec la chaîne de domino. 3. Tuiles des adversaires visibles (dos). 4. Tour du joueur indiqué visuellement. 5. Sélection et pose de tuile par tap. 6. Bouton pioche actif si tuile disponible. 7. Timer de coup visible. 8. Notification sonore à mon tour. 9. Animation de pose fluide. |
| M-08 | En tant que joueur, je veux pouvoir piocher quand je ne peux pas poser de tuile. | 1. Bouton "Pioche" actif uniquement quand c'est mon tour. 2. Pioche disponible s'il reste des tuiles dans la réserve. 3. Si réserve vide, passage automatique au joueur suivant. 4. Message "Aucune tuile à piocher" si réserve vide. |
| M-09 | En tant que joueur, je veux voir le résultat de la partie avec le détail des gains. | 1. Annonce du gagnant (nom + avatar). 2. Score détaillé : points de chaque joueur. 3. Montant gagné après commission 12%. 4. Montant perdu pour les autres joueurs. 5. Tuiles restantes affichées pour tous. 6. Bouton "Rejouer" et "Quitter". |
| M-10 | En tant que joueur, je veux retirer mes gains depuis mon wallet HiGame vers MVola. | 1. Saisie du montant (min 2 000 Ar, max 500 000 Ar). 2. Vérification du solde disponible. 3. Confirmation par OTP SMS. 4. Temps de traitement affiché. 5. Notification quand le transfert est effectué. 6. Historique des retraits. |
| M-11 | En tant que joueur, je veux recevoir une notification quand c'est mon tour dans une partie. | 1. Notification push avec le nom de la partie. 2. Notification dans l'app (badge). 3. Redirection vers la partie au tap. 4. Timeout après 60s si pas de réponse. |
| M-12 | En tant que joueur, je veux pouvoir me reconnecter à une partie en cours après une coupure réseau. | 1. Détection de perte de connexion. 2. Écran "Reconnexion..." avec timer. 3. Reconnexion automatique dans les 60s. 4. Restauration complète de l'état du plateau. 5. Si > 60s, le joueur est marqué AFK et un remplacement ou timeout de partie s'applique. |
| M-13 | En tant que joueur, je veux consulter l'historique de mes parties pour voir mes performances. | 1. Liste chronologique des 50 dernières parties. 2. Statut : victoire/défaite/annulée. 3. Montant gagné/perdu. 4. Date et heure. 5. Durée de la partie. 6. Détail déroulé de la partie (replay textuel des coups). |
| M-14 | En tant que joueur, je veux signaler un joueur suspect (triche, comportement) pour maintenir l'intégrité de la plateforme. | 1. Menu "Signaler" dans le salon de jeu. 2. Motifs : triche suspectée, langage inapproprié, abandon volontaire répété. 3. Envoi du rapport avec les logs de la partie. 4. Confirmation "Signalement envoyé". 5. Modération côté admin. |
| M-15 | En tant que joueur, je veux paramétrer mes limites de dépôt pour gérer mon budget. | 1. Limite journalière, hebdomadaire ou mensuelle. 2. Montant personnalisable. 3. Blocage du dépôt si limite atteinte. 4. Possibilité de réduire la limite immédiatement. 5. Augmentation de limite avec délai de 72h. |
| M-16 | En tant que joueur, je veux voir les règles du Domino depuis l'app pour vérifier les variantes utilisées. | 1. Écran "Règles du jeu" accessible depuis le menu. 2. Règles complètes illustrées. 3. Variante malgoche explicitée. 4. Accessible sans inscription. |
| M-17 | En tant que joueur, je veux que le jeu soit 100% server-authoritative pour éviter la triche. | 1. Toute la logique de partie exécutée côté serveur. 2. Le client envoie uniquement les actions (poser, piocher). 3. Validation côté serveur de chaque action. 4. Logs de replay complets. |
| M-18 | En tant que joueur, je veux choisir parmi plusieurs mises pour adapter mon jeu à mon budget. | 1. Mises prédéfinies : 500, 1 000, 2 000, 5 000, 10 000 Ar. 2. Création de partie avec mise sélectionnée. 3. Filtre des parties disponibles par mise. |
| M-19 | En tant que joueur, je veux que la partie se termine proprement si un joueur abandonne ou se déconnecte. | 1. Délai de reconnexion : 60s. 2. Après timeout, le joueur est déclaré "abandon". 3. La partie continue avec les joueurs restants (si 1v1, l'abandon = défaite). 4. En 4 joueurs, si 1 abandonne les 3 restants peuvent continuer ou annuler la partie. 5. Remboursement partiel si partie annulée. |
| M-20 | En tant que joueur, je veux une expérience optimisée pour réseau lent (2G/3G). | 1. Taille de l'app < 30 MB. 2. Images/icônes compressées. 3. Chargement progressif du plateau. 4. WebSocket léger avec heartbeat 10s. 5. Cache local de l'état de partie. 6. Mode data saving (désactiver animations). |
| M-21 | En tant qu'admin, je veux pouvoir consulter les logs de replay d'une partie pour résoudre un litige. | 1. Interface admin de replay. 2. Affichage pas-à-pas de chaque action. 3. Horodatage de chaque action. 4. Extraction des logs en JSON. 5. Recherche par ID de partie, joueur, date. |
| M-22 | En tant que joueur, je veux que mes données personnelles soient protégées conformément à la réglementation. | 1. Chiffrement des données sensibles (CIN, numéro téléphone). 2. Pas de stockage des infos bancaires. 3. Consentement explicite lors de l'inscription. 4. Possibilité de supprimer son compte. 5. Délai de rétention des données : 3 ans après dernier login. |
| M-23 | En tant que joueur, je veux pouvoir jouer en salon privé avec mes amis uniquement. | 1. Création de salon : génération d'un code à 6 caractères. 2. Partage du code par lien ou message. 3. Rejoindre un salon privé par code. 4. Le salon n'apparaît pas dans la liste publique. 5. Option "verrouiller" une fois tous les joueurs présents. |
| M-24 | En tant que joueur, je veux être notifié quand mes gains sont crédités sur mon wallet. | 1. Notification push "Vous avez gagné X Ar !". 2. Notification in-app avec animation. 3. Solde mis à jour immédiatement. 4. Notification de retrait effectué. |
| M-25 | En tant que joueur, je veux annuler une partie que j'ai créée avant qu'elle ne commence pour récupérer ma mise. | 1. Bouton "Annuler la partie" dans le salon d'attente. 2. Remboursement immédiat de la mise. 3. Annulation impossible si la partie a commencé. 4. Notification aux autres joueurs. |
| M-26 | En tant que joueur, si j'attends trop longtemps dans un salon, je veux que le système me propose de fusionner avec un autre hôte solo pour démarrer une partie. | 1. Timer d'attente : 30s. 2. Après 30s, popup "X autres joueurs cherchent aussi une partie. Voulez-vous les rejoindre ?" 3. Proposition de fusion uniquement si même jeu, même mise et même type (1v1/4j). 4. Acceptation → re-création automatique d'un salon commun. 5. Refus → attente normale ou suggestion d'une autre mise disponible. 6. Si 2 hôtes solo 1v1 acceptent → partie créée immédiatement entre eux. 7. Si 2 hôtes 4j acceptent → fusion des 2 salons pour atteindre 4 joueurs plus vite. 8. Notification push "Un joueur cherche la même partie que vous !" |

### 3.3 Should-Have (MVP+)

| ID | User Story | Justification |
|:--:|-----------|:-------------:|
| S-01 | En tant que joueur, je veux pouvoir déposer depuis Orange Money et Airtel Money en plus de MVola. | Pas bloquant pour MVP si MVola fonctionne. Priorité V2 proche. |
| S-02 | En tant que joueur, je veux voir le classement des joueurs (winrate, gains totaux). | Moteur de motivation mais pas critique. |
| S-03 | En tant que joueur, je veux personnaliser mon pseudo et avatar. | Nécessaire pour l'identité mais un avatar par défaut suffit. |
| S-04 | En tant que joueur, je veux pouvoir consulter le profil des autres joueurs (statistiques publiques). | Social, mais pas critique pour le jeu. |
| S-05 | En tant que joueur, je veux un tutoriel interactif pour apprendre à jouer. | Important pour les nouveaux mais peut être une page statique. |
| S-06 | En tant que joueur, je veux pouvoir contester un résultat de partie (litige). | Procédure manuelle possible au MVP, auto plus tard. |
| S-07 | En tant que joueur, je veux un mode "pratique" sans argent pour apprendre les règles. | Bon pour l'acquisition mais pas prioritaire. |
| S-08 | En tant que joueur, je veux pouvoir chatter avec les autres joueurs pendant la partie. | Social mais peut attendre V2. |
| S-09 | En tant que joueur, je veux que le jeu fonctionne en mode paysage pour une meilleure expérience. | Amélioration UX, pas bloquant. |
| S-10 | En tant que joueur, je veux recevoir un récapitulatif hebdomadaire de mes performances par email/SMS. | Engagement, mais pas prioritaire. |

### 3.4 Could-Have (V2)

| ID | User Story |
|:--:|-----------|
| C-01 | En tant que joueur, je veux acheter un terrain virtuel et percevoir une commission sur les parties jouées sur mon terrain. |
| C-02 | En tant que joueur, je veux jouer au Ludo multijoueur avec argent réel. |
| C-03 | En tant que joueur, je veux inviter des amis et recevoir un bonus de parrainage. |
| C-04 | En tant que joueur, je veux des items virtuels (dés personnalisés, plateaux, avatars) à acheter. |
| C-05 | En tant que joueur, je veux des animations et effets visuels pendant la partie. |
| C-06 | En tant que joueur, je veux pouvoir utiliser le mode sombre (dark mode). |
| C-07 | En tant que joueur, je veux pouvoir lier plusieurs comptes Mobile Money (MVola + OM + Airtel). |
| C-08 | En tant que joueur, je veux un système de niveaux et badges de progression. |

### 3.5 Won't-Have (V3+)

| ID | User Story |
|:--:|-----------|
| W-01 | En tant que joueur, je veux participer à des tournois avec prize pool. |
| W-02 | En tant que joueur, je veux jouer aux cartes (Fanorona, Tselatra, autres jeux malgaches). |
| W-03 | En tant que joueur, je veux du voice chat pendant les parties. |
| W-04 | En tant que joueur, je veux une version iOS de l'application. |
| W-05 | En tant que joueur, je veux une version Web jouable sans installation. |
| W-06 | En tant que joueur, je veux des replays vidéo des parties. |
| W-07 | En tant que joueur, je veux pouvoir streamer mes parties en direct. |
| W-08 | En tant que joueur, je veux de l'IA adversaire pour jouer hors ligne. |

---

## 4. Spécifications UI Textuelles

### 4.1 Arborescence des écrans

```
Splash Screen
└── Onboarding (3 slides)
    └── Inscription (numéro + OTP)
        └── KYC (upload pièce d'identité)
            └── Dashboard / Lobby
                ├── Wallet
                │   ├── Dépôt
                │   └── Retrait
                ├── Créer une partie
                ├── Rejoindre une partie
                │   └── Liste des salons
                ├── Salon d'attente
                │   └── Plateau Domino
                │       └── Résultat partie
                ├── Profil
                │   ├── Historique
                │   └── Paramètres
                └── Règles du jeu
```

### 4.2 Écran : Splash Screen

| Élément | Spécification |
|---------|---------------|
| **Layout** | Centré, fond bleu foncé (#1A237E). Logo HiGame au centre. Sous-texte "Jeux malgaches, argent réel". |
| **Durée** | 2 secondes max. |
| **Comportement** | Vérification session existante → si token valide → Dashboard. Si pas de session → Onboarding. |
| **États** | Loading : logo + spinner. |

### 4.3 Écran : Onboarding (3 slides)

| Slide | Titre | Sous-texte | Visuel |
|:-----|:------|:-----------|:-------|
| 1 | "Joue au Domino et gagne" | "Affronte des joueurs de tout Madagascar et gagne de l'argent réel." | Tuiles de domino + pièces d'or. |
| 2 | "Paiement Mobile Money" | "Dépose et retire via MVola, Orange Money ou Airtel Money en 1 clic." | Logos MVola, OM, Airtel + flèche wallet. |
| 3 | "Sécurisé et transparent" | "Parties 100% équitables, commission claire de 12%, retrait instantané." | Bouclier + cadenas + checkmark. |

**Navigation :** Dots en bas, swipe horizontal, bouton "Suivant" et "Commencer" sur le dernier slide.

### 4.4 Écran : Inscription (numéro de téléphone)

| Composant | Spécification |
|-----------|---------------|
| **Header** | "Créer un compte" + bouton retour. |
| **Champ téléphone** | Préfixe +261 fixe. Saisie du numéro à 9 chiffres. Format masqué : XX XX XXX XX. |
| **Bouton** | "Recevoir le code" — désactivé si < 9 chiffres. |
| **Validation** | OTP à 4 chiffres reçu par SMS. Timer de 30s avant renvoi. 3 tentatives max. |
| **États** | Erreur : "Numéro invalide", "Code incorrect". Timeout : "Renvoyer le code dans Xs". |
| **Légal** | Checkbox "J'accepte les conditions d'utilisation et la politique de confidentialité". Liens vers les CGU. |

### 4.5 Écran : KYC (Vérification d'identité)

| Composant | Spécification |
|-----------|---------------|
| **Header** | "Vérification d'identité". Sous-titre "Obligatoire pour jouer avec argent réel." |
| **Type de pièce** | Sélecteur : Carte d'identité nationale (CIN), Permis de conduire. |
| **Upload** | Bouton "Prendre en photo" / "Choisir dans la galerie". |
| **Preview** | Aperçu de la photo avant validation. |
| **Statut** | 3 états : "En attente" (icône horloge), "Vérifiée" (icône check verte), "Rejetée" (icône croix rouge + motif). |
| **CGU** | Texte : "Vos données sont chiffrées et conformes à la réglementation sur la protection des données." |

### 4.6 Écran : Dashboard / Lobby

| Zone | Contenu |
|------|---------|
| **Header** | Logo HiGame à gauche. Solde wallet en Ar au centre avec icône oeil (afficher/masquer). Icône notification à droite. |
| **Bannière** | Espace promotionnel (MVP : message de bienvenue ou "Joue au Domino maintenant !"). |
| **Section jeux** | Tuiles cliquables : Domino (actif, avec badge "Beta"). Ludo (grisé, "Bientôt"). Cartes (grisé, "Bientôt"). |
| **Section actions** | Boutons : "Créer une partie", "Rejoindre une partie", "Wallet", "Historique". |
| **Menu bas** | 4 tabs : Accueil, Créer/Rejoindre, Wallet, Profil. |

**États :**
- Chargement : skeleton loader.
- Vide : message "Bienvenue sur HiGame ! Commence par déposer de l'argent."
- Erreur : "Impossible de charger le solde" + bouton réessayer.
- KYC en attente : bannière orange "Vérification en cours — certains fonctionnalités sont limitées."

### 4.7 Écran : Wallet

| Composant | Spécification |
|-----------|---------------|
| **Header** | "Mon Portefeuille". |
| **Solde** | Affichage large du solde total en Ar. Bouton oeil pour masquer. |
| **Raccourcis** | 2 boutons : "Déposer" (vert), "Retirer" (rouge/orange). |
| **Section historique** | Liste chronologique, 10 dernières transactions. Chaque ligne : icône (+/- vert/rouge), montant, date, statut (Succès/En cours/Échoué). |
| **Bouton** | "Voir tout l'historique". |

**États :**
- Vide : "Aucune transaction pour le moment."
- Erreur chargement : "Impossible de charger l'historique."

### 4.8 Écran : Dépôt

| Composant | Spécification |
|-----------|---------------|
| **Header** | "Déposer de l'argent". |
| **Montants rapides** | Boutons : 5 000, 10 000, 20 000, 50 000, 100 000 Ar. |
| **Champ personnalisé** | Input avec curseur. Min 1 000 Ar, max 200 000 Ar. |
| **Mode de paiement** | Sélecteur : MVola (recommandé), Orange Money, Airtel Money. Chaque option avec logo du provider. |
| **Frais** | Ligne "Frais de transaction" (gratuit pour le dépôt, les 3% sont côté provider). |
| **Bouton** | "Déposer" → redirection vers le provider Mobile Money. |
| **Confirmation** | Écran de confirmation avec animation de succès ou échec. |

**États :**
- Loading : spinner pendant la redirection Mobile Money.
- Succès : "XX Ar crédités sur votre wallet !" + animation confettis.
- Échec : "Transaction échouée. Veuillez réessayer." + motifs possibles.
- Timeout : "La transaction a pris trop de temps. Vérifiez dans l'historique."

### 4.9 Écran : Retrait

| Composant | Spécification |
|-----------|---------------|
| **Header** | "Retirer de l'argent". |
| **Solde disponible** | Affiché. |
| **Montant** | Input avec min 2 000 Ar, max 500 000 Ar. |
| **Mode de retrait** | Sélecteur : MVola, Orange Money, Airtel Money. Le numéro du compte est celui du KYC (vérifié). |
| **Frais** | "Aucun frais HiGame. Des frais MVola de 3% peuvent s'appliquer." |
| **Délai** | "Traitement sous 24h ouvrées. Première demande traitée sous 72h." |
| **Bouton** | "Retirer" → confirmation OTP par SMS. |
| **Confirmation** | Écran : "Demande de retrait enregistrée. Vous recevrez l'argent sous 24h." |

**États :**
- KYC non validé : message bloquant "Vérification d'identité requise avant tout retrait."
- Solde insuffisant : message + montant max suggéré.

### 4.10 Écran : Créer une partie

| Composant | Spécification |
|-----------|---------------|
| **Header** | "Créer une partie". |
| **Jeu** | Sélecteur : Domino (seul choix au MVP). |
| **Type** | Sélecteur : 1v1 (2 joueurs) ou 4 joueurs (2 équipes). |
| **Mise** | Sélecteur : 500, 1 000, 2 000, 5 000, 10 000 Ar. |
| **Mode** | Bascule : Public / Privé (code). |
| **Temps par coup** | Sélecteur : 30s, 60s, 120s. |
| **Récapitulatif** | Encart : "Mise : X Ar. Commission HiGame : 12% (X Ar). Gain potentiel : X Ar." |
| **Bouton** | "Créer la partie" → vérification solde suffisant → salon d'attente. |

### 4.11 Écran : Rejoindre une partie

| Composant | Spécification |
|-----------|---------------|
| **Header** | "Rejoindre une partie". |
| **Section rapide** | "Rejoindre un salon privé" : champ code 6 caractères + bouton "Rejoindre". |
| **Section publique** | Filtres : par mise (toutes/500/1000/2000/5000/10000), par type (1v1/4 joueurs). |
| **Liste des salons** | Chaque ligne : type (1v1/4j), mise, nombre de joueurs actuels/total, temps par coup, bouton "Rejoindre". |
| **Bannière fusion** | Si l'utilisateur attend sur l'écran rejoindre > 10s → bannière "X joueurs cherchent aussi. Créez une partie et on les trouve pour vous !" + bouton "Créer avec matching auto". |
| **Vide** | "Aucune partie disponible pour ces critères. Créez-en une !" + lien vers créer. |

### 4.12 Écran : Salon d'attente

| Composant | Spécification |
|-----------|---------------|
| **Header** | "Salon #XXXX" + mode (Public/Privé) + code si privé. |
| **Infos partie** | Mise, type, temps par coup. |
| **Joueurs** | Avatars + pseudos des joueurs. Places vides : silhouette + "En attente...". |
| **Inviter** | Bouton "Partager le code" (si privé) — copie le code dans le presse-papier. |
| **Chat** | Mini chat texte (optionnel, V2). |
| **Boutons** | Si créateur : "Annuler". Si tous les joueurs sont prêts → "Démarrer la partie" devient actif. Si participant : "Quitter le salon". |

**États :**
- Temps d'attente : timer "Recherche de joueurs..." avec animation.
- Privé : "Partagez ce code avec vos amis : XXXXXX".
- Attente longue (30s+) : popup de suggestion de fusion.
  - "X autres joueurs cherchent aussi une partie en [mise] Ar."
  - Boutons : "Rejoindre" (vert) / "Attendre encore" (gris).
  - Si accepté : animation de fusion + redirection vers le nouveau salon commun.
  - Si refusé : popup disparaît, revient après 20s supplémentaires.
- Fusion en cours : overlay "Fusion des salons..." + spinner + nom des autres joueurs qui rejoignent.
- Aucune fusion possible : after 60s, message "Difficile de trouver des joueurs ? Essayez une mise plus populaire (500 ou 1 000 Ar)." + bouton "Changer la mise".

### 4.13 Écran : Plateau Domino

| Zone | Contenu |
|------|---------|
| **Barre info** | Timer du coup, nom du joueur actif, icône pause (si applicable). |
| **Plateau (centre)** | Zone de jeu : chaîne de domino horizontalement. Tuiles adverses visibles (face cachée). Tuiles posées affichées. |
| **Main du joueur (bas)** | Tuiles du joueur disposées en éventail, sélectionnables par tap. La tuile sélectionnée se soulève. |
| **Info adversaire (haut)** | Nombre de tuiles restantes de l'adversaire (icône points d'interrogation). |
| **Boutons d'action** | "Poser" (après sélection d'une tuile), "Piocher" (si disponible), "Passer" (si pioche vide). |
| **Overlay** | Lors du tour adverse : "Tour de [pseudo]" avec animation d'attente. |

**États :**
- Mon tour : bordure lumineuse autour de la main. Timer en cours.
- Tour adverse : timer adverse en cours, ma main visible mais non interactible.
- Pioche disponible : badge "X tuiles restantes" sur le bouton pioche.
- Blocage : "Personne ne peut jouer. Calcul des scores..." avant résultat.
- Victoire/domino : animation "Domino !" + écran de résultat.
- Reconnexion : overlay semi-transparent "Reconnexion..." + spinner.

**Règles d'affichage :**
- La chaîne de domino s'affiche horizontalement avec défilement si trop longue.
- Les doubles sont posés perpendiculairement (en travers).
- Score de chaque joueur affiché en permanence dans des coins.

### 4.14 Écran : Résultat de partie

| Composant | Spécification |
|-----------|---------------|
| **Header** | "Partie terminée !" avec icône trophée si victoire. |
| **Gagnant** | Avatar + pseudo + "A gagné !". |
| **Détail scores** | Tableau : joueur, points, tuiles restantes (somme des points), résultat. |
| **Gain** | Montant gagné (après commission 12%) affiché en vert avec animation. |
| **Tuiles** | Bouton "Voir les tuiles de chaque joueur". |
| **Boutons** | "Revanche !" (recrée une partie identique). "Retour au lobby". |

**États :**
- Victoire : animation positive (confettis, couleur verte).
- Défaite : message neutre, couleur grise/bleue.
- Égalité (rare au Domino) : mentionné explicitement.

### 4.15 Écran : Profil

| Composant | Spécification |
|-----------|---------------|
| **Header** | "Mon profil". |
| **Avatar** | Image circulaire, modifiable. |
| **Pseudo** | Affiché, modifiable (1 changement/30 jours). |
| **Statistiques** | Nombre de parties, victoires, défaites, winrate %, gains totaux, pertes totales. |
| **KYC** | Statut : vérifié / en attente / rejeté. |
| **Boutons** | "Historique", "Paramètres", "Règles du jeu", "Centre d'aide", "Déconnexion". |

### 4.16 Écran : Paramètres

| Section | Éléments |
|---------|----------|
| **Compte** | Modifier pseudo, changer avatar, voir statut KYC. |
| **Notifications** | Bascule notifications push, son du jeu, vibration. |
| **Limites de jeu** | Limite de dépôt journalière/hebdomadaire/mensuelle. Auto-exclusion (24h, 7j, 30j). |
| **Affichage** | Langue (français, malgache — à venir). Mode sombre (V2). |
| **Sécurité** | Voir mes sessions, déconnecter toutes les sessions. |
| **Compte** | Supprimer mon compte (avec confirmation). |

### 4.17 Écran : Règles du jeu

| Section | Contenu |
|---------|---------|
| **Header** | "Règles du Domino". |
| **Sections** | Objectif, Mise en place, Déroulement, Scores, Fin de partie, Variante malgache. |
| **Illustrations** | Schémas explicatifs (position des tuiles, chaîne, double). |
| **Accessible** | Depuis le menu profil, sans compte. |

### 4.18 Écran : Historique des parties

| Composant | Spécification |
|-----------|---------------|
| **Header** | "Historique". |
| **Filtres** | Toutes / Victoires / Défaites. |
| **Liste** | 20 parties par page, scroll infini. Chaque ligne : date, type (1v1/4j), mise, résultat (gain/perte en Ar), durée. |
| **Détail** | Tap sur une partie → replay textuel des coups + scores détaillés. |

---

## 5. Flows UX Critiques

### 5.1 Flow : Inscription → KYC

```
[Splash] → [Onboarding 1-3] → [Inscription : numéro] → [OTP SMS] → [KYC : upload pièce]
    → [Vérification manuelle ou auto] → [Dashboard]
```

| Étape | Écran | Action | Validation |
|:-----:|:-----:|--------|:----------:|
| 1 | Splash | App launch | Auto-vérification session |
| 2 | Onboarding | Swipe 3 slides | — |
| 3 | Inscription | Saisie numéro +261 XX XX XXX XX | Format valide |
| 4 | Inscription | Tap "Recevoir le code" | Envoi SMS OK |
| 5 | Inscription | Saisie OTP 4 chiffres | Code correct |
| 6 | KYC | Sélection type pièce + upload photo | Image valide |
| 7 | KYC | Tap "Envoyer" | Upload réussi |
| 8 | Dashboard | Attente vérification | Statut "en cours" |
| 9 | Notification | Vérification acceptée | Accès complet |

### 5.2 Flow : Dépôt Mobile Money

```
[Dashboard : wallet] → [Dépôt : montant + provider] → [Redirection Mobile Money]
    → [Confirmation paiement] → [Callback webhook] → [Solde mis à jour]
```

| Étape | Écran | Action | Délai max |
|:-----:|:-----:|--------|:---------:|
| 1 | Dashboard | Tap solde ou icône wallet | — |
| 2 | Wallet | Tap "Déposer" | — |
| 3 | Dépôt | Sélection montant (10 000 Ar) | — |
| 4 | Dépôt | Sélection provider (MVola) | — |
| 5 | Dépôt | Tap "Déposer" | — |
| 6 | Redirection | Redirection vers USSD ou app MVola | 2s |
| 7 | Mobile Money | Confirmation utilisateur sur MVola | 30s-2min |
| 8 | Wallet | Réception callback → mise à jour solde | 5s après confirmation |
| 9 | Dashboard | Notification push "10 000 Ar crédités" | Immédiat |

### 5.3 Flow : Partie Domino (Création → Victoire)

```
[Dashboard] → [Créer partie : mise + mode] → [Salon d'attente]
    → [30s écoulées ? → Recherche hôtes solo compatibles]
    → [Fusion proposée ? → Oui → Salon commun] → [Non → Attente ou autre mise]
    → [Joueurs prêts] → [Partie : distribution → poses → pioches → domino !]
    → [Résultat : calcul score → déduction commission → crédit gagnant] → [Revanche / Lobby]
```

| Étape | Écran | Action | Délai |
|:-----:|:-----:|--------|:-----:|
| 1 | Dashboard | Tap "Créer une partie" | — |
| 2 | Création | Choix type (1v1), mise (1 000 Ar), public | — |
| 3 | Création | Tap "Créer" → déduction 1 000 Ar du wallet | Immédiat |
| 4 | Salon | Attente 2e joueur (public) | Variable |
| 5 | Salon | 30s écoulées → système scanne les hôtes solo avec même jeu/mise/type | 30s |
| 6 | Salon | Popup "X autres joueurs cherchent aussi. Les rejoindre ?" | 10s pour répondre |
| 7 | Salon | Si oui → fusion des salons, partie prête plus vite | Immédiat |
| 8 | Salon | Si non → retour attente, nouvelle proposition dans 20s ou suggestion de changer de mise | — |
| 9 | Salon | Joueurs rassemblés → déduction des mises | Immédiat |
| 5 | Salon | 2e joueur rejoint → déduction 1 000 Ar de son wallet | Immédiat |
| 6 | Plateau | Distribution 7 tuiles chacun | 1s |
| 7 | Plateau | Pose du premier double (ou tirage au sort) | — |
| 8 | Plateau | Tours de jeu (poses, pioches) | 5-15 min |
| 9 | Plateau | Joueur fait Domino (pose dernière tuile) | — |
| 10 | Résultat | Calcul : points adverses, commission 12% | 2s |
| 11 | Résultat | Crédit du gain au gagnant : 1 760 Ar (2 000 - 240) | Immédiat |
| 12 | Résultat | Affichage du résultat + option revanche | — |

### 5.4 Flow : Victoire → Wallet crédité

```
[Plateau : domino !] → [Résultat : calcul des scores] → [Commission 12% prélevée]
    → [Gain crédité au wallet du gagnant] → [Notification push] → [Dashboard : solde mis à jour]
```

**Calcul détaillé (exemple 1v1, mise 2 000 Ar, commission 12%) :**

| Élément | Valeur |
|---------|:------:|
| Mise de chaque joueur | 2 000 Ar |
| Pool total | 4 000 Ar |
| Commission HiGame (12% × 4 000) | 480 Ar |
| Gain net du gagnant | 3 520 Ar |
| Perte du perdant | 2 000 Ar |

### 5.5 Flow : Retrait vers MVola

```
[Dashboard : wallet] → [Retrait : montant] → [Sélection MVola] → [Confirmation OTP]
    → [Demande soumise] → [Traitement admin ou auto] → [Transfert MVola]
    → [Notification "Retrait effectué"]
```

| Étape | Écran | Action | Délai |
|:-----:|:-----:|--------|:-----:|
| 1 | Dashboard | Tap "Wallet" | — |
| 2 | Wallet | Tap "Retirer" | — |
| 3 | Retrait | Saisie montant (20 000 Ar) | — |
| 4 | Retrait | Sélection MVola | — |
| 5 | Retrait | Tap "Retirer" → OTP SMS | 5s |
| 6 | Retrait | Saisie OTP → soumission demande | 5s |
| 7 | Wallet | Statut "Demande en cours" | — |
| 8 | Notification | Transfert MVola effectué | < 24h |
| 9 | Wallet | Statut "Effectué", solde mis à jour | — |

---

## 6. Règles Métier — Domino (Variante Malgache)

### 6.1 Généralités

```
Jeu : Domino
Variante : Malgache (standard)
Nombre de joueurs : 2 (1v1) ou 4 (2 équipes de 2)
Matériel : Jeu de 28 tuiles (double-six)
Distribution : 7 tuiles par joueur
Réserve (pioche) : Tuiles restantes, face cachée
```

### 6.2 Mise en place

1. Les 28 tuiles sont mélangées face cachée.
2. Chaque joueur pioche 7 tuiles.
3. Les 0 tuiles restantes (28 - 4×7 = 0 pour 4j, 28 - 2×7 = 14 pour 2j) forment la réserve (pioche).
4. Le joueur qui possède le double-six (6|6) commence la partie en posant cette tuile au centre.
5. Si personne n'a le double-six, le joueur avec le double le plus élevé commence (double-cinq, double-quatre, etc.).
6. En équipe (4 joueurs), les partenaires sont assis en vis-à-vis (positions 1 et 3 contre 2 et 4).

### 6.3 Déroulement du jeu

1. Le premier joueur pose le double le plus élevé au centre du plateau. Ce double est placé perpendiculairement (en travers) à la chaîne.
2. Le jeu se déroule dans le sens horaire.
3. À chaque tour, un joueur peut poser une de ses tuiles à une extrémité libre de la chaîne.
4. Une tuile peut être posée si l'un de ses deux chiffres correspond au chiffre à l'extrémité libre de la chaîne.
5. Quand un double est posé, il est placé perpendiculairement à la chaîne (en travers). Les deux extrémités du double comptent comme jouables.
6. Les doubles ne sont pas des "spinners" (pas d'extension sur 4 côtés). La chaîne reste linéaire.
7. Si un joueur ne peut pas jouer, il pioche une tuile dans la réserve.
8. S'il peut jouer la tuile piochée, il la pose immédiatement.
9. S'il ne peut toujours pas jouer, ou s'il a pioché et ne veut pas poser, il passe son tour.
10. Si la réserve est épuisée, le joueur passe directement.

### 6.4 Fin de la manche

La manche se termine dans l'un des cas suivants :

**Cas A — Domino :** Un joueur pose sa dernière tuile et crie "Domino !". La manche s'arrête immédiatement.

**Cas B — Blocage :** Aucun joueur ne peut poser de tuile (même après pioche). La manche est bloquée.

### 6.5 Calcul des scores

**Cas A — Domino :**
- Le gagnant marque la somme des points (pip count) des tuiles restantes de TOUS les adversaires.
- Arrondi à la dizaine supérieure.
- En équipe (4 joueurs), les points des deux adversaires sont additionnés.

**Cas B — Blocage :**
- Chaque joueur compte les points de ses tuiles restantes.
- Le joueur (ou l'équipe) avec le total le plus bas gagne.
- Le gagnant marque la différence entre son total et le total de l'adversaire (ou la somme des deux adversaires en 4 joueurs).
- Arrondi à la dizaine supérieure.

**Exemple de calcul (Domino, 1v1) :**
- Joueur A : Domino ! (plus de tuiles)
- Joueur B : tuiles restantes [3|4] (7 pts) + [1|5] (6 pts) + [2|2] (4 pts) = 17 pts
- Arrondi à la dizaine supérieure : 20 pts
- Joueur A marque 20 points pour la manche.

### 6.6 Fin de la partie

- La partie se joue en **100 points** (configurable : 100, 200).
- Le premier joueur (ou équipe) à atteindre ou dépasser le seuil gagne la partie.
- Si les deux équipes dépassent le seuil dans la même manche (Cas B), la plus haute marque gagne.

### 6.7 Règles spéciales

| Règle | Description |
|-------|-------------|
| **Double départ** | La partie commence toujours par le plus haut double, posé en travers. |
| **Pioche obligatoire** | Un joueur DOIT piocher s'il ne peut pas poser. Il ne peut passer que si la réserve est vide. |
| **Blanc (0)** | Les tuiles blanches (0|X) comptent 0 point pour le score mais sont des tuiles normales pour le jeu. |
| **Égalité** | En cas d'égalité parfaite en Cas B, la manche est rejouée. |

### 6.8 Commission et flux financier

| Élément | Valeur |
|---------|:------:|
| Commission plateforme | 12% du pool total |
| Calcul commission | (Mise × nombre de joueurs) × 12% |
| Gain net du gagnant | Pool total - commission |
| Paiement | Crédité immédiatement sur le wallet |
| Perte du perdant | Mise initiale (déduite avant la partie) |

---

## 7. Dépendances Techniques Critiques

### 7.1 Paiements — PaidMada

| Élément | Détail |
|---------|--------|
| **Dépendance** | Intégration API PaidMada (ou API directe MVola) |
| **Priorité** | 🔴 Critique — sans paiement, pas de dépôt ni retrait |
| **Risque** | Latence des transactions asynchrones, indisponibilité API |
| **Mitigation** | Mode mock en développement, fallback manuel, système d'idempotence |
| **MVP scope** | MVola uniquement (le plus utilisé, 73%) |

**Exigences techniques :**
- Endpoints : `initiateDeposit`, `checkTransactionStatus`, `initiateWithdrawal`
- Webhook callback pour confirmer les transactions asynchrones
- Système d'idempotence via `correlationId` unique
- Polling toutes les 5s avec max 10 tentatives (50s)
- Timeout → marquer comme échoué + remboursement automatique

### 7.2 Anti-Triche — Server-Authoritative

| Mécanisme | Niveau MVP | Priorité |
|-----------|:----------:|:--------:|
| Logique 100% serveur | ✅ Implémenté | 🔴 Critique |
| Validation des actions côté serveur | ✅ Implémenté | 🔴 Critique |
| Logs de replay complets | ✅ Implémenté | 🔴 Critique |
| RNG déterministe (seed vérifiable) | ✅ Implémenté | 🟡 Important |
| Détection de bots (ML) | ❌ V2 | 🟢 Optionnel |
| Anti-collusion (analyse IP) | ❌ V2 | 🟢 Optionnel |
| Mental Poker Protocol | ❌ V3 (Cartes) | 🟢 Optionnel |

### 7.3 Gestion réseau et WebSocket

| Spécification | Valeur |
|---------------|--------|
| Protocole temps réel | WebSocket (socket.io ou ws natif) |
| Heartbeat | 10s |
| Timeout déconnexion | 60s |
| Reconnexion | Session ID → état complet restauré |
| Compression | Payloads JSON compressés (gzip) |
| Cache offline | Dernier état connu stocké localement |

### 7.4 Event Sourcing

| Principe | Application |
|----------|-------------|
| Toute action = événement | Joueur pose, pioche, passe, se connecte, etc. |
| Stockage | Table PostgreSQL `game_events` (partie_id, action, payload, timestamp) |
| Rejeu | Reconstruire l'état complet à partir des événements |
| Audit | Résolution de litiges, modération |
| Backup | Export hebdomadaire des logs |

### 7.5 Sécurité et Wallet

| Exigence | Implémentation |
|----------|----------------|
| Solde wallet | PostgreSQL avec verrouillage optimiste (optimistic locking) |
| Double dépense | Redis lock + idempotence |
| Transactions | Atomicité : toute transaction est commit/rollback |
| Hot wallet | Pas de hot wallet centralisé. Compte MVola marchand dédié. |
| Virement manuel | Premier palier : transferts manuels en phase bêta |
| Audit trail | Toute modification de solde est loguée |

### 7.6 Système de matching & fusion de salons

| Spécification | Valeur |
|---------------|--------|
| **Déclencheur** | Timer de 30s dans un salon d'attente public |
| **Algorithme** | Matching sur (jeu, type, mise) strictement identiques |
| **Scan** | Recherche des hôtes solo (créateurs de salon) avec mêmes critères |
| **Proposition** | Popup simultanée envoyée à tous les hôtes compatibles |
| **Acceptation** | Tous les hôtes acceptent → fusion des salons (création d'un nouveau salon commun avec tous les joueurs) |
| **Refus** | Si un hôte refuse → les autres hôtes sont notifiés "L'autre joueur a décliné" |
| **Timeout réponse** | 10s pour répondre |
| **Nouvelle tentative** | Après 20s supplémentaires si pas d'acceptation |
| **Fallback** | Après 60s d'attente totale → suggestion de changer de mise vers un palier plus populaire |
| **Création salon fusionné** | Nouveau salon ID, tous les joueurs y sont redirigés, historique de l'attente conservé |

**Backend :** Service de matching Redis-based. Les hôtes solo sont enregistrés dans un sorted set Redis avec leur jeu/type/mise comme clé composite. Scan périodique toutes les 5s.

### 7.7 Stack technique MVP

| Couche | Technologie | Justification |
|--------|:-----------:|:-------------:|
| Frontend | Flutter | Performances natives, WebSocket natif, codebase unique Android, paquet mvola-dart |
| Backend | Node.js/TypeScript | WebSocket natif, API REST, event sourcing, écosystème riche |
| Base de données | PostgreSQL | Données persistantes, transactions ACID, requêtes complexes |
| Cache/temps réel | Redis | Files d'attente, sessions WebSocket, locks, cache |
| Paiement | PaidMada | API unifiée MVola/OM/Airtel, SDK TypeScript, webhooks, mode mock |

---

## 8. Critères d'Acceptation MVP

### 8.1 Conditions Go/No-Go pour la bêta fermée (500 testeurs)

| # | Critère | Indicateur | Statut |
|:-:|---------|:----------:|:------:|
| 1 | Inscription et KYC fonctionnels | Taux de succès > 95% | ☐ |
| 2 | Dépôt MVola opérationnel | Temps moyen < 2 min, taux succès > 90% | ☐ |
| 3 | Création et rejoindre partie (1v1) | 100% des cas de test passent | ☐ |
| 4 | Création et rejoindre partie (4 joueurs) | 100% des cas de test passent | ☐ |
| 5 | Partie Domino complète sans bug | 50 parties de test sans erreur critique | ☐ |
| 6 | Calcul des scores correct | Match règles métier section 6 | ☐ |
| 7 | Commission 12% prélevée correctement | Vérifié sur 100 parties test | ☐ |
| 8 | Gain crédité au wallet | Temps < 5s après fin partie | ☐ |
| 9 | Retrait vers MVola (manuel OK) | Processus documenté et testé | ☐ |
| 10 | Reconnexion après coupure réseau | Taux succès > 95% | ☐ |
| 11 | Anti-triche (server-authoritative) | Pas de manipulation client possible | ☐ |
| 12 | Application Android installable (APK) | Build signé, taille < 30 MB | ☐ |
| 13 | Performance sur réseau 2G/3G | Latence < 2s par action | ☐ |
| 14 | Pas de crash | 0 crash sur 100 parties consécutives | ☐ |

### 8.2 Conditions de lancement public

| # | Critère | Cible |
|:-:|---------|:-----:|
| 1 | Bêta fermée validée | 500 testeurs actifs pendant 30 jours |
| 2 | Feedback critique résolu | 0 bug bloquant, tous les Must-Have stables |
| 3 | Orange Money intégré | Dépôt et retrait fonctionnels |
| 4 | KYC automatisé | Validation < 5 min (au lieu de 24h manuel) |
| 5 | Support client opérationnel | Réponse < 1h ouvrée |
| 6 | Procédure AML documentée | Seuils, reporting, formation équipe |

---

## 9. Backlog V2/V3

### 9.1 V2 (Mois 4-6 après MVP)

| Priorité | Feature | Dépendance |
|:--------:|---------|:----------:|
| 1 | Ludo multijoueur (2-4 joueurs) avec argent réel | Règles métier Ludo à définir |
| 2 | Terrains virtuels (Bronze + Argent) | Système de commission propriétaire |
| 3 | Orange Money + Airtel Money (via PaidMada) | API providers |
| 4 | Programme parrainage "Refer & Earn" | Système de tracking |
| 5 | Détection de bots (ML basique) | Données de jeu MVP |
| 6 | Mode sombre (dark mode) | Design system |
| 7 | Classements joueurs (winrate, gains) | Métriques de jeu |
| 8 | Certificat RNG iTechLabs | Budget ~5 000 $ |

### 9.2 V3 (Mois 7-9 après MVP)

| Priorité | Feature | Dépendance |
|:--------:|---------|:----------:|
| 1 | Jeu de cartes traditionnel malgache (à définir) | Mental Poker Protocol |
| 2 | Tournois avec buy-in et prize pool | Système tournoi |
| 3 | Terrains Or + Tournoi | Infrastructure scaling |
| 4 | Items virtuels (dés, plateaux, avatars) | Store / inventaire |
| 5 | Messagerie texte pendant les parties | Modération |
| 6 | Application iOS | Apple Developer Account |
| 7 | Version Web jouable (React ou Flutter Web) | Codebase partagée |
| 8 | Notifications SMS (pour confirmation retrait) | API SMS |

### 9.3 V4+ (Mois 10+)

| Feature | Note |
|---------|:----:|
| Voice chat intégré | Inspiré Yalla Ludo |
| Mode free-to-play (sans argent) | Acquisition d'utilisateurs |
| Streaming de parties en direct | Social |
| Extension régionale (Comores, Réunion) | Nouveaux marchés |
| IA adversaire (mode hors ligne) | Machine learning |
| Système de parrainage avancé (multi-niveaux) | Affiliation |

---

## 10. Métriques Produit

### 10.1 KPIs principaux

| Métrique | Calcul | Cible MVP (Bêta) | Cible An 1 |
|:--------:|:------:|:-----------------:|:----------:|
| **Inscriptions** | Nombre de comptes créés | 500 | 25 000 |
| **KYC complétés** | % inscriptions avec KYC validé | 80% | 85% |
| **Utilisateurs actifs (MAU)** | Joueurs ayant joué ≥1 partie dans le mois | 400 | 10 000 |
| **DAU** | Joueurs/jour | 150 | 3 000 |
| **Parties/joueur/semaine** | Parties / joueurs actifs / semaines | 3 | 5 |
| **Mise moyenne/partie** | Montant misé / nombre de parties | 1 000 Ar | 2 000 Ar |
| **Rétention J+1** | % revenant le lendemain | 50% | 60% |
| **Rétention M+3** | % toujours actifs à 3 mois | 30% | 40% |
| **Délai dépôt** | Temps entre clic et solde crédité | < 2 min | < 1 min |
| **Délai retrait** | Temps entre demande et réception | < 24h | < 5 min |
| **Commission brute mensuelle** | (Volume total × 12%) - 3% frais MVola | 1 M Ar | 50 M Ar |
| **Taux de triche détecté** | Parties signalées / total | < 1% | < 0,5% |
| **Taux d'abandon** | Parties abandonnées / commencées | < 5% | < 3% |
| **Litiges** | Contestations / parties | < 1% | < 0,5% |
| **App Store rating** | Note moyenne | N/A (APK) | 4.0+ |
| **NPS** | Net Promoter Score | N/A | > 30 |

### 10.2 Métriques de qualité

| Métrique | Cible | Criticité |
|:--------:|:-----:|:---------:|
| Disponibilité plateforme (uptime) | > 99.5% | 🔴 |
| Temps de réponse API (p95) | < 500ms | 🔴 |
| Latence WebSocket (p95) | < 200ms | 🟡 |
| Taille APK | < 30 MB | 🟡 |
| Consommation data par partie | < 500 KB | 🟡 |
| Crash rate | < 0.1% des sessions | 🔴 |
| Temps de démarrage à froid | < 3s | 🟢 |

### 10.3 Métriques de confiance (critiques pour le marché)

| Métrique | Pourquoi | Cible |
|:--------:|:---------|:-----:|
| Délai de retrait moyen | #1 facteur de crédibilité | < 5 min (V2) |
| Taux de succès des dépôts | Confiance dans le système de paiement | > 95% |
| Réponse support client | Résolution rapide des litiges | < 1h |
| Transactions contestées | Litiges sur les gains | < 0.5% |
| Visibilité commission | Transparence = confiance | Toujours affichée |

---

## Annexes

### A. Glossaire

| Terme | Définition |
|-------|-----------|
| **Wallet** | Portefeuille virtuel contenant le solde du joueur |
| **Pool** | Total des mises d'une partie (mise × nombre de joueurs) |
| **Commission** | Prélevée par HiGame (12% du pool) |
| **Domino** | Faire domino = poser sa dernière tuile |
| **KYC** | Know Your Customer — vérification d'identité |
| **OTP** | One-Time Password — code à usage unique par SMS |
| **Server-authoritative** | Logique de jeu 100% côté serveur (anti-triche) |
| **Event sourcing** | Stockage de chaque action sous forme d'événement |
| **WebSocket** | Protocole de communication bidirectionnelle temps réel |

### B. Références

- Doc stratégique : `_bmad-output/planning-artifacts/strategique-higame.md`
- Étude de marché : `_bmad-output/planning-artifacts/research/market-jeux-traditionnels-malgaches-paris-argent-reel-research-2026-05-08.md`
- Brainstorming : `_bmad-output/brainstorming/bp-session-001.md`
- Contexte projet : `docs/project-context.md`

---

*Document généré par John — Product Manager (bmad-agent-pm)*
*Date : 08/05/2026*
*Sources : brainstorming BP, étude de marché, analyse stratégique, contexte projet HiGame*
