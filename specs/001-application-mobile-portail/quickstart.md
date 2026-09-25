# Quickstart: Validation de l’application mobile portail DigiCâbles

## Prérequis

- Accès au portail DigiCâbles existant ou à un environnement de test équivalent.
- Comptes de test : abonné actif, abonné suspendu/expiré, identifiants invalides.
- Données de test : abonnement, factures, paiements et au moins une demande d’assistance.
- Application mobile installable sur un appareil ou simulateur Android/iOS.
- Couche d’intégration configurée vers l’environnement de test.

## Scénario 1 — Connexion réussie

1. Ouvrir l’application.
2. Saisir les identifiants d’un abonné actif.
3. Valider la connexion.

**Expected Outcome**:
- L’utilisateur arrive sur l’accueil personnalisé.
- Le nom ou libellé abonné est visible.
- Les raccourcis Abonnement, Factures/Paiements et Assistance sont accessibles.
- Le parcours complet prend moins de 60 secondes pour un utilisateur testeur.

## Scénario 2 — Connexion refusée

1. Ouvrir l’application.
2. Saisir un login ou mot de passe incorrect.
3. Valider.

**Expected Outcome**:
- L’accès est refusé.
- Le message est compréhensible en français.
- Aucune donnée personnelle n’est affichée.

## Scénario 3 — Consultation abonnement

1. Se connecter avec un abonné actif.
2. Depuis l’accueil, ouvrir Abonnement.

**Expected Outcome**:
- Offre, statut, dates utiles et services sont affichés.
- La section est atteinte en moins de trois interactions.

## Scénario 4 — Consultation factures et paiements

1. Se connecter avec un abonné ayant des factures et paiements.
2. Ouvrir Factures/Paiements.
3. Vérifier le solde, les factures et les paiements.

**Expected Outcome**:
- L’utilisateur identifie clairement le montant dû ou l’absence de dette.
- Chaque facture affiche période, montant et statut.
- Chaque paiement affiche date, montant et statut.

## Scénario 5 — Demande d’assistance

1. Se connecter avec un abonné actif.
2. Ouvrir Assistance.
3. Renseigner un motif et une description.
4. Envoyer la demande.

**Expected Outcome**:
- Une confirmation lisible est affichée.
- La demande apparaît dans le suivi si la liste des demandes est disponible.
- Le parcours prend moins de 2 minutes pour un utilisateur testeur.

## Scénario 6 — Session expirée/inactivité

1. Se connecter.
2. Laisser l’application inactive jusqu’au délai d’expiration configuré.
3. Revenir sur l’application.

**Expected Outcome**:
- Les données sensibles sont protégées.
- L’application demande une nouvelle authentification.
- Après reconnexion, l’utilisateur peut reprendre son parcours.

## Scénario 7 — Portail ou réseau indisponible

1. Simuler une coupure réseau ou une indisponibilité du portail.
2. Ouvrir une section nécessitant des données distantes.

**Expected Outcome**:
- L’application affiche un message non technique.
- L’utilisateur peut réessayer.
- L’application ne se bloque pas et conserve un état sûr.

## Références

- Modèle de données : [data-model.md](./data-model.md)
- Contrat BFF : [contracts/mobile-api.md](./contracts/mobile-api.md)
- Contrats de parcours UI : [contracts/ui-flows.md](./contracts/ui-flows.md)
