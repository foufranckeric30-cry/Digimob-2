# Contrats de navigation mobile

- `/splash` décide entre `/onboarding`, `/login` et `/dashboard`.
- `/onboarding` mène à `/login` et reste skippable après validation locale.
- `/login` mène à `/forgot-password`, `/register` si le backend l'expose, ou `/dashboard`.
- Toute route privée redirige vers `/login` en cas de session absente, expirée ou révoquée.
- `/dashboard` donne accès à profil, abonnements, offres, renouvellement, paiements, historique,
  notifications, support et paramètres.
- Une mutation réussie affiche une confirmation puis invalide les données concernées.
- Une perte réseau conserve l'écran et les dernières données non sensibles, désactive les mutations
  et affiche une action de reconnexion.
