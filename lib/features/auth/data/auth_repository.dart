import '../domain/auth_session.dart';

class AuthRepository {
  Future<AuthSession> login(
    String identifier,
    String password,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 650),
    );

    final normalizedIdentifier = identifier.trim().toLowerCase();

    const demoUsers = <String, Map<String, String>>{
      'client001': {
        'password': 'demo1234',
        'name': 'Client de démonstration',
        'role': 'client',
      },
      'tech001': {
        'password': 'demo1234',
        'name': 'Technicien de démonstration',
        'role': 'technicien',
      },
      'coord001': {
        'password': 'demo1234',
        'name': 'Coordinatrice de démonstration',
        'role': 'coordinatrice',
      },
    };

    final user = demoUsers[normalizedIdentifier];

    if (user == null || user['password'] != password) {
      throw const FormatException(
        'Identifiant ou mot de passe incorrect.',
      );
    }

    final role = switch (user['role']) {
      'technicien' => UserRole.technicien,
      'coordinatrice' => UserRole.coordinatrice,
      _ => UserRole.client,
    };

    return AuthSession(
      clientNumber: normalizedIdentifier.toUpperCase(),
      displayName: user['name']!,
      role: role,
      expiresAt: DateTime.now().add(
        const Duration(hours: 2),
      ),
    );
  }
}