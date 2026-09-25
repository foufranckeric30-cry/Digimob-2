# Research: Application mobile portail DigiCâbles

## Decision: Application cross-platform Android/iOS

**Decision**: Développer une application mobile cross-platform avec TypeScript et React Native/Expo.

**Rationale**: Le besoin cible Android et iOS avec des parcours identiques pour les abonnés. Une base commune réduit l’effort de livraison initiale, accélère les itérations UI et facilite les tests partagés pour le MVP.

**Alternatives considered**:
- Applications natives séparées Android/iOS : meilleur contrôle plateforme mais coût initial plus élevé.
- WebView du portail existant : rapide mais expérience mobile limitée, dépendance forte au HTML existant et faible contrôle des erreurs.
- PWA : plus simple à déployer mais moins adaptée à une présence mobile app complète et au stockage sécurisé de session.

## Decision: Couche Backend-for-Mobile entre l’application et le portail

**Decision**: Créer une couche d’intégration BFF qui dialogue avec le portail DigiCâbles existant et expose des contrats mobiles stables.

**Rationale**: Le portail visible est une application web avec formulaire de connexion. L’application mobile ne doit pas dépendre directement de la structure HTML, des cookies ou des changements de pages. Le BFF centralise l’authentification, la normalisation des données, la sécurité et les messages d’erreur.

**Alternatives considered**:
- Appeler directement le portail depuis le mobile : fragile, expose trop de détails au client et complique la sécurité.
- Remplacer immédiatement le portail par une nouvelle API métier : plus robuste à long terme mais trop large pour le MVP.
- Intégrer uniquement une WebView : acceptable pour dépannage temporaire mais insuffisant pour les critères d’expérience utilisateur.

## Decision: Stockage local minimal et sécurisé

**Decision**: Stocker localement uniquement les éléments nécessaires à la session et aux préférences non sensibles ; ne pas stocker durablement les factures, paiements ou données personnelles.

**Rationale**: Les informations abonné sont sensibles. La première version priorise la sécurité, réduit les risques en cas de perte du téléphone et simplifie la conformité.

**Alternatives considered**:
- Cache local complet des données : meilleure expérience hors ligne mais risque accru de fuite de données.
- Aucun stockage local : sécurité maximale mais UX moins bonne pour maintenir une session contrôlée.

## Decision: Gestion explicite des états d’erreur et de session

**Decision**: Définir des états standardisés : identifiants invalides, compte bloqué/suspendu, session expirée, réseau indisponible, portail indisponible, données partielles.

**Rationale**: Les critères de succès exigent que les erreurs soient comprises sans aide externe. Une taxonomie d’erreurs commune permet d’afficher des messages français cohérents et testables.

**Alternatives considered**:
- Afficher les erreurs techniques brutes : rapide mais incompréhensible pour les abonnés.
- Message générique unique : simple mais ne guide pas l’utilisateur vers l’action correcte.

## Decision: MVP sans paiement mobile natif

**Decision**: La première version permet la consultation de factures, paiements et solde, mais n’inclut pas de paiement mobile natif sauf si le portail existant fournit déjà un parcours validé à réutiliser.

**Rationale**: Le paiement ajoute des contraintes fortes de sécurité, conformité et support. La spécification demande le suivi financier, pas explicitement le paiement.

**Alternatives considered**:
- Paiement intégré dès v1 : valeur élevée mais complexité et risques importants.
- Aucun module facturation : trop faible par rapport à la valeur attendue du portail abonné.
