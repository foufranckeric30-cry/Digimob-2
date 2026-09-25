# Contrat API mobile

Base URL versionnée: `/api/v1`.

| Méthode | Route | Authentification | Usage |
|---|---|---|---|
| POST | `/auth/login` | non | créer une session |
| POST | `/auth/refresh` | refresh token | renouveler une session |
| POST | `/auth/logout` | bearer | révoquer la session |
| POST | `/auth/forgot-password` | non | démarrer récupération |
| GET | `/me` | bearer | profil |
| PATCH | `/me` | bearer | coordonnées autorisées |
| GET | `/dashboard` | bearer | résumé |
| GET | `/subscriptions` | bearer | abonnements et services |
| GET | `/offers` | bearer | offres éligibles |
| POST | `/renewals` | bearer + idempotency key | créer renouvellement |
| POST | `/payments` | bearer + idempotency key | initier paiement |
| GET | `/payments` | bearer | paiements |
| GET | `/transactions` | bearer | historique paginé |
| GET | `/notifications` | bearer | notifications paginées |
| PATCH | `/notifications/{id}` | bearer | marquer lu |
| POST | `/support/tickets` | bearer | créer demande |
| GET | `/support/tickets` | bearer | suivre demandes |

Les réponses d'erreur utilisent `{ "code": "...", "message": "...", "requestId": "..." }`. Les codes
incluent `UNAUTHORIZED`, `FORBIDDEN`, `VALIDATION_ERROR`, `NOT_FOUND`, `CONFLICT`,
`PAYMENT_REQUIRED`, `RATE_LIMITED`, `UNAVAILABLE` et `INTERNAL_ERROR`. Le client ne journalise pas
les tokens, mots de passe, numéros de paiement ni données personnelles complètes.
