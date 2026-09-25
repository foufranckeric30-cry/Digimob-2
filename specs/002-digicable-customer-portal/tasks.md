# Tâches d'implémentation — DigiCâble Mobile

**Références**: [plan.md](./plan.md), [spec.md](./spec.md), [data-model.md](./data-model.md),
[contracts/mobile-api.md](./contracts/mobile-api.md), [quickstart.md](./quickstart.md)

Chaque tâche précise son objectif, ses fichiers, sa dépendance, son résultat et sa validation.

## Dépendances et stratégie

Ordre principal: Phase 1 → Phase 2 → Phase 3 → Phase 4 → US1 → US2 → US3 → US4 → US5 → Phases 16–19.
US2 dépend de l'authentification US1; US3 dépend de US1 et réutilise ses contrats; US4 dépend de US3;
US5 dépend de US1 et des événements de paiement/renouvellement. Les tâches marquées `[P]` peuvent être
réalisées en parallèle après leurs dépendances.

MVP recommandé: Phases 1–6, couvrant configuration, architecture, design, navigation, authentification
et tableau de bord. Les autres fonctionnalités sont livrées progressivement.

## Phase 1 — Configuration Flutter

- [ ] T001 Initialiser le projet Flutter Android dans `pubspec.yaml`, `lib/main.dart` et `android/`; objectif: build minimal; dépendance: aucune; résultat: application démarre; validation: `flutter run` réussit sur émulateur.
- [ ] T002 [P] Configurer les dépendances Riverpod, go_router, Dio, flutter_secure_storage, json_serializable et Firebase Messaging dans `pubspec.yaml`; objectif: socle technique; dépendance: T001; résultat: dépendances résolues; validation: `flutter pub get` réussit.
- [ ] T003 [P] Créer les flavors dev/staging/prod et variables `API_BASE_URL` dans `lib/core/config/app_config.dart`, `android/app/build.gradle`; objectif: configuration par environnement; dépendance: T001; résultat: URL sélectionnable; validation: chaque flavor démarre avec sa configuration.
- [ ] T004 [P] Ajouter analyse, formatage et génération de code dans `analysis_options.yaml`, `dart_test.yaml` et `build.yaml`; objectif: qualité reproductible; dépendance: T002; résultat: contrôles automatisés; validation: `dart format --set-exit-if-changed` et `flutter analyze` passent.

## Phase 2 — Architecture

- [X] T005 Créer l'arborescence `lib/app`, `lib/core` et `lib/features/*/{data,domain,presentation}`; objectif: séparation par couches; dépendance: T001; résultat: structure feature-first; validation: aucune logique métier dans `lib/app`.
- [X] T006 [P] Implémenter `lib/core/error/app_failure.dart` et le mapping des codes API; objectif: erreurs typées; dépendance: T005; résultat: `AppFailure` couvre `UNAUTHORIZED`, `VALIDATION_ERROR`, `CONFLICT`, `UNAVAILABLE`; validation: tests unitaires des mappings.
- [ ] T007 [P] Implémenter `lib/core/network/api_client.dart` et `lib/core/network/interceptors.dart`; objectif: centraliser Dio, timeout, bearer et requestId; dépendance: T003,T006; résultat: client REST JSON unique; validation: timeout et erreurs sont convertis en `AppFailure`.
- [ ] T008 [P] Implémenter `lib/core/storage/secure_storage.dart` et `lib/core/security/session_manager.dart`; objectif: stocker uniquement les jetons; dépendance: T005; résultat: lecture/écriture/effacement sécurisé; validation: aucun mot de passe n'est persisté.

## Phase 3 — Thème et design system

- [X] T009 Créer `lib/app/theme/app_theme.dart`, `lib/app/theme/app_colors.dart` et `lib/app/theme/app_typography.dart`; objectif: identité visuelle CIC; dépendance: T005; résultat: thème clair cohérent; validation: contraste et tailles de texte validés sur deux écrans.
- [ ] T010 [P] Créer les composants réutilisables `lib/core/widgets/app_button.dart`, `app_text_field.dart`, `loading_view.dart`, `empty_view.dart`, `error_view.dart`; objectif: états et actions homogènes; dépendance: T009; résultat: composants accessibles; validation: tests widgets des états loading/empty/error.
- [ ] T011 [P] Ajouter les messages français dans `lib/core/config/fr_messages.dart`; objectif: libellés centralisés; dépendance: T005; résultat: aucun message réseau codé dans les écrans; validation: recherche statique des chaînes interdites.

## Phase 4 — Navigation

- [X] T012 Créer `lib/app/router.dart` avec routes splash, onboarding, login, dashboard et routes privées; objectif: navigation mobile; dépendance: T008,T009; résultat: routes déclaratives; validation: une session absente ne peut pas ouvrir une route privée.
- [ ] T013 [P] Créer `lib/app/app.dart` et `lib/app/providers.dart`; objectif: injection globale; dépendance: T007,T012; résultat: `ProviderScope` et router actifs; validation: démarrage sans exception.
- [ ] T014 [P] Ajouter `lib/features/auth/presentation/splash_screen.dart` et `onboarding_screen.dart`; objectif: premier lancement; dépendance: T010,T012; résultat: redirection déterministe; validation: onboarding skippable et session restaurée.

## Phase 5 — Authentification (US1)

- [ ] T015 [P] [US1] Créer `lib/features/auth/domain/auth_session.dart`, `lib/features/auth/data/auth_dto.dart`; objectif: modèle session; dépendance: T006,T008; résultat: dates ISO et statuts active/expired/revoked; validation: sérialisation JSON round-trip.
- [ ] T016 [US1] Implémenter `lib/features/auth/data/auth_repository.dart` et `auth_remote_datasource.dart`; objectif: login/refresh/logout/forgot-password; dépendance: T007,T015; résultat: appels `/auth/*`; validation: contrats success/error couverts par tests.
- [X] T017 [US1] Créer `lib/features/auth/presentation/auth_controller.dart`; objectif: états authenticated/unauthenticated/loading/expired; dépendance: T016; résultat: session réactive; validation: expiration déclenche purge et redirection.
- [X] T018 [US1] Construire `login_screen.dart`, `forgot_password_screen.dart` et `register_screen.dart`; objectif: parcours français; dépendance: T010,T017; résultat: validation formulaire et messages non sensibles; validation: identifiants invalides n'affichent aucune donnée privée.
- [ ] T019 [US1] Finaliser le guard dans `lib/app/router.dart` et le flux `lib/features/auth/presentation/logout_action.dart`; objectif: protéger toutes les routes; dépendance: T017,T018; résultat: logout révoque et efface les secrets; validation: retour login après déconnexion.

## Phase 6 — Tableau de bord (US1)

- [X] T020 [P] [US1] Créer `lib/features/dashboard/domain/dashboard_summary.dart` et `data/dashboard_repository.dart`; objectif: modèle résumé; dépendance: T016; résultat: endpoint `/dashboard`; validation: données partielles représentées sans valeurs inventées.
- [X] T021 [US1] Créer `lib/features/dashboard/presentation/dashboard_controller.dart` et `dashboard_screen.dart`; objectif: accueil personnalisé; dépendance: T020,T010; résultat: identité, statut, solde et raccourcis; validation: accès aux sections principales en moins de trois interactions.
- [ ] T022 [US1] Ajouter `lib/features/dashboard/presentation/dashboard_skeleton.dart`; objectif: chargement fluide; dépendance: T021; résultat: loading/empty/error/offline; validation: retry conserve la route et réessaie l'appel.

## Phase 7 — Profil (US2)

- [ ] T023 [P] [US2] Créer `lib/features/profile/domain/customer.dart` et DTO dans `data/customer_dto.dart`; objectif: modèle Customer; dépendance: T015; résultat: `id`, `displayName`, `phone`, `email`, `accountStatus`, `updatedAt`; validation: dates ISO et champs optionnels testés.
- [ ] T024 [US2] Implémenter `profile_repository.dart`, `profile_controller.dart` et `profile_screen.dart`; objectif: consulter profil; dépendance: T023,T010; résultat: GET `/me`; validation: profil inaccessible hors session.
- [ ] T025 [US2] Implémenter `edit_profile_screen.dart` et `update_profile.dart`; objectif: modifier coordonnées autorisées; dépendance: T024; résultat: PATCH `/me` avec confirmation; validation: champs non modifiables refusés clairement.

## Phase 8 — Abonnements (US3)

- [ ] T026 [P] [US3] Créer `subscription.dart`, `tv_service.dart` et leurs DTO dans `lib/features/subscriptions/domain` et `data`; objectif: modèles d'abonnement; dépendance: T015; résultat: statuts active/expired/suspended/pending; validation: statut inconnu non bloquant.
- [ ] T027 [US3] Implémenter `subscription_repository.dart`, controller et écrans liste/détail; objectif: consulter offres, dates et services; dépendance: T026,T010; résultat: GET `/subscriptions`; validation: actif, suspendu et expiré affichent une action adaptée.
- [ ] T028 [US3] Ajouter rafraîchissement, cache mémoire et invalidation dans `subscriptions_controller.dart`; objectif: résilience réseau; dépendance: T027; résultat: dernier état non sensible horodaté; validation: hors connexion signale les données potentiellement obsolètes.

## Phase 9 — Offres et bouquets (US3)

- [ ] T029 [P] [US3] Créer `offer.dart`, `bundle.dart` et DTO dans `lib/features/offers/domain` et `data`; objectif: tarifs et caractéristiques; dépendance: T026; résultat: prix décimaux, devise, période, chaînes, éligibilité; validation: devise API affichée sans conversion implicite.
- [ ] T030 [US3] Implémenter `offers_repository.dart`, controller, `offers_screen.dart` et `offer_detail_screen.dart`; objectif: catalogue éligible; dépendance: T029,T010; résultat: GET `/offers`; validation: catalogue vide et erreur sont distingués.

## Phase 10 — Renouvellement (US4)

- [ ] T031 [P] [US4] Créer `renewal_order.dart` et DTO dans `lib/features/renewal/domain` et `data`; objectif: commande idempotente; dépendance: T026,T029; résultat: amount, currency, period, status, idempotencyKey; validation: clé générée une seule fois par tentative.
- [ ] T032 [US4] Implémenter `renewal_repository.dart` et `renewal_controller.dart`; objectif: simuler/confirmer `/renewals`; dépendance: T031,T007; résultat: éligibilité et conflit gérés; validation: double soumission ne crée qu'une opération.
- [ ] T033 [US4] Construire `renewal_screen.dart`, confirmation et résultat; objectif: renouvellement compréhensible; dépendance: T032,T010; résultat: résumé offre/période/montant; validation: succès invalide abonnement et historique.

## Phase 11 — Paiement (US4)

- [ ] T034 [P] [US4] Créer `payment.dart` et DTO dans `lib/features/payments/domain` et `data`; objectif: état financier; dépendance: T031; résultat: méthode, statut, montant, référence, reçu; validation: aucun numéro sensible persistant.
- [ ] T035 [US4] Implémenter `payment_repository.dart`, `payment_controller.dart` et écrans moyen/retour/résultat; objectif: initier `/payments`; dépendance: T034,T032; résultat: paiement orchestré par backend; validation: succès, échec, annulation et reprise réseau.
- [ ] T036 [US4] Ajouter garde anti-doublon et reprise dans `payment_controller.dart`; objectif: cohérence financière; dépendance: T035; résultat: idempotency key réutilisée après timeout; validation: une seule transaction côté API simulée.

## Phase 12 — Historique (US5)

- [ ] T037 [P] [US5] Créer `transaction.dart` dans `lib/features/history/domain` et DTO; objectif: opérations paginées; dépendance: T034; résultat: type, montant, statut, date, référence; validation: pagination et tri stables.
- [ ] T038 [US5] Implémenter repository, controller et `history_screen.dart`; objectif: suivre paiements/renouvellements; dépendance: T037,T010; résultat: GET `/transactions`; validation: filtres et état vide fonctionnent.

## Phase 13 — Notifications (US5)

- [ ] T039 [P] [US5] Configurer Firebase Messaging et `lib/features/notifications/data/push_notification_service.dart`; objectif: réception push Android; dépendance: T003; résultat: token enregistré sans donnée sensible; validation: permission refusée gérée.
- [ ] T040 [US5] Créer `app_notification.dart`, repository, controller et `notifications_screen.dart`; objectif: centre in-app; dépendance: T007,T010; résultat: GET/PATCH notifications; validation: marquer lu met à jour le badge.

## Phase 14 — Support (US5)

- [ ] T041 [P] [US5] Créer `support_ticket.dart`, DTO et validation dans `lib/features/support/domain` et `data`; objectif: demandes support; dépendance: T015; résultat: motif, description, coordonnées, statut; validation: champs requis et longueur validés.
- [ ] T042 [US5] Implémenter repository, controller, `support_screen.dart` et `create_ticket_screen.dart`; objectif: créer/suivre tickets; dépendance: T041,T010; résultat: POST/GET `/support/tickets`; validation: confirmation après envoi et retry après erreur.

## Phase 15 — Paramètres (US5)

- [ ] T043 [P] [US5] Créer `app_settings.dart` et `settings_repository.dart` dans `lib/features/settings`; objectif: préférences locales non sensibles; dépendance: T008; résultat: notifications et onboarding; validation: aucune préférence ne contient de secret.
- [ ] T044 [US5] Construire `settings_screen.dart` avec accès sécurité, aide et déconnexion; objectif: centraliser réglages; dépendance: T043,T019; résultat: actions navigables; validation: déconnexion complète depuis paramètres.

## Phase 16 — Sécurité

- [ ] T045 Auditer `lib/core/security`, `lib/core/network` et les logs; objectif: supprimer secrets et données personnelles des traces; dépendance: T019,T035; résultat: journalisation filtrée; validation: test détecte token/mot de passe dans les logs.
- [ ] T046 Configurer permissions, backup exclusions, obfuscation et keystore dans `android/app/src/main/AndroidManifest.xml`, `android/app/proguard-rules.pro`; objectif: release Android sûre; dépendance: T003; résultat: secrets hors dépôt; validation: artefact release ne contient aucune clé de test.

## Phase 17 — Tests

- [ ] T047 [P] Ajouter tests unitaires des use cases et repositories dans `test/features/**`; objectif: règles métier; dépendance: T020,T025,T033,T038,T042; résultat: couverture des transitions et erreurs; validation: `flutter test` passe.
- [ ] T048 [P] Ajouter tests widgets dans `test/presentation/**`; objectif: composants et écrans critiques; dépendance: T010,T018,T021; résultat: loading/error/empty/accessibilité; validation: tests sans réseau réel.
- [ ] T049 Ajouter tests de contrats JSON dans `test/contracts/**` selon `contracts/mobile-api.md`; objectif: compatibilité API; dépendance: T007,T016; résultat: fixtures success/error; validation: codes d'erreur et champs obligatoires vérifiés.
- [ ] T050 Ajouter parcours Android dans `integration_test/app_flows_test.dart`; objectif: validation de bout en bout; dépendance: T046,T047; résultat: login, abonnement, renouvellement, logout; validation: émulateur Android exécute les scénarios quickstart.

## Phase 18 — Optimisation

- [ ] T051 Auditer reconstructions/providers avec Flutter DevTools dans `lib/features/**`; objectif: réactivité; dépendance: T050; résultat: providers ciblés et écrans fluides; validation: aucune reconstruction globale sur interaction locale.
- [ ] T052 Optimiser images, listes paginées et cache dans `lib/core` et `lib/features/**`; objectif: mémoire et réseau; dépendance: T028,T038; résultat: images dimensionnées, pagination active; validation: profilage sur appareil entrée de gamme.
- [ ] T053 Ajouter états offline/retry dans `lib/core/network/connectivity_service.dart`; objectif: fonctionnement dégradé; dépendance: T007,T028; résultat: mutations désactivées hors connexion; validation: scénario réseau coupé conforme à quickstart.

## Phase 19 — Génération de l'application Android

- [ ] T054 Configurer nom, icône, splash, version et orientations dans `android/app/src/main`, `pubspec.yaml`; objectif: identité de livraison; dépendance: T009,T046; résultat: application CIC installable; validation: installation propre sur Android.
- [ ] T055 Générer APK et AAB signés par flavor via `android/fastlane` ou scripts CI; objectif: distribution; dépendance: T050,T054; résultat: artefacts dev/staging/prod; validation: `flutter build apk --release` et `flutter build appbundle --release` réussissent.
- [ ] T056 Documenter publication et rollback dans `README.md` et `specs/002-digicable-customer-portal/quickstart.md`; objectif: livraison reproductible; dépendance: T055; résultat: procédure complète sans secret; validation: une personne tierce peut reproduire un build de test.

## Opportunités d'exécution parallèle

- Après T005: T006, T008, T009 et T011.
- Après T015: T020, T023, T026 et T029 selon les contrats concernés.
- Après T031: T034 et T037.
- Après T047: T048 et T049.

## Validation du format

Les 56 tâches utilisent toutes le format `- [ ] Txxx`, avec `[P]` uniquement pour les tâches
parallélisables, `[USn]` dans les phases de user stories et un chemin de fichier explicite.

## Phase 20: Convergence

- [ ] T057 Installer Flutter/Dart et valider le socle `pubspec.yaml`, `lib/main.dart` et `android/` avec `flutter pub get`, `flutter analyze` et un build Android (T001/T002, missing).
- [ ] T058 Implémenter le client REST Dio, les intercepteurs bearer, les timeouts et le mapping des réponses JSON dans `lib/core/network/`, puis connecter les repositories aux contrats `/api/v1` (plan: API REST, missing).
- [ ] T059 Implémenter le stockage sécurisé et la restauration/expiration/révocation de session dans `lib/core/storage/` et `lib/core/security/`, sans persister de mot de passe (Constitution III, partial).
- [ ] T060 Ajouter le guard d'authentification réel à `lib/app/router.dart` et empêcher l'accès direct à toutes les routes privées en l'absence de session active (FR-002/US1-AC3, partial).
- [ ] T061 Remplacer le mode de connexion de démonstration par les parcours API login, refresh, logout, récupération, inscription et vérification dans `lib/features/auth/` (FR-001/FR-004, partial).
- [ ] T062 Ajouter les écrans splash et onboarding, ainsi que la restauration de session au démarrage dans `lib/features/auth/presentation/` (plan: navigation, missing).
- [ ] T063 Corriger et compléter le design system avec les composants réutilisables, les messages centralisés et les états accessibles dans `lib/core/widgets/`, `lib/core/config/` et `lib/app/theme/` (Constitution I/T010/T011, partial).
- [ ] T064 Implémenter le profil en consultation et modification avec validation, confirmation, champs non modifiables et erreurs réseau dans `lib/features/profile/` (US2/FR-005, missing).
- [ ] T065 Implémenter abonnements, services, bouquets et offres avec états loading/success/empty/error et données API dans `lib/features/subscriptions/` et `lib/features/offers/` (US3/FR-006, missing).
- [ ] T066 Implémenter le renouvellement idempotent avec éligibilité, confirmation, conflit et invalidation du tableau de bord dans `lib/features/renewal/` (US4/FR-008, missing).
- [ ] T067 Implémenter le paiement orchestré par CIC, ses états succès/échec/annulation, le retour fournisseur et le reçu dans `lib/features/payments/` (US4/FR-008, missing).
- [ ] T068 Implémenter l'historique paginé des paiements et opérations dans `lib/features/history/`, relié aux mutations de renouvellement et paiement (US5/FR-007, missing).
- [ ] T069 Implémenter les notifications in-app, le marquage lu et la configuration push Android avec consentement dans `lib/features/notifications/` (US5/FR-010, missing).
- [ ] T070 Implémenter FAQ, problèmes fréquents, contact, création et suivi des demandes dans `lib/features/support/` (FR-009/FR-010, missing).
- [ ] T071 Implémenter paramètres, préférences non sensibles, conditions, à-propos et déconnexion complète dans `lib/features/settings/` (FR-011/Constitution III, missing).
- [ ] T072 Ajouter les tests unitaires, widgets, contrats JSON et intégration Android prévus dans `test/` et `integration_test/` (Constitution V/T047-T050, missing).
- [ ] T073 Implémenter la détection hors connexion, le cache non sensible horodaté, les retries et le blocage des mutations sans réseau dans `lib/core/network/` (FR-012/Constitution IV, missing).
- [ ] T074 Auditer accessibilité, performances, reconstructions, pagination, images et tailles d'écran sur appareils Android entrée/milieu/haut de gamme dans `lib/` et `android/` (Constitution I/V, missing).
- [ ] T075 Configurer permissions, sauvegarde excluant les secrets, obfuscation, flavors, signature et génération APK/AAB dans `android/` (T046/T055, missing).
