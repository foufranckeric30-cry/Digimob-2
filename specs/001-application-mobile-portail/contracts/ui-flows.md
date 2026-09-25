# Contract: Mobile UI Flows

## Flow 1: Connexion abonné

1. L’utilisateur ouvre l’application.
2. L’écran de connexion affiche login, mot de passe, option de mémorisation et lien récupération/inscription.
3. L’utilisateur soumet ses identifiants.
4. En cas de succès, il arrive sur l’accueil personnalisé.
5. En cas d’échec, un message français explique l’action possible.

**Acceptance mapping**: US1, FR-001 à FR-004, FR-012.

## Flow 2: Accueil abonné

1. L’utilisateur connecté voit son nom ou libellé abonné.
2. L’accueil affiche un résumé du compte et des raccourcis : Abonnement, Factures, Assistance, Profil.
3. Chaque section principale est accessible en moins de trois interactions.

**Acceptance mapping**: FR-003, FR-015, SC-002.

## Flow 3: Consultation abonnement

1. L’utilisateur ouvre la section Abonnement.
2. L’application affiche offre, statut, dates utiles et services.
3. Si le statut demande une action, elle est mise en évidence.

**Acceptance mapping**: US2, FR-006, FR-008.

## Flow 4: Consultation facturation

1. L’utilisateur ouvre la section Factures/Paiements.
2. Il voit le solde ou l’absence de montant dû.
3. Il peut consulter les listes de factures et paiements avec leurs statuts.

**Acceptance mapping**: US3, FR-007, FR-008, SC-003.

## Flow 5: Demande d’assistance

1. L’utilisateur ouvre Assistance.
2. Il choisit ou saisit un motif, décrit le problème et confirme.
3. L’application affiche une confirmation avec un résumé.
4. L’utilisateur peut voir le statut des demandes existantes si disponible.

**Acceptance mapping**: US4, FR-009, FR-010.

## Flow 6: Session expirée ou inactivité

1. L’utilisateur revient après une période d’inactivité.
2. L’application protège les données affichées.
3. L’utilisateur doit se réauthentifier avant de continuer.

**Acceptance mapping**: FR-002, FR-013.
