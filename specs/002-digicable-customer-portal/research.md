# Recherche et décisions techniques

## Flutter/Dart

- **Décision**: Flutter stable et Dart stable supportés par le projet.
- **Rationale**: rendu cohérent Android, composants réutilisables et tests widgets intégrés.
- **Alternatives**: React Native (écart avec la constitution), natif Kotlin (coût de duplication).

## Gestion d'état et navigation

- **Décision**: Riverpod + go_router.
- **Rationale**: dépendances explicites, testabilité des providers, guards et redirections centralisés.
- **Alternatives**: Bloc (plus verbeux), navigation impérative seule (guards moins fiables).

## API et modèles

- **Décision**: Dio, DTO JSON générés, repositories et `AppFailure`.
- **Rationale**: intercepteurs centralisés, timeouts, mapping uniforme et séparation backend/domaine.
- **Alternatives**: `http` seul (moins d'intercepteurs), modèles manuels (risque de dérive).

## Stockage et sécurité

- **Décision**: `flutter_secure_storage` pour les jetons; aucun mot de passe local.
- **Rationale**: utilisation du keystore Android et réduction de la surface de fuite.
- **Alternatives**: SharedPreferences pour les secrets (rejeté), base locale complète (inutile au MVP).

## Paiement et notifications

- **Décision**: le backend CIC orchestre le fournisseur de paiement; Firebase Cloud Messaging ou
  fournisseur validé par CIC pour le push, avec centre in-app alimenté par API.
- **Rationale**: aucun secret marchand ni logique de confirmation financière dans le client.
- **Alternatives**: intégration directe d'un SDK marchand (à valider uniquement si exigée par CIC).

## Hypothèses résolues

- L'API REST existe ou sera fournie avant l'intégration; les URLs et schémas exacts sont configurés
  par environnement.
- Les tarifs, moyens de paiement, règles d'éligibilité et statuts sont fournis par le backend.
- Le hors connexion est dégradé: consultation du dernier état non sensible autorisé, mutations
  interdites jusqu'à reconnexion.
