# Plan technique — DigiCâble Mobile

**Branche**: `002-digicable-customer-portal`  
**Date**: 2026-09-24  
**Spécification**: [spec.md](./spec.md)

## Résumé

Application Android Flutter/Dart organisée par fonctionnalités, consommant une API REST JSON
sécurisée. Le backend reste la source de vérité pour les comptes, abonnements, offres, paiements,
notifications et demandes de support. L'application sépare présentation, logique métier et données,
avec des états explicites loading/success/empty/error/offline.

## Contexte technique

- **Langage**: Dart stable supporté par Flutter stable.
- **Plateforme**: Android, smartphones entrée, milieu et haut de gamme.
- **Architecture**: feature-first + couches `presentation`, `domain`, `data`.
- **État**: Riverpod avec providers scoped par fonctionnalité.
- **Navigation**: `go_router`, routes publiques et protégées, redirection selon session.
- **Réseau**: `dio`, intercepteurs d'authentification, timeout, mapping d'erreurs et logs sans données sensibles.
- **Sérialisation**: JSON avec modèles immuables et génération de code (`json_serializable`, `build_runner`).
- **Stockage local**: `flutter_secure_storage` pour jetons et préférences minimales; cache mémoire/persistant
  limité aux données non sensibles.
- **Paiement**: orchestration via API CIC et fournisseur configuré côté backend; aucun secret marchand
  dans l'application.
- **Notifications**: service push Android avec identifiant d'appareil révocable et notifications in-app.
- **Tests**: unitaires, widgets, intégration, contrats API et parcours Android critiques.

## Architecture et structure

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── router.dart
│   ├── providers.dart
│   └── theme/
├── core/
│   ├── config/
│   ├── error/
│   ├── network/
│   ├── security/
│   ├── storage/
│   └── widgets/
└── features/
    ├── auth/
    ├── dashboard/
    ├── profile/
    ├── subscriptions/
    ├── offers/
    ├── renewal/
    ├── payments/
    ├── history/
    ├── notifications/
    ├── support/
    └── settings/
test/
integration_test/
android/
```

Chaque fonctionnalité contient `data/` (DTO, datasource, repository), `domain/` (entités, contrats,
use cases) et `presentation/` (providers, écrans, widgets).

## Décisions par fonctionnalité

| Fonctionnalité | Écrans principaux | Domaine/services |
|---|---|---|
| Authentification | splash, onboarding, connexion, inscription, récupération | `AuthSession`, `AuthRepository`, `SessionGuard` |
| Tableau de bord | accueil, résumé compte | `DashboardSummary`, `GetDashboardSummary` |
| Profil | consultation, édition autorisée | `CustomerProfile`, `UpdateProfile` |
| Abonnements | liste/détail, services | `Subscription`, `TvService`, `GetSubscriptions` |
| Offres | catalogue, détail | `Offer`, `Bundle`, `GetOffers` |
| Renouvellement | simulation, confirmation, résultat | `RenewalOrder`, `CreateRenewal` |
| Paiement | choix moyen, redirection/retour, résultat | `Payment`, `PaymentRepository` |
| Historique | paiements/opérations filtrables | `Transaction`, `GetHistory` |
| Notifications | centre, détail, préférences | `AppNotification`, `NotificationRepository` |
| Support | FAQ, formulaire, demandes | `SupportTicket`, `CreateSupportTicket` |
| Paramètres | préférences, sécurité, déconnexion | `AppSettings`, `Logout` |

## Gestion des états et erreurs

Les controllers Riverpod exposent `AsyncValue<T>` et distinguent chargement initial, rafraîchissement,
données vides, erreur récupérable, session expirée et hors connexion. Les erreurs REST sont converties
en `AppFailure` typées; les messages affichés sont français et ne contiennent aucun détail interne.
Les mutations utilisent une clé d'idempotence fournie par le backend pour éviter les doubles
renouvellements ou paiements.

## Sécurité, cache et performance

TLS est obligatoire. Les jetons sont stockés dans le keystore Android via `flutter_secure_storage`,
jamais dans les logs. La déconnexion révoque la session côté serveur et efface les secrets locaux.
Le cache persistant est interdit pour les paiements et données personnelles sensibles; les données
affichées portent un horodatage et peuvent être invalidées par pull-to-refresh ou expiration.
Les listes sont paginées, les images optimisées et les providers limitent les reconstructions.

## Configuration Android

Configurer l'identifiant d'application, min/target SDK supportés, permissions réseau et notifications,
signature par environnement, obfuscation de release, sauvegarde excluant les secrets et variables
`API_BASE_URL` par flavor (`dev`, `staging`, `prod`). Les secrets de production restent hors dépôt.

## Constitution Check

- **Architecture**: PASS — séparation par couches et fonctionnalités.
- **Sécurité**: PASS — stockage sécurisé, session contrôlée, moindre privilège.
- **API**: PASS — client centralisé, contrats JSON et états d'erreur explicites.
- **UX/accessibilité**: PASS — composants réutilisables, français, états vides/chargement/erreur.
- **Tests/qualité**: PASS — couverture des règles métier, widgets, contrats et parcours Android.
- **Performance**: PASS — cache contrôlé, pagination, limitation des reconstructions.

## Complexité justifiée

L'ajout de `core`, de repositories et de providers est nécessaire pour éviter de placer la logique
métier dans les widgets et pour permettre l'évolution indépendante des modules CIC. Aucun backend n'est
créé dans ce plan; l'application dépend d'un contrat REST fourni et versionné par CIC.
