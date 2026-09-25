# Feature Specification: Espace client DigiCâble — abonnements et services numériques

**Feature Branch**: `002-digicable-customer-portal`

**Created**: 2026-09-23

**Status**: Draft

**Input**: User description: "Créer une application mobile DigiCâble permettant aux clients de consulter leurs informations, leurs abonnements et leurs services de télévision numérique, de consulter leur solde ou échéance, de renouveler leur abonnement et d'accéder aux informations de leur compte.

L'application doit proposer une authentification, un tableau de bord, la gestion du profil, la consultation des offres et abonnements, l'historique des opérations et les notifications."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Accéder à son espace client (Priority: P1)

En tant que client CIC, je veux m’authentifier dans DigiCâble et accéder à un tableau de bord personnalisé afin de connaître rapidement l’état de mon compte, de mon abonnement et de mes services.

**Why this priority**: L’accès sécurisé à l’espace client conditionne toutes les autres fonctions et constitue la valeur minimale de l’application.

**Independent Test**: Avec un compte client valide, vérifier que l’utilisateur peut se connecter et retrouver sur le tableau de bord son identité, l’état de son compte, son abonnement et les accès principaux. Avec des identifiants invalides, vérifier que l’accès est refusé et qu’aucune donnée personnelle n’est affichée.

**Acceptance Scenarios**:

1. **Given** un client avec des identifiants valides, **When** il saisit ses identifiants et confirme, **Then** l’application ouvre son tableau de bord personnalisé.
2. **Given** des identifiants invalides, **When** le client tente de se connecter, **Then** l’application refuse l’accès et affiche un message français clair sans révéler d’information sensible.
3. **Given** une session expirée ou révoquée, **When** le client tente d’ouvrir une information protégée, **Then** l’application demande une nouvelle authentification.
4. **Given** un compte suspendu, fermé ou non reconnu, **When** le client se connecte, **Then** l’application explique la situation et indique l’action de récupération ou de contact disponible.

---

### User Story 2 - Consulter et gérer son profil (Priority: P2)

En tant que client connecté, je veux consulter les informations de mon compte et mettre à jour les coordonnées autorisées afin de garder mes informations personnelles correctes.

**Why this priority**: La maîtrise des informations de contact améliore la pertinence des services et réduit les erreurs de livraison ou de notification, sans nécessiter les fonctions de gestion de l’abonnement.

**Independent Test**: Avec un compte client valide, vérifier que le client voit son profil, modifie une coordonnée autorisée et reçoit une confirmation. Vérifier ensuite que la modification est refusée avec une explication lorsqu’elle n’est pas autorisée ou que le service est indisponible.

**Acceptance Scenarios**:

1. **Given** un client connecté, **When** il ouvre son profil, **Then** il voit son identité affichée, son statut de compte et les coordonnées disponibles.
2. **Given** une coordonnée modifiable, **When** le client la met à jour et confirme, **Then** l’application enregistre la modification et affiche une confirmation lisible.
3. **Given** une information d’identité ou une coordonnée non modifiable dans l’application, **When** le client tente de la changer, **Then** l’application explique la restriction et indique le canal CIC approprié.
4. **Given** une indisponibilité du service de profil, **When** le client ouvre ou modifie son profil, **Then** l’application conserve les données déjà affichées en sécurité et propose de réessayer.

---

### User Story 3 - Consulter ses abonnements, services et situation financière (Priority: P3)

En tant que client connecté, je veux consulter mon abonnement, mes services de télévision numérique, les offres disponibles, mon solde et mon échéance afin de comprendre ce qui est actif et ce qui nécessite mon attention.

**Why this priority**: La consultation autonome de sa situation est la valeur principale de l’espace client et permet de réduire les demandes d’information au support.

**Independent Test**: Avec un compte disposant d’un abonnement actif, d’un solde nul, d’un solde dû et d’une échéance, vérifier que le client identifie correctement chaque situation et accède aux informations pertinentes depuis le tableau de bord.

**Acceptance Scenarios**:

1. **Given** un client connecté, **When** il ouvre la section Abonnement, **Then** il voit l’offre en cours, son statut, ses dates utiles et les services associés.
2. **Given** un client connecté, **When** il ouvre la section Services, **Then** il voit chaque service de télévision, son statut et les informations de gestion disponibles.
3. **Given** un client connecté, **When** il ouvre la section Offres, **Then** il voit les offres accessibles à son compte avec leurs caractéristiques et conditions.
4. **Given** un client avec un solde dû, une échéance ou aucun montant dû, **When** il consulte son tableau de bord, **Then** l’application affiche la situation exacte, l’échéance concernée et l’action recommandée lorsqu’elle existe.
5. **Given** des informations partielles ou temporairement indisponibles, **When** le client consulte une section, **Then** l’application signale clairement les données non récupérées sans inventer de valeur.

---

### User Story 4 - Renouveler son abonnement (Priority: P4)

En tant que client éligible, je veux renouveler mon abonnement depuis mon espace client afin de maintenir mes services de télévision sans passer par un autre canal.

**Why this priority**: Le renouvellement protège la continuité des services, mais il doit être livré après la consultation de l’abonnement afin que le client comprenne l’offre, le statut et les conséquences.

**Independent Test**: Avec un abonnement renouvelable, vérifier que le client peut consulter les informations du renouvellement, confirmer la demande et voir le nouvel état de l’abonnement après traitement. Vérifier également qu’un renouvellement impossible ou en double ne modifie pas le compte.

**Acceptance Scenarios**:

1. **Given** un client connecté dont l’abonnement peut être renouvelé, **When** il choisit Renouveler, **Then** l’application affiche l’offre, la période concernée, le montant ou solde associé et les conditions disponibles.
2. **Given** un client qui confirme un renouvellement éligible, **When** le traitement aboutit, **Then** l’application confirme le résultat, met à jour la situation de l’abonnement et ajoute l’opération à l’historique.
3. **Given** un renouvellement refusé, impossible ou interrompu, **When** le client revient sur la page, **Then** l’application conserve un état cohérent, explique l’issue et propose une action appropriée.
4. **Given** une action de renouvellement lancée deux fois, **When** le second essai arrive avant la fin du premier, **Then** une seule opération de renouvellement est créée.

---

### User Story 5 - Consulter son historique et ses notifications (Priority: P5)

En tant que client connecté, je veux consulter mes opérations passées et les notifications relatives à mon compte afin de suivre l’activité de mon abonnement et d’agir au bon moment.

**Why this priority**: L’historique et les notifications rendent les actions du compte traçables et complètent l’espace client après les parcours de consultation et de renouvellement.

**Independent Test**: Avec un compte comportant des opérations et des notifications, vérifier que le client peut consulter les éléments disponibles, comprendre leur date, leur type et leur état, et accéder à l’action associée lorsqu’elle existe.

**Acceptance Scenarios**:

1. **Given** un client connecté disposant d’un historique, **When** il ouvre Historique, **Then** il voit les opérations avec leur date, leur type, leur statut et les informations financières disponibles.
2. **Given** une notification non lue, **When** le client ouvre la liste des notifications, **Then** il voit son message, sa date et son état de lecture.
3. **Given** une notification liée à une échéance, à un renouvellement ou à un changement de service, **When** le client choisit l’action associée, **Then** il arrive à la section concernée avec les informations à jour.
4. **Given** un historique ou une liste de notifications vide, **When** le client ouvre la section, **Then** l’application affiche un état vide explicite et rassurant.

### Edge Cases

- Que se passe-t-il si la connexion internet est interrompue pendant la connexion, la consultation d’un solde ou le renouvellement ? L’application doit conserver un état sûr, informer le client et permettre de réessayer sans créer d’opération en double.
- Que se passe-t-il si la session expire pendant une consultation ou une action sensible ? L’application doit masquer les données protégées, demander une nouvelle authentification et conserver uniquement les informations nécessaires à la reprise.
- Que se passe-t-il si le compte est suspendu, fermé, expiré ou non reconnu ? L’application doit présenter la situation de façon non technique et indiquer l’action de contact ou de récupération prévue par CIC.
- Que se passe-t-il si le montant, l’échéance, le statut d’un service ou une opération n’est pas disponible ? L’application doit distinguer la donnée absente de la donnée confirmée et ne pas inventer de valeur.
- Que se passe-t-il si le client ne possède aucun abonnement, aucune offre accessible ou aucun historique ? L’application doit afficher un état vide et proposer la prochaine action pertinente.
- Que se passe-t-il si une notification contient un lien vers une information qui n’est plus disponible ? L’application doit signaler que le contenu n’est plus accessible sans empêcher la navigation vers les autres sections.
- Que se passe-t-il si la langue, le fuseau horaire ou le format d’un montant diffèrent des informations reçues ? L’application doit préserver le sens métier et signaler clairement toute information qui ne peut pas être affichée de façon fiable.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Le système MUST permettre à un client CIC de s’authentifier avec son compte existant et d’accéder à son espace personnel.
- **FR-002**: Le système MUST empêcher l’accès aux informations de profil, d’abonnement, de service, de solde, d’historique et de notification tant qu’une session valide n’est pas établie.
- **FR-003**: Le système MUST gérer la déconnexion, l’expiration de session et la révocation de l’accès avec un retour sûr vers l’authentification.
- **FR-004**: Le système MUST afficher un tableau de bord personnalisé contenant l’état du compte, un résumé de l’abonnement, la situation de solde ou d’échéance et des accès rapides.
- **FR-005**: Le système MUST permettre au client de consulter son identité affichée, son statut de compte et les coordonnées disponibles.
- **FR-006**: Le système MUST permettre au client de modifier uniquement les coordonnées autorisées et MUST confirmer le résultat de chaque modification.
- **FR-007**: Le système MUST afficher l’offre, le statut, les dates utiles et les services associés à l’abonnement courant.
- **FR-008**: Le système MUST permettre de consulter les services de télévision numérique associés au compte et leur statut.
- **FR-009**: Le système MUST présenter les offres accessibles au client avec leurs caractéristiques, conditions et services associés.
- **FR-010**: Le système MUST afficher le solde, l’absence de montant dû et/ou l’échéance concernée lorsque ces informations sont disponibles.
- **FR-011**: Le système MUST permettre à un client éligible de lancer, confirmer et suivre un renouvellement d’abonnement selon le parcours de paiement validé par CIC.
- **FR-012**: Le système MUST empêcher la création d’opérations de renouvellement en double et MUST conserver un état cohérent après un échec ou une interruption.
- **FR-013**: Le système MUST afficher l’historique des opérations du client avec leur date, leur type, leur statut et les informations financières disponibles.
- **FR-014**: Le système MUST afficher les notifications du client avec leur date, leur contenu, leur état de lecture et l’action associée lorsqu’elle est disponible.
- **FR-015**: Le système MUST distinguer les états de chargement, de succès, de données absentes, d’erreur et d’indisponibilité réseau pour chaque parcours principal.
- **FR-016**: Le système MUST présenter des messages en français, compréhensibles et non techniques pour les clients.
- **FR-017**: Le système MUST protéger les informations du compte pendant l’utilisation, l’inactivité et la déconnexion.
- **FR-018**: Le système MUST permettre au client d’accéder aux parcours (compte, abonnement, services, historique et notifications) depuis le tableau de bord ou la navigation principale.
- **FR-019**: Le système MUST permettre de retrouver une opération ou une notification à partir de sa date, de son type et de son état lorsque ces attributs sont disponibles.
- **FR-020**: Le système MUST ne pas exposer de secret, de mot de passe, de jeton ou de donnée personnelle dans un message public, un journal ou une erreur destinée au client.

### Key Entities *(include if feature involves data)*

- **Client**: Représente un client CIC identifié ; attributs clés : identité affichée, référence de compte, statut et coordonnées autorisées.
- **Session client**: Représente un accès temporaire et protégé ; liée à un client, avec une date d’activité et un état actif, expiré ou révoqué.
- **Profil**: Représente les informations de compte visibles et modifiables par le client ; lié à un client et délimité par les autorisations CIC.
- **Abonnement**: Représente l’offre souscrite ; attributs clés : offre, statut, dates utiles et services associés.
- **Offre**: Représente une proposition commerciale accessible au client ; attributs clés : caractéristiques, conditions, prix ou modalité de renouvellement et services associés.
- **Service numérique**: Représente un service de télévision numérique associé à un abonnement ; attributs clés : nom, statut et informations de gestion disponibles.
- **Situation financière**: Représente le solde, le montant dû et l’échéance ; liée au client et à la période concernée.
- **Opération**: Représente un renouvellement ou une autre opération de compte ; attributs clés : date, type, statut et informations financières disponibles.
- **Notification**: Représente un message lié au compte ; attributs clés : date, contenu, état de lecture et action associée.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 90 % des clients testeurs se connectent et atteignent leur tableau de bord en moins de 60 secondes.
- **SC-002**: 90 % des clients testeurs trouvent le statut de leur abonnement et leurs services actifs en moins de trois interactions depuis le tableau de bord.
- **SC-003**: 85 % des clients testeurs identifient correctement le solde, l’absence de montant dû ou l’échéance après consultation de leur situation financière.
- **SC-004**: 80 % des clients testeurs éligibles terminent un renouvellement en moins de trois minutes, avec un résultat compréhensible.
- **SC-005**: 90 % des clients testeurs comprennent sans aide externe les messages d’authentification, d’erreur, d’indisponibilité ou de session expirée.
- **SC-006**: 85 % des clients testeurs trouvent dans l’historique l’opération qu’ils recherchent en moins de deux minutes lorsqu’une opération correspondante existe.
- **SC-007**: 80 % des clients testeurs comprennent le contenu et l’action associée d’une notification pertinente en moins d’une minute.
- **SC-008**: Le nombre de demandes au support concernant le compte, l’abonnement, le solde et le renouvellement diminue d’au moins 25 % après adoption par les clients actifs.
- **SC-009**: Les parcours prioritaires sont utilisables par des clients utilisant des technologies d’assistance, avec un taux de réussite d’au moins 90 % lors des tests d’accessibilité.

## Assumptions

- Les clients disposent d’un compte CIC existant et les services CIC fournissent les données de profil, d’abonnement, de solde, d’historique, d’offres et de notifications.
- Le renouvellement s’appuie sur le parcours de paiement ou d’autorisation déjà validé par CIC ; DigiCâble ne crée pas un nouveau mécanisme de paiement dans cette première version.
- Les champs de profil modifiables seront définis par CIC ; les changements d’identité ou les données légalement sensibles restent orientés vers les canaux CIC.
- Les notifications sont disponibles dans l’application ; les notifications push, les notifications système et les autres canaux restent différés jusqu’à ce que leurs conditions de disponibilité et de consentement soient définies.
- Les formats monétaires, les règles d’échéance et les libellés des offres sont fournis par CIC et restent la source de vérité.
- La première version cible les clients Android ; une autre plateforme nécessite une décision de gouvernance distincte.
- Les données peuvent être partielles ou temporairement indisponibles ; l’application doit distinguer ces situations d’une valeur métier absente.
- Les parcours de paiement, de renouvellement et de récupération de compte ne sont pas remplacés par des processus mobiles non validés par CIC.
