# Guide de validation

## Pré-requis

Installer Flutter stable, Android SDK, un émulateur ou appareil Android, puis configurer
`API_BASE_URL` et les variables d'environnement du backend de test.

## Commandes

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter test integration_test
flutter run --dart-define=API_BASE_URL=https://api.example.test/api/v1
```

## Scénarios attendus

1. Sans session, le splash redirige vers onboarding ou connexion.
2. Des identifiants valides ouvrent le tableau de bord; des identifiants invalides n'exposent aucune
   donnée privée.
3. La session expirée redirige vers la connexion et efface les secrets locaux après déconnexion.
4. Les abonnements, offres, paiements et notifications affichent loading, success, empty et error.
5. Un renouvellement ou paiement rejoué avec la même clé d'idempotence ne crée pas de doublon.
6. Hors connexion, les mutations sont bloquées, les données non sensibles disponibles sont signalées
   comme potentiellement obsolètes et la reconnexion est proposée.
7. Le build release Android réussit avec la signature et les permissions propres à l'environnement.
