# Contract: Mobile BFF API

Ce contrat décrit les interfaces attendues entre l’application mobile DigiCâbles et la couche Backend-for-Mobile. Les noms d’endpoints sont indicatifs pour cadrer les échanges ; ils pourront être adaptés pendant l’implémentation sans changer les besoins utilisateur.

## Conventions communes

- Toutes les réponses d’erreur retournent un code fonctionnel et un message utilisateur en français.
- Les données sensibles sont retournées uniquement avec une session active.
- Les dates sont normalisées dans un format non ambigu.
- Les montants incluent toujours une devise.

## POST /auth/login

**Purpose**: Authentifier un abonné avec ses identifiants existants.

**Request**:
```json
{
  "login": "string",
  "password": "string",
  "rememberMe": false
}
```

**Success 200**:
```json
{
  "session": {
    "expiresAt": "2026-09-22T10:00:00Z"
  },
  "subscriber": {
    "id": "string",
    "displayName": "string",
    "accountStatus": "active"
  }
}
```

**Errors**:
- `INVALID_CREDENTIALS`
- `ACCOUNT_BLOCKED`
- `PORTAL_UNAVAILABLE`
- `NETWORK_TIMEOUT`

## POST /auth/logout

**Purpose**: Terminer la session active.

**Success 204**: aucune donnée.

## GET /me

**Purpose**: Récupérer le profil abonné résumé.

**Success 200**:
```json
{
  "id": "string",
  "displayName": "string",
  "phone": "string",
  "email": "string",
  "accountStatus": "active"
}
```

## GET /subscription

**Purpose**: Afficher l’abonnement et les services.

**Success 200**:
```json
{
  "id": "string",
  "offerName": "string",
  "status": "active",
  "startDate": "2026-01-01",
  "endDate": "2026-12-31",
  "services": ["string"],
  "recommendedAction": "string"
}
```

## GET /billing/summary

**Purpose**: Afficher le solde et les alertes financières principales.

**Success 200**:
```json
{
  "balance": {
    "amount": 0,
    "currency": "XOF",
    "status": "none_due"
  },
  "nextDueAt": "2026-10-01",
  "message": "Aucun montant dû"
}
```

## GET /billing/invoices

**Purpose**: Lister les factures.

**Success 200**:
```json
{
  "items": [
    {
      "id": "string",
      "periodLabel": "Septembre 2026",
      "issuedAt": "2026-09-01",
      "dueAt": "2026-09-30",
      "amount": 10000,
      "currency": "XOF",
      "status": "paid"
    }
  ]
}
```

## GET /billing/payments

**Purpose**: Lister les paiements.

**Success 200**:
```json
{
  "items": [
    {
      "id": "string",
      "paidAt": "2026-09-15",
      "amount": 10000,
      "currency": "XOF",
      "status": "confirmed",
      "reference": "string"
    }
  ]
}
```

## POST /support/requests

**Purpose**: Créer une demande d’assistance.

**Request**:
```json
{
  "subject": "string",
  "description": "string",
  "contactPreference": "string"
}
```

**Success 201**:
```json
{
  "id": "string",
  "status": "submitted",
  "createdAt": "2026-09-22T10:00:00Z",
  "confirmationMessage": "Votre demande a bien été envoyée."
}
```

## GET /support/requests

**Purpose**: Lister les demandes d’assistance de l’abonné.

**Success 200**:
```json
{
  "items": [
    {
      "id": "string",
      "subject": "string",
      "createdAt": "2026-09-22T10:00:00Z",
      "status": "submitted",
      "lastUpdateAt": "2026-09-22T10:00:00Z"
    }
  ]
}
```
