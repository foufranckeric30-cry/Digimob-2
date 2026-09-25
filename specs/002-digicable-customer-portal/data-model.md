# Modèle de données

## Entités

- **Customer**: `id`, `displayName`, `phone`, `email`, `accountStatus`, `updatedAt`.
- **AuthSession**: `accessToken`, `refreshToken` éventuel, `expiresAt`, `status`.
- **Subscription**: `id`, `offerId`, `offerName`, `status`, `startAt`, `endAt`, `services`, `renewable`.
- **TvService**: `id`, `name`, `status`, `activatedAt`, `expiresAt`.
- **Offer**: `id`, `name`, `description`, `price`, `currency`, `period`, `channels`, `eligibility`.
- **RenewalOrder**: `id`, `subscriptionId`, `amount`, `currency`, `period`, `status`, `idempotencyKey`.
- **Payment**: `id`, `renewalId`, `amount`, `currency`, `method`, `status`, `createdAt`, `receiptUrl`.
- **Transaction**: `id`, `type`, `amount`, `status`, `createdAt`, `reference`.
- **AppNotification**: `id`, `title`, `body`, `type`, `readAt`, `createdAt`, `action`.
- **SupportTicket**: `id`, `subject`, `description`, `status`, `createdAt`, `updatedAt`.

## Relations et règles

`Customer` possède plusieurs `Subscription`, `Payment`, `Transaction`, `AppNotification` et
`SupportTicket`. Une `Subscription` référence une `Offer` et plusieurs `TvService`. Un
`RenewalOrder` possède zéro ou plusieurs tentatives de `Payment`.

Les montants sont décimaux et affichés avec la devise renvoyée par l'API. Les dates sont ISO-8601.
Les identifiants et statuts inconnus sont conservés comme valeurs non bloquantes et affichés avec un
libellé de repli. Une mutation de renouvellement ou de paiement exige une `idempotencyKey` unique.
Une session expirée interdit toute donnée privée et déclenche une réauthentification.
