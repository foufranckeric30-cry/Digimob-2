# Tasks: Application mobile portail DigiCâbles

**Input**: Design documents from `/specs/001-application-mobile-portail/`

**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/, quickstart.md

**Tests**: Aucun mode TDD n’a été demandé explicitement. Les tâches ci-dessous incluent des validations fonctionnelles et des fichiers de scénarios, mais pas de phase de tests obligatoires avant implémentation.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (US1, US2, US3, US4)
- Include exact file paths in descriptions

## Path Conventions

- Application mobile: `apps/mobile/`
- Couche Backend-for-Mobile: `apps/bff/`
- Documentation feature: `specs/001-application-mobile-portail/`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Initialiser la structure projet mobile + Backend-for-Mobile retenue dans le plan.

- [ ] T001 Create monorepo application directories `apps/mobile/`, `apps/bff/`, and shared documentation references in `README.md`
- [ ] T002 Initialize mobile TypeScript project structure in `apps/mobile/` with `src/app/`, `src/features/`, `src/shared/`, and `e2e/` directories
- [ ] T003 Initialize Backend-for-Mobile TypeScript project structure in `apps/bff/` with `src/contracts/`, `src/portal/`, `src/security/`, `src/modules/`, and `test/` directories
- [ ] T004 [P] Create mobile environment template for BFF base URL and session settings in `apps/mobile/.env.example`
- [ ] T005 [P] Create BFF environment template for DigiCâbles portal URL and session timeout settings in `apps/bff/.env.example`
- [ ] T006 [P] Configure shared TypeScript, linting, and formatting conventions in `package.json`, `tsconfig.base.json`, and `.editorconfig`
- [ ] T007 [P] Add feature documentation links to `README.md` referencing `specs/001-application-mobile-portail/spec.md`, `plan.md`, and `quickstart.md`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Mettre en place les fondations communes bloquantes avant toute user story.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete.

- [ ] T008 Create BFF contract type definitions for common API responses and functional errors in `apps/bff/src/contracts/common.ts`
- [ ] T009 Create BFF portal client shell for the existing DigiCâbles portal integration in `apps/bff/src/portal/portalClient.ts`
- [ ] T010 Create BFF security session model with states `active`, `expired`, and `revoked` in `apps/bff/src/security/session.ts`
- [ ] T011 Create BFF authentication middleware that blocks protected resources without an active session in `apps/bff/src/security/authMiddleware.ts`
- [ ] T012 [P] Create BFF error mapping for `INVALID_CREDENTIALS`, `ACCOUNT_BLOCKED`, `PORTAL_UNAVAILABLE`, and `NETWORK_TIMEOUT` in `apps/bff/src/contracts/errors.ts`
- [ ] T013 [P] Create mobile API client wrapper with standardized loading and error handling in `apps/mobile/src/shared/api/client.ts`
- [ ] T014 [P] Create mobile secure session storage abstraction with minimal local persistence in `apps/mobile/src/shared/security/sessionStore.ts`
- [ ] T015 [P] Create mobile French UI message catalog for auth, network, session, subscription, billing, and support states in `apps/mobile/src/shared/i18n/fr.ts`
- [ ] T016 Create mobile navigation skeleton for Auth, Home, Profile, Subscription, Billing, and Support areas in `apps/mobile/src/app/navigation.tsx`
- [ ] T017 Create shared mobile screen layout components for loading, empty, error, and protected states in `apps/mobile/src/shared/ui/ScreenStates.tsx`

**Checkpoint**: Foundation ready - user story implementation can now begin in priority order or in parallel by separate contributors.

---

## Phase 3: User Story 1 - Accéder à son espace abonné (Priority: P1) 🎯 MVP

**Goal**: Permettre à un abonné DigiCâbles de se connecter avec ses identifiants existants, d’accéder à un accueil personnalisé et de récupérer/demander un accès depuis l’écran de connexion.

**Independent Test**: Utiliser un compte abonné valide puis vérifier que l’utilisateur atteint un accueil personnalisé ; utiliser des identifiants invalides puis vérifier que l’accès est refusé avec un message clair.

### Implementation for User Story 1

- [ ] T018 [P] [US1] Create BFF `Subscriber` model with fields `id`, `login`, `displayName`, `phone`, `email`, and `accountStatus` in `apps/bff/src/modules/subscriber/subscriber.model.ts`
- [ ] T019 [P] [US1] Create BFF login request and response contracts from `contracts/mobile-api.md` in `apps/bff/src/modules/auth/auth.contract.ts`
- [ ] T020 [US1] Implement portal login adapter using existing portal credentials flow in `apps/bff/src/portal/authPortalAdapter.ts`
- [ ] T021 [US1] Implement BFF login/logout service using session states `active`, `expired`, and `revoked` in `apps/bff/src/modules/auth/auth.service.ts`
- [ ] T022 [US1] Implement BFF auth routes for `POST /auth/login` and `POST /auth/logout` in `apps/bff/src/modules/auth/auth.routes.ts`
- [ ] T023 [P] [US1] Create mobile auth API functions for login and logout in `apps/mobile/src/features/auth/auth.api.ts`
- [ ] T024 [P] [US1] Create mobile auth state management for authenticated, unauthenticated, loading, and expired states in `apps/mobile/src/features/auth/auth.store.ts`
- [ ] T025 [US1] Build mobile login screen with login, password, remember-me, submit, and recovery/registration link in `apps/mobile/src/features/auth/LoginScreen.tsx`
- [ ] T026 [US1] Build mobile password recovery or registration entry screen that links to the existing DigiCâbles recovery flow in `apps/mobile/src/features/auth/RecoveryEntryScreen.tsx`
- [ ] T027 [US1] Create mobile protected route guard that redirects unauthenticated users to login in `apps/mobile/src/app/ProtectedRoute.tsx`
- [ ] T028 [US1] Build mobile home screen showing subscriber display name, account status, and shortcuts in `apps/mobile/src/features/home/HomeScreen.tsx`
- [ ] T029 [US1] Connect successful login to secure session storage and home navigation in `apps/mobile/src/features/auth/auth.flow.ts`
- [ ] T030 [US1] Implement invalid credentials, blocked account, network timeout, and portal unavailable messages in `apps/mobile/src/features/auth/AuthErrorMessage.tsx`
- [ ] T031 [US1] Document manual validation for valid login, invalid login, logout, and recovery entry in `apps/mobile/e2e/us1-auth.md`

**Checkpoint**: US1 is fully functional and testable independently as the MVP.

---

## Phase 4: User Story 2 - Consulter son abonnement et ses services (Priority: P2)

**Goal**: Permettre à un abonné connecté de consulter son offre, son statut, ses dates utiles et ses services associés.

**Independent Test**: Se connecter avec un compte actif, suspendu ou expiré, ouvrir Abonnement et vérifier que les informations et actions recommandées sont compréhensibles.

### Implementation for User Story 2

- [ ] T032 [P] [US2] Create BFF `Subscription` model with fields `id`, `offerName`, `status`, `startDate`, `endDate`, and `services` in `apps/bff/src/modules/subscription/subscription.model.ts`
- [ ] T033 [P] [US2] Create BFF subscription response contract for `GET /subscription` in `apps/bff/src/modules/subscription/subscription.contract.ts`
- [ ] T034 [US2] Implement portal subscription adapter to extract offer, status, useful dates, and services in `apps/bff/src/portal/subscriptionPortalAdapter.ts`
- [ ] T035 [US2] Implement BFF subscription service with French status normalization for `active`, `expired`, `suspended`, `pending`, and `unknown` in `apps/bff/src/modules/subscription/subscription.service.ts`
- [ ] T036 [US2] Implement protected BFF route `GET /subscription` in `apps/bff/src/modules/subscription/subscription.routes.ts`
- [ ] T037 [P] [US2] Create mobile subscription API function in `apps/mobile/src/features/subscription/subscription.api.ts`
- [ ] T038 [P] [US2] Create mobile subscription state handling for loading, loaded, unavailable, and partial data states in `apps/mobile/src/features/subscription/subscription.store.ts`
- [ ] T039 [US2] Build mobile subscription screen showing offer, status, services, dates, and recommended action in `apps/mobile/src/features/subscription/SubscriptionScreen.tsx`
- [ ] T040 [US2] Add Home shortcut navigation to the subscription screen in `apps/mobile/src/features/home/HomeShortcuts.tsx`
- [ ] T041 [US2] Document manual validation for active, suspended, expired, and unavailable subscription data in `apps/mobile/e2e/us2-subscription.md`

**Checkpoint**: US2 works independently after login and does not require billing or support features.

---

## Phase 5: User Story 3 - Suivre ses paiements et factures (Priority: P3)

**Goal**: Permettre à un abonné connecté de consulter son solde, ses factures et ses paiements.

**Independent Test**: Utiliser un compte avec plusieurs factures/paiements puis vérifier que l’utilisateur identifie clairement son solde et l’historique affiché.

### Implementation for User Story 3

- [ ] T042 [P] [US3] Create BFF `Invoice` model with fields `id`, `periodLabel`, `issuedAt`, `dueAt`, `amount`, `currency`, and `status` in `apps/bff/src/modules/billing/invoice.model.ts`
- [ ] T043 [P] [US3] Create BFF `Payment` model with fields `id`, `paidAt`, `amount`, `currency`, `status`, and `reference` in `apps/bff/src/modules/billing/payment.model.ts`
- [ ] T044 [P] [US3] Create BFF billing contracts for `GET /billing/summary`, `GET /billing/invoices`, and `GET /billing/payments` in `apps/bff/src/modules/billing/billing.contract.ts`
- [ ] T045 [US3] Implement portal billing adapter to extract balance, invoices, and payments in `apps/bff/src/portal/billingPortalAdapter.ts`
- [ ] T046 [US3] Implement BFF billing service with statuses `paid`, `due`, `overdue`, `cancelled`, `confirmed`, `pending`, `failed`, and `unknown` in `apps/bff/src/modules/billing/billing.service.ts`
- [ ] T047 [US3] Implement protected BFF billing routes in `apps/bff/src/modules/billing/billing.routes.ts`
- [ ] T048 [P] [US3] Create mobile billing API functions for summary, invoices, and payments in `apps/mobile/src/features/billing/billing.api.ts`
- [ ] T049 [P] [US3] Create mobile billing state handling for balance, invoice list, payment list, empty states, and unavailable data in `apps/mobile/src/features/billing/billing.store.ts`
- [ ] T050 [US3] Build mobile billing summary screen highlighting amount due, due date, or no-debt message in `apps/mobile/src/features/billing/BillingSummaryScreen.tsx`
- [ ] T051 [US3] Build mobile invoices list component showing period, amount, date, and status in `apps/mobile/src/features/billing/InvoiceList.tsx`
- [ ] T052 [US3] Build mobile payments list component showing date, amount, status, and reference in `apps/mobile/src/features/billing/PaymentList.tsx`
- [ ] T053 [US3] Add Home shortcut navigation to billing screens in `apps/mobile/src/features/home/HomeShortcuts.tsx`
- [ ] T054 [US3] Document manual validation for no balance due, amount due, overdue invoice, and payment history in `apps/mobile/e2e/us3-billing.md`

**Checkpoint**: US3 works independently after login and does not require support submission.

---

## Phase 6: User Story 4 - Demander de l’aide ou signaler un problème (Priority: P4)

**Goal**: Permettre à un abonné connecté de créer une demande d’assistance et de consulter le statut des demandes disponibles.

**Independent Test**: Soumettre une demande simple avec motif et description puis vérifier qu’une confirmation et un statut de suivi sont visibles.

### Implementation for User Story 4

- [ ] T055 [P] [US4] Create BFF `SupportRequest` model with fields `id`, `subject`, `description`, `contactPreference`, `createdAt`, `status`, and `lastUpdateAt` in `apps/bff/src/modules/support/supportRequest.model.ts`
- [ ] T056 [P] [US4] Create BFF support contracts for `POST /support/requests` and `GET /support/requests` in `apps/bff/src/modules/support/support.contract.ts`
- [ ] T057 [US4] Implement portal support adapter to create and list assistance requests in `apps/bff/src/portal/supportPortalAdapter.ts`
- [ ] T058 [US4] Implement BFF support service with statuses `submitted`, `in_progress`, `resolved`, `closed`, and `unknown` in `apps/bff/src/modules/support/support.service.ts`
- [ ] T059 [US4] Implement protected BFF support routes in `apps/bff/src/modules/support/support.routes.ts`
- [ ] T060 [P] [US4] Create mobile support API functions for creating and listing requests in `apps/mobile/src/features/support/support.api.ts`
- [ ] T061 [P] [US4] Create mobile support state handling for form draft, submitting, submitted, list loading, and failure states in `apps/mobile/src/features/support/support.store.ts`
- [ ] T062 [US4] Build mobile support request form requiring subject and description in `apps/mobile/src/features/support/SupportRequestScreen.tsx`
- [ ] T063 [US4] Build mobile support confirmation view with request summary and confirmation message in `apps/mobile/src/features/support/SupportConfirmationScreen.tsx`
- [ ] T064 [US4] Build mobile support requests list with status and last update in `apps/mobile/src/features/support/SupportRequestsList.tsx`
- [ ] T065 [US4] Add Home shortcut navigation to support screens in `apps/mobile/src/features/home/HomeShortcuts.tsx`
- [ ] T066 [US4] Document manual validation for successful support request, missing required fields, and portal unavailable state in `apps/mobile/e2e/us4-support.md`

**Checkpoint**: US4 works independently after login and can be delivered after core self-service flows.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Améliorations globales, sécurité, cohérence UX et validation complète du quickstart.

- [ ] T067 [P] Review all French copy and DigiCâbles labels in `apps/mobile/src/shared/i18n/fr.ts`
- [ ] T068 Harden inactivity handling and session expiration behavior across `apps/mobile/src/app/ProtectedRoute.tsx` and `apps/bff/src/security/session.ts`
- [ ] T069 [P] Add accessibility labels and mobile-friendly touch targets across screens in `apps/mobile/src/features/`
- [ ] T070 [P] Add privacy review notes for local storage and sensitive data display in `docs/privacy-mobile.md`
- [ ] T071 Consolidate BFF route registration for auth, subscriber, subscription, billing, and support in `apps/bff/src/app.ts`
- [ ] T072 Validate all contract responses against `specs/001-application-mobile-portail/contracts/mobile-api.md` in `apps/bff/src/contracts/validation.ts`
- [ ] T073 Execute quickstart validation scenarios and record results in `specs/001-application-mobile-portail/validation-results.md`
- [ ] T074 Update implementation README with run, configuration, and validation steps in `README.md`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately.
- **Foundational (Phase 2)**: Depends on Setup completion - blocks all user stories.
- **US1 (Phase 3)**: Depends on Foundational; recommended MVP.
- **US2 (Phase 4)**: Depends on Foundational and login/session from US1 for real app navigation; can implement BFF/mobile files in parallel with US1 if mocks are used.
- **US3 (Phase 5)**: Depends on Foundational and login/session from US1 for real app navigation; can implement BFF/mobile files in parallel with US2.
- **US4 (Phase 6)**: Depends on Foundational and login/session from US1 for real app navigation.
- **Polish (Phase 7)**: Depends on desired stories being complete.

### User Story Dependencies

- **User Story 1 (P1)**: Required MVP and authentication base.
- **User Story 2 (P2)**: Requires authenticated access; otherwise independent from billing/support.
- **User Story 3 (P3)**: Requires authenticated access; independent from subscription/support.
- **User Story 4 (P4)**: Requires authenticated access; independent from subscription/billing.

### Within Each User Story

- Models and contracts before services.
- Portal adapters before BFF services using portal data.
- BFF routes before mobile API integration.
- Mobile API/state before mobile screens.
- Manual validation document after story implementation.

---

## Parallel Opportunities

- Setup tasks T004-T007 can run in parallel after T001-T003 are understood.
- Foundational tasks T012-T015 can run in parallel after T008-T011 are started.
- Within US1, T018/T019 and T023/T024 can run in parallel.
- Within US2, T032/T033 and T037/T038 can run in parallel.
- Within US3, T042/T043/T044 and T048/T049 can run in parallel.
- Within US4, T055/T056 and T060/T061 can run in parallel.
- After Phase 2, different contributors can implement US2, US3, and US4 in parallel using mocked authenticated session behavior, then integrate through US1.

---

## Parallel Example: User Story 1

```bash
# BFF model/contract work in parallel
Task: "T018 [US1] Create BFF Subscriber model in apps/bff/src/modules/subscriber/subscriber.model.ts"
Task: "T019 [US1] Create BFF login request and response contracts in apps/bff/src/modules/auth/auth.contract.ts"

# Mobile state/API work in parallel
Task: "T023 [US1] Create mobile auth API functions in apps/mobile/src/features/auth/auth.api.ts"
Task: "T024 [US1] Create mobile auth state management in apps/mobile/src/features/auth/auth.store.ts"
```

## Parallel Example: User Story 3

```bash
# Billing data contracts in parallel
Task: "T042 [US3] Create BFF Invoice model in apps/bff/src/modules/billing/invoice.model.ts"
Task: "T043 [US3] Create BFF Payment model in apps/bff/src/modules/billing/payment.model.ts"
Task: "T044 [US3] Create BFF billing contracts in apps/bff/src/modules/billing/billing.contract.ts"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup.
2. Complete Phase 2: Foundational.
3. Complete Phase 3: User Story 1.
4. Stop and validate login, invalid login, logout, recovery entry, and protected home.
5. Demo the MVP before adding subscription, billing, or support.

### Incremental Delivery

1. Setup + Foundational → stable mobile/BFF base.
2. US1 → authentication and home MVP.
3. US2 → subscription self-service.
4. US3 → financial visibility.
5. US4 → support requests.
6. Polish → security, UX, docs, validation results.

### Parallel Team Strategy

With multiple developers after Phase 2:

1. Developer A: US1 authentication and home.
2. Developer B: US2 subscription module.
3. Developer C: US3 billing module.
4. Developer D: US4 support module.
5. Integrate all modules through the mobile navigation and BFF route registry.

---

## Notes

- [P] tasks are in different files and can run in parallel when prerequisite phases are satisfied.
- [US1] through [US4] labels map directly to prioritized user stories in `spec.md`.
- Each story has its own manual validation file under `apps/mobile/e2e/`.
- Keep mobile screens user-focused and keep portal-specific parsing inside `apps/bff/src/portal/`.
- Avoid caching personal or financial data locally beyond the minimal secure session needs defined in `research.md`.
