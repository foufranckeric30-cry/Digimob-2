import '../domain/auth_session.dart';

class AuthRepository {
  Future<AuthSession> login(String identifier, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
    if (identifier.trim().isEmpty || password.isEmpty) {
      throw const FormatException('Identifiants requis');
    }
    if (password != 'demo1234') {
      throw const FormatException('Identifiants invalides');
    }
    return AuthSession(
      clientNumber: identifier.trim().toUpperCase(),
      displayName: 'Client DigiCâble',
      expiresAt: DateTime.now().add(const Duration(hours: 2)),
    );
  }
}
