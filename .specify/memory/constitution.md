<!--
Sync Impact Report (temporary; remove before commit)
- Version change: 2.0.0 → 2.1.0
- Bump rationale: MINOR — the existing governance is expanded with explicit requirements for reusable
  mobile components, session lifecycle, device compatibility, and performance.
- Modified principles:
  - I. Expérience utilisateur mobile simple, moderne et accessible → expanded with reusable components
  - III. Sécurité des données et authentification → expanded with session lifecycle requirements
  - V. Flutter, Dart et qualité de livraison → expanded with performance and device compatibility
- Added sections: none; the existing constraint and workflow sections were substantially revised.
- Removed sections: none.
- Follow-up TODOs: RATIFICATION_DATE reste à confirmer; la date d’adoption originale n’est pas
  enregistrée dans le dépôt.
-->

# DigiCâble — Côte d’Ivoire Câbles (CIC) Constitution

## Core Principles

### I. Expérience utilisateur mobile simple, moderne et accessible

L’expérience utilisateur est la priorité du projet. Chaque parcours principal MUST permettre à un client
de comprendre rapidement son compte et les services de télévision numérique disponibles, puis
d’accomplir la tâche attendue avec le minimum de friction. Les écrans MUST utiliser une hiérarchie
claire, des libellés compréhensibles, une terminologie métier validée et des composants visuels cohérents.

Chaque écran et chaque parcours MUST prévoir des états de chargement, de succès, d’absence de données,
d’erreur et d’indisponibilité réseau. Les actions principales MUST rester faciles à découvrir et les
libellés français MUST être privilégiés pour les clients de CIC.

L’interface MUST satisfaire les besoins d’accessibilité mobile : contrastes lisibles, tailles de texte
ajustables, cibles tactiles adaptées, libellés sémantiques et navigation utilisable avec les technologies
d’assistance. Les choix d’interface et les parcours principaux MUST être validés avec des clients
représentatifs et associés à des critères mesurables de réussite.

Les composants visuels, formulaires, états de chargement, messages et éléments de navigation communs
MUST être réutilisables et cohérents entre les fonctionnalités. Les mises en page MUST s’adapter aux
tailles d’écran et densités représentatives des smartphones Android d’entrée, de milieu et de haut de
gamme.

**Justification:** Une application de services de télévision doit être comprise rapidement, y compris par
des clients qui utilisent un téléphone pour la première fois ou qui ont des besoins d’accessibilité.

### II. Architecture propre, maintenable et documentée

Le code MUST être organisé par responsabilité claire et par fonctionnalité, en séparant au minimum
l’interface utilisateur, les règles métier, l’accès aux données et l’intégration au backend. Les règles
métier et les décisions de sécurité MUST NOT être dispersées dans les widgets ou les écrans.

Les modules, interfaces, dépendances et flux principaux MUST être documentés. Les changements de
comportement ou de contrat MUST mettre à jour la documentation technique, les exemples d’utilisation
et les hypothèses associées. La duplication, la dépendance inutile et la complexité non justifiée MUST
être supprimées ou documentées lors de la revue.

Chaque décision structurante MUST être explicable, réversible lorsque possible et compatible avec la
maintenance par une équipe qui ne participe pas à son élaboration.

**Justification:** Une architecture claire réduit les régressions, facilite les contributions et permet
d’adapter l’application aux évolutions des services de CIC sans rendre le code inutilisable.

### III. Sécurité des données et authentification

L’authentification MUST protéger l’accès aux données du compte, aux abonnements et aux services de
télévision numérique. Elle MUST couvrir la connexion, la déconnexion, la restauration et l’expiration
de session. Les mots de passe, jetons, identifiants secrets et données sensibles MUST NOT être écrits
dans le code, les journaux, les messages d’erreur ou la documentation publique.

Les sessions MUST avoir une durée de vie contrôlée, une déconnexion effective et une expiration
sûre après une inactivité définie. Les communications réseau MUST utiliser des transports sécurisés,
et le stockage local MUST être limité aux informations strictement nécessaires à l’authentification et
aux préférences non sensibles.

Le code MUST appliquer le principe du moindre privilège, minimiser les données collectées et éviter de
révéler l’existence d’un compte ou des informations sensibles dans les réponses d’erreur. Toute
évolution du stockage, des permissions ou du traitement des données MUST être évaluée pour son impact
sur la confidentialité et la vie privée.

**Justification:** Les clients confient des informations de compte et de services à CIC; la sécurité est une
condition de confiance et de conformité, pas une option de performance.

### IV. Communication avec l’API et le backend

Toutes les données provenant du backend MUST être consommées au moyen de contrats d’API documentés,
versionnés selon les besoins du projet. Le client mobile MUST NOT contenir de secrets, de logique
métier côté serveur ni de dépendance à des détails internes non documentés du backend.

L’intégration MUST définir explicitement les états de chargement, de succès, de données absentes,
d’erreur, de délai dépassé et d’indisponibilité réseau. Les erreurs techniques MUST être transformées
en messages compréhensibles pour l’utilisateur, sans exposer de détails internes ni empêcher la
possibilité de réessai lorsque l’action est possible.

Les changements de contrat, de format, de statut ou d’authentification MUST être documentés et vérifiés
par des tests de contrat ou d’intégration avant d’être déployés. Les données affichées MUST pouvoir être
rattachées à leur source et à leur moment de rafraîchissement lorsque cette information est pertinente.

**Justification:** Une frontière stable avec le backend protège l’application mobile des changements
internes de CIC et permet de fournir des parcours fiables malgré les retards ou indisponibilités réseau.

### V. Flutter, Dart et qualité de livraison

L’application MUST être développée avec Flutter et Dart et MUST prendre Android en charge comme
plateforme de référence. Le code MUST suivre les recommandations des versions stables supportées de
Flutter et de Dart, ainsi que les règles de formatage, d’analyse statique et de gestion des dépendances
applicables.

Les règles métier, les transformations de données et les comportements de sécurité critiques MUST
disposer de tests automatisés adaptés. Les parcours Android essentiels MUST être validés sur des
appareils et tailles d’écran représentatifs, avec une attention particulière à la compatibilité, à
l’accessibilité et aux défaillances réseau.

Chaque livraison MUST passer par l’analyse statique, les tests, la revue de code, la vérification des
dépendances et la mise à jour de la documentation. Une dette technique ou une exception MUST être
visible, priorisée et assortie d’un plan de correction.

Les écrans et appels réseau MUST éviter les traitements et reconstructions inutiles. Les images MUST
être dimensionnées et mises en cache de façon appropriée, et les appels réseau MUST être limités,
annulables ou réessayables selon le parcours. Les performances MUST être vérifiées sur au moins un
appareil Android représentatif de chaque niveau de gamme ciblé.

**Justification:** Flutter et Dart permettent une base mobile cohérente, tandis que des contrôles de qualité
reproductibles protègent la stabilité, la sécurité et l’évolutivité de l’application.

## Contraintes de livraison et périmètre

- La plateforme de référence est Android; toute cible supplémentaire MUST faire l’objet d’une décision
  de gouvernance explicite.
- Le périmètre produit porte sur la consultation et la gestion des services de télévision numérique
  destinés aux clients de Côte d’Ivoire Câbles. Les opérations précises MUST être précisées dans la
  spécification de chaque fonctionnalité.
- Le backend de CIC reste la source de vérité pour les données du compte, des abonnements et des
  services; l’application MUST refléter cet état au lieu d’inventer des données non confirmées.
- L’interface est conçue pour le français, avec des libellés validés pour le contexte de CIC.
- Les fonctionnalités MUST exposer explicitement leurs états de chargement, de réussite, d’erreur et
  d’absence de données; les parcours sensibles MUST rester compréhensibles en cas de réseau instable.
- Les secrets de production MUST être fournis par des mécanismes de configuration sécurisés et ne
  MUST NOT être versionnés dans le dépôt.
- Les fonctions hors du parcours client, les paiements non explicitement spécifiés et les capacités
  réservées aux administrateurs de CIC MUST être exclues tant qu’une spécification approuvée ne les
  définit pas.

## Processus de développement et qualité

- Chaque fonctionnalité MUST suivre le cycle de spécification, de planification, de découpage des
  tâches et d’implémentation défini par Spec Kit.
- Un contrôle de conformité à la constitution MUST être effectué avant la conception et réexaminé après
  la conception. Toute exception MUST être documentée avec sa justification, son risque et son plan de
  correction.
- Les tâches MUST identifier les responsabilités, les dépendances, les scénarios utilisateur et les
  résultats de validation attendus.
- Les user stories MUST définir des critères d’acceptation indépendants et des critères mesurables pour
  chaque parcours principal.
- Les tests MUST couvrir les règles métier, les composants, les contrats API et les scénarios Android
  critiques. Les tests end-to-end ou manuels MUST compléter les tests automatisés lorsque le comportement
  dépend de l’intégration, de l’appareil ou du réseau.
- Les revues de code MUST vérifier l’architecture, la sécurité, l’accessibilité, la gestion des
  erreurs, la qualité de la documentation et la compatibilité Android.
- Toute modification de la constitution MUST mettre à jour le rapport d’impact, justifier le bump de
  version et faire l’objet d’une revue avant merge.

## Governance

Cette constitution est la source de vérité pour la gouvernance, la qualité et les règles techniques
du projet DigiCâble. En cas de conflit, elle prévaut sur les pratiques non approuvées; toute exception
doit être explicite, limitée dans le temps, documentée et approuvée par la personne responsable du
projet.

Les amendements sont proposés avec leur justification, leur impact sur les principes existants et un
plan de migration si nécessaire. Les versions suivent Semantic Versioning : MAJOR pour une
redéfinition rétro-incompatible d’une règle, d’une technologie, d’une plateforme ou du périmètre; MINOR
pour un principe ou une section ajoutée ou une expansion significative; PATCH pour une clarification non
sémantique. La date d’adoption originale reste à confirmer.

Le respect de la constitution est vérifié dans les plans, les revues de code et les validations avant
livraison. Toute non-conformité MUST être bloquante jusqu’à correction ou approbation explicite avec
une justification et une échéance.

**Version**: 2.1.0 | **Ratified**: TODO(RATIFICATION_DATE): date d’adoption originale non enregistrée | **Last Amended**: 2026-09-24
