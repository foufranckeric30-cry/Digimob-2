# Feature Specification: Application mobile portail DigiCâbles

**Feature Branch**: `non-git-001-application-mobile-portail`

**Created**: 2026-09-22

**Status**: Draft

**Input**: User description: "Développer une application mobile à partir du portail DigiCâbles existant : https://portail.cicables.com:8090/index.php"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Accéder à son espace abonné (Priority: P1)

En tant qu’abonné DigiCâbles, je veux ouvrir l’application mobile, me connecter avec mes identifiants existants et accéder à mon espace personnel afin de consulter les informations importantes liées à mon compte sans passer par le portail web.

**Why this priority**: L’accès sécurisé à l’espace abonné est le prérequis de toutes les autres fonctionnalités et constitue la valeur minimale de l’application.

**Independent Test**: Peut être testé en utilisant un compte abonné valide, puis en vérifiant que l’utilisateur arrive sur un accueil personnalisé affichant son identité et l’état général de son compte.

**Acceptance Scenarios**:

1. **Given** un abonné avec des identifiants valides, **When** il saisit son login et son mot de passe puis confirme, **Then** il accède à son espace abonné mobile.
2. **Given** un abonné avec des identifiants invalides, **When** il tente de se connecter, **Then** l’application refuse l’accès et affiche un message clair sans révéler d’information sensible.
3. **Given** un abonné ayant oublié son mot de passe, **When** il choisit l’option de récupération ou d’inscription, **Then** il est guidé vers un parcours permettant de récupérer l’accès ou de demander la création d’un compte.

---

### User Story 2 - Consulter son abonnement et ses services (Priority: P2)

En tant qu’abonné connecté, je veux consulter les détails de mon abonnement, les services activés et leur statut afin de comprendre ma situation actuelle sans contacter le support.

**Why this priority**: La consultation autonome réduit les demandes simples au service client et améliore la transparence pour l’abonné.

**Independent Test**: Peut être testé avec un compte ayant un abonnement actif, suspendu ou expiré, puis en vérifiant que les informations affichées sont compréhensibles et cohérentes.

**Acceptance Scenarios**:

1. **Given** un abonné connecté avec un abonnement actif, **When** il ouvre la section abonnement, **Then** il voit le type d’offre, le statut, les dates utiles et les services associés.
2. **Given** un abonné connecté avec un abonnement expiré ou suspendu, **When** il consulte son abonnement, **Then** l’application affiche clairement la situation et l’action recommandée.

---

### User Story 3 - Suivre ses paiements et factures (Priority: P3)

En tant qu’abonné connecté, je veux consulter mes factures, mes paiements et les éventuels montants dus afin de suivre ma relation commerciale avec DigiCâbles.

**Why this priority**: Le suivi financier est une attente forte pour un portail abonné et limite les incompréhensions sur les échéances ou soldes.

**Independent Test**: Peut être testé avec un compte comportant plusieurs factures et paiements, puis en vérifiant que l’utilisateur comprend son solde et l’historique affiché.

**Acceptance Scenarios**:

1. **Given** un abonné connecté avec des factures disponibles, **When** il ouvre la section facturation, **Then** il voit la liste des factures avec date, montant et statut.
2. **Given** un abonné connecté avec un montant dû, **When** il consulte son solde, **Then** l’application met en évidence le montant et l’échéance correspondante.

---

### User Story 4 - Demander de l’aide ou signaler un problème (Priority: P4)

En tant qu’abonné connecté, je veux pouvoir contacter DigiCâbles ou signaler un problème depuis l’application afin d’obtenir de l’assistance rapidement.

**Why this priority**: L’assistance mobile améliore l’expérience client mais peut être livrée après les fonctions de consultation essentielles.

**Independent Test**: Peut être testé en soumettant une demande simple et en vérifiant que l’utilisateur reçoit une confirmation avec un résumé de sa demande.

**Acceptance Scenarios**:

1. **Given** un abonné connecté, **When** il décrit un problème et envoie une demande d’assistance, **Then** l’application confirme la réception de la demande.
2. **Given** un abonné connecté ayant déjà envoyé une demande, **When** il consulte ses demandes, **Then** il voit leur statut et les informations de suivi disponibles.

---

### Edge Cases

- Que se passe-t-il si l’utilisateur perd sa connexion Internet pendant la connexion ou l’envoi d’une demande ? L’application doit conserver un état sûr, informer l’utilisateur et lui permettre de réessayer.
- Que se passe-t-il si le compte est bloqué, suspendu ou non reconnu ? L’application doit expliquer la situation de manière non technique et proposer un contact ou une action de récupération.
- Que se passe-t-il si certaines données du portail sont temporairement indisponibles ? L’application doit afficher les sections disponibles et signaler clairement les informations non récupérées.
- Que se passe-t-il si l’utilisateur laisse l’application inactive ? L’application doit protéger l’espace abonné et demander une nouvelle authentification après une période d’inactivité raisonnable.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Le système MUST permettre aux abonnés DigiCâbles de se connecter avec leurs identifiants existants du portail abonné.
- **FR-002**: Le système MUST empêcher l’accès aux informations personnelles, d’abonnement, de facturation et d’assistance tant que l’utilisateur n’est pas authentifié.
- **FR-003**: Le système MUST afficher un accueil personnalisé après connexion avec un résumé du compte et des accès rapides aux sections principales.
- **FR-004**: Les utilisateurs MUST pouvoir lancer un parcours de récupération de mot de passe ou d’inscription depuis l’écran de connexion.
- **FR-005**: Les utilisateurs MUST pouvoir consulter les informations principales de leur profil abonné, notamment l’identité affichée, les coordonnées disponibles et le statut du compte.
- **FR-006**: Les utilisateurs MUST pouvoir consulter les détails de leur abonnement, y compris l’offre, le statut, les services associés et les dates importantes disponibles.
- **FR-007**: Les utilisateurs MUST pouvoir consulter leur historique de factures et de paiements lorsque ces données existent pour leur compte.
- **FR-008**: Le système MUST mettre en évidence tout solde dû, échéance importante ou action attendue de l’abonné.
- **FR-009**: Les utilisateurs MUST pouvoir créer une demande d’assistance ou signaler un incident en fournissant au minimum un motif, une description et des coordonnées de rappel si disponibles.
- **FR-010**: Les utilisateurs MUST recevoir une confirmation lisible après toute demande d’assistance envoyée avec succès.
- **FR-011**: Les utilisateurs MUST pouvoir se déconnecter clairement depuis l’application.
- **FR-012**: Le système MUST afficher des messages d’erreur compréhensibles en cas d’identifiants invalides, de connexion instable, de session expirée ou de données indisponibles.
- **FR-013**: Le système MUST protéger les données personnelles affichées sur mobile contre l’accès non autorisé, notamment en cas d’inactivité prolongée.
- **FR-014**: Le système MUST présenter les informations et actions principales en français, avec des libellés cohérents avec l’univers DigiCâbles.
- **FR-015**: Le système MUST permettre une navigation adaptée à un usage mobile, avec des actions principales accessibles en moins de trois interactions depuis l’accueil.

### Key Entities *(include if feature involves data)*

- **Abonné**: Représente un client DigiCâbles identifié ; attributs clés : identifiant de connexion, nom affiché, coordonnées, statut du compte.
- **Session utilisateur**: Représente l’accès temporaire et sécurisé d’un abonné connecté ; liée à un abonné et à une période d’activité.
- **Abonnement**: Représente l’offre ou le service souscrit ; attributs clés : type d’offre, statut, dates utiles, services inclus.
- **Facture**: Représente une demande de paiement ; attributs clés : période, montant, date, statut de paiement.
- **Paiement**: Représente un règlement effectué ou enregistré ; attributs clés : date, montant, statut, référence.
- **Demande d’assistance**: Représente un contact ou incident soumis par l’abonné ; attributs clés : motif, description, date de création, statut, réponse ou suivi.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 90 % des abonnés testeurs parviennent à se connecter et à atteindre l’accueil de leur espace abonné en moins de 60 secondes.
- **SC-002**: 85 % des abonnés testeurs trouvent le statut de leur abonnement en moins de 3 interactions depuis l’accueil.
- **SC-003**: 85 % des abonnés testeurs identifient correctement leur solde ou l’absence de montant dû après consultation de la section facturation.
- **SC-004**: 80 % des abonnés testeurs réussissent à envoyer une demande d’assistance complète en moins de 2 minutes.
- **SC-005**: Les erreurs de connexion ou de données indisponibles sont comprises par au moins 90 % des testeurs sans aide externe.
- **SC-006**: Le nombre de contacts support liés aux questions simples sur abonnement, solde ou récupération d’accès diminue d’au moins 25 % après adoption par les abonnés actifs.

## Assumptions

- Le portail fourni est le portail abonné DigiCâbles existant et l’application mobile doit reprendre ses parcours essentiels plutôt que remplacer les processus métier.
- La première version cible les abonnés/clients, pas les administrateurs internes ni les agents de support.
- Les identifiants existants du portail restent la référence pour l’accès abonné.
- Le parcours visible « Mot de passe oublié ou s’inscrire ? » fait partie du périmètre de démarrage ou redirige vers un parcours existant équivalent.
- Les données d’abonnement, de facturation et d’assistance existent déjà côté DigiCâbles ou seront rendues disponibles à l’application.
- L’application est destinée à un usage mobile moderne pour Android et iOS, sauf décision contraire ultérieure.
- Options retenues pour le MVP : application mobile abonné DigiCâbles, utilisateurs clients uniquement, Android et iOS, connexion obligatoire, interface en français, consultation abonnement/facturation et assistance, sans paiement mobile natif en première version.
