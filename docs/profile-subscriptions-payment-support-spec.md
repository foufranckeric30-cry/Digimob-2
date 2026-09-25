# Spécifications fonctionnelles complémentaires

## Profil

Le profil affiche nom, prénom, téléphone, email, numéro client et statut du compte. Les coordonnées
autorisées sont validées avant modification, puis une confirmation est affichée. Les erreurs réseau,
session expirée et champ non modifiable sont explicites. L'écran permet d'ouvrir les paramètres et de
se déconnecter; les données restent protégées derrière une session.

## Abonnements

Le client consulte l'offre, statut, expiration, services et bouquets. Les offres accessibles peuvent
être détaillées et changées uniquement si l'API confirme l'éligibilité. Le renouvellement affiche
période, montant et conditions, exige une confirmation et une clé d'idempotence. Les états loading,
success, empty et error sont obligatoires.

## Paiement

Le parcours sélectionne un abonnement, affiche le montant et les moyens fournis par CIC, confirme puis
traite le paiement. Il distingue succès, échec et annulation, ajoute l'opération à l'historique et
affiche un reçu lorsqu'il est fourni. Aucun moyen de paiement ou secret marchand n'est codé en dur.

## Support

La rubrique contient FAQ, problèmes fréquents, téléphone et coordonnées du support, formulaire mobile
de demande et suivi d'une demande lorsque l'API le permet. Chaque envoi produit une confirmation ou
un message de retry sans perdre les données saisies.
