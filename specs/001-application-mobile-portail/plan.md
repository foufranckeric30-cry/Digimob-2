# Implementation Plan: Application mobile portail DigiCâbles

**Branch**: `001-application-mobile-portail` | **Date**: 2026-09-22 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/001-application-mobile-portail/spec.md`

## Summary

Créer une application mobile abonné DigiCâbles pour Android et iOS permettant la connexion avec les identifiants existants du portail, la consultation du profil, de l’abonnement, des factures/paiements et l’envoi de demandes d’assistance. L’approche technique retenue est une application mobile cross-platform avec une couche d’intégration dédiée au portail existant, afin d’isoler les écrans mobiles des contraintes du portail web et de fournir des contrats stables pour l’application.


## Options retenues

- **Type d’application**: application mobile abonné DigiCâbles.
- **Utilisateurs ciblés**: abonnés/clients DigiCâbles en priorité ; administrateurs et agents support hors MVP.
- **Plateformes**: Android et iOS.
- **Connexion**: obligatoire pour accéder aux données personnelles, abonnement, facturation et assistance.
- **Approche mobile**: application cross-platform pour livrer Android/iOS avec une base commune.
- **Intégration portail**: couche Backend-for-Mobile entre l’application et le portail existant.
- **Fonctions MVP**: connexion, récupération/inscription, accueil, profil, abonnement, factures/paiements, assistance.
- **Paiement mobile natif**: non inclus dans le MVP, sauf réutilisation d’un parcours déjà validé côté DigiCâbles.
- **Langue d’interface**: français.
- **Stockage local**: minimal et sécurisé, sans cache durable des données personnelles ou financières.

## Technical Context

**Language/Version**: TypeScript stable courant pour l’application mobile ; service d’intégration compatible avec l’écosystème JavaScript/TypeScript.

**Primary Dependencies**: React Native avec Expo pour l’application Android/iOS ; bibliothèque de navigation mobile ; gestion sécurisée de session et stockage local sécurisé ; client HTTP ; service d’intégration Backend-for-Mobile vers le portail DigiCâbles existant.

**Storage**: Stockage sécurisé local uniquement pour jetons/session et préférences non sensibles ; aucune persistance locale durable des factures, paiements ou données personnelles dans la première version.

**Testing**: Tests unitaires TypeScript, tests de composants/UI, tests d’intégration sur les contrats mobile, scénarios bout-en-bout sur Android et iOS.

**Target Platform**: Android et iOS modernes, avec support des tailles d’écran smartphone courantes.

**Project Type**: Application mobile + couche d’intégration Backend-for-Mobile.

**Performance Goals**: Connexion et affichage de l’accueil en moins de 60 secondes pour 90 % des testeurs ; navigation vers abonnement en moins de 3 interactions ; écrans principaux perçus comme réactifs avec indicateurs de chargement clairs.

**Constraints**: Protection des données personnelles ; session expirée ou inactive à gérer explicitement ; fonctionnement dégradé clair en cas de réseau instable ou de données portail indisponibles ; interface en français.

**Scale/Scope**: MVP abonné uniquement : connexion, récupération/inscription, profil, abonnement, facturation, assistance. Hors périmètre : administration interne, paiement mobile natif, support agent, notifications push avancées.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

La constitution du projet est encore le modèle par défaut et ne définit pas de principes applicables vérifiables. Aucun gate constitutionnel bloquant n’est identifié pour cette phase. Les décisions de plan privilégient néanmoins : simplicité du MVP, testabilité indépendante des parcours, sécurité des données abonné et séparation entre expérience mobile et portail existant.

**Gate Status**: PASS — aucune violation constitutionnelle applicable.

## Project Structure

### Documentation (this feature)

```text
specs/001-application-mobile-portail/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   ├── mobile-api.md
│   └── ui-flows.md
└── tasks.md
```

### Source Code (repository root)

```text
apps/
├── mobile/
│   ├── src/
│   │   ├── app/
│   │   ├── features/
│   │   │   ├── auth/
│   │   │   ├── home/
│   │   │   ├── profile/
│   │   │   ├── subscription/
│   │   │   ├── billing/
│   │   │   └── support/
│   │   ├── shared/
│   │   └── test/
│   └── e2e/
└── bff/
    ├── src/
    │   ├── contracts/
    │   ├── portal/
    │   ├── security/
    │   └── modules/
    │       ├── auth/
    │       ├── subscriber/
    │       ├── subscription/
    │       ├── billing/
    │       └── support/
    └── test/
```

**Structure Decision**: Utiliser une structure `apps/mobile` + `apps/bff`. Le mobile reste focalisé sur l’expérience utilisateur, tandis que `apps/bff` encapsule l’intégration au portail DigiCâbles et expose des contrats stables adaptés au mobile.

## Complexity Tracking

Aucune violation constitutionnelle ou complexité exceptionnelle à justifier. La présence d’une couche `bff` est retenue pour protéger l’application mobile de la structure HTML/session du portail existant et pour centraliser sécurité, erreurs et transformations de données.

## Post-Design Constitution Check

Après génération de `research.md`, `data-model.md`, `contracts/` et `quickstart.md`, aucune règle constitutionnelle applicable n’est violée. Les artefacts conservent une séparation claire entre besoins utilisateur, contrats et validation.

**Gate Status**: PASS.
