class AppFailure implements Exception {
  const AppFailure(this.code, this.message);

  final String code;
  final String message;

  factory AppFailure.fromCode(String code) {
    return switch (code) {
      'UNAUTHORIZED' => const AppFailure(
          'UNAUTHORIZED',
          'Votre session a expiré. Veuillez vous reconnecter.',
        ),
      'INVALID_CREDENTIALS' => const AppFailure(
          'INVALID_CREDENTIALS',
          'Identifiant ou mot de passe incorrect.',
        ),
      'UNAVAILABLE' => const AppFailure(
          'UNAVAILABLE',
          'Le service est momentanément indisponible.',
        ),
      _ => const AppFailure('UNKNOWN', 'Une erreur est survenue. Réessayez.'),
    };
  }
}
