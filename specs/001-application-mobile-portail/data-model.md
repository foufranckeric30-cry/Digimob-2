# Data Model: Application mobile portail DigiCâbles

## Abonné

**Description**: Client DigiCâbles identifié pouvant accéder à son espace mobile.

**Fields**:
- `id`: identifiant unique abonné côté DigiCâbles
- `login`: identifiant de connexion affichable partiellement si nécessaire
- `displayName`: nom ou libellé affiché dans l’application
- `phone`: numéro de contact, optionnel
- `email`: adresse de contact, optionnelle
- `accountStatus`: `active`, `suspended`, `blocked`, `unknown`

**Relationships**:
- Possède zéro ou plusieurs abonnements
- Possède zéro ou plusieurs factures et paiements
- Possède zéro ou plusieurs demandes d’assistance

**Validation Rules**:
- Les données personnelles ne sont visibles qu’après authentification.
- Le statut bloqué ou suspendu déclenche un message d’action recommandée.

## Session utilisateur

**Description**: Accès temporaire et sécurisé d’un abonné connecté.

**Fields**:
- `sessionId`: référence de session non affichée
- `subscriberId`: abonné lié
- `createdAt`: date de création
- `lastActivityAt`: dernière activité connue
- `expiresAt`: expiration prévue
- `state`: `active`, `expired`, `revoked`

**State Transitions**:
- `active` → `expired` après inactivité ou expiration
- `active` → `revoked` après déconnexion
- `expired`/`revoked` → nouvelle session après reconnexion réussie

**Validation Rules**:
- Toute action sensible exige une session active.
- Une session inactive doit conduire à une nouvelle authentification.

## Abonnement

**Description**: Offre ou service souscrit par l’abonné.

**Fields**:
- `id`: identifiant abonnement
- `offerName`: nom de l’offre
- `status`: `active`, `expired`, `suspended`, `pending`, `unknown`
- `startDate`: date de début, optionnelle
- `endDate`: date de fin ou échéance, optionnelle
- `services`: liste de services inclus ou activés

**Relationships**:
- Appartient à un abonné

**Validation Rules**:
- Le statut doit être affiché avec un libellé français compréhensible.
- Une échéance proche ou un statut non actif doit afficher une action recommandée si disponible.

## Facture

**Description**: Document ou ligne de facturation liée à l’abonné.

**Fields**:
- `id`: identifiant facture
- `periodLabel`: période concernée
- `issuedAt`: date d’émission, optionnelle
- `dueAt`: échéance, optionnelle
- `amount`: montant
- `currency`: devise
- `status`: `paid`, `due`, `overdue`, `cancelled`, `unknown`

**Relationships**:
- Appartient à un abonné
- Peut être liée à zéro ou plusieurs paiements

**Validation Rules**:
- Le montant et le statut sont obligatoires pour l’affichage principal.
- Les factures en retard ou dues doivent être mises en évidence.

## Paiement

**Description**: Règlement effectué ou enregistré pour un abonné.

**Fields**:
- `id`: identifiant paiement
- `paidAt`: date du paiement
- `amount`: montant payé
- `currency`: devise
- `status`: `confirmed`, `pending`, `failed`, `unknown`
- `reference`: référence affichable, optionnelle

**Relationships**:
- Appartient à un abonné
- Peut être lié à une facture

**Validation Rules**:
- Les paiements échoués ou en attente doivent être distingués des paiements confirmés.

## Demande d’assistance

**Description**: Contact ou incident soumis par l’abonné.

**Fields**:
- `id`: identifiant de demande
- `subject`: motif choisi ou saisi
- `description`: description fournie par l’utilisateur
- `contactPreference`: moyen de rappel, optionnel
- `createdAt`: date de création
- `status`: `submitted`, `in_progress`, `resolved`, `closed`, `unknown`
- `lastUpdateAt`: date de dernière mise à jour, optionnelle

**Relationships**:
- Appartient à un abonné

**Validation Rules**:
- Le motif et la description sont obligatoires pour soumettre une demande.
- Une confirmation est affichée après création réussie.
- Le statut doit être compréhensible sans vocabulaire interne.
