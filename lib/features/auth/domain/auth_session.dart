enum UserRole {
  client,
  technicien,
  coordinatrice,
 admin,
}

class AuthSession {
  const AuthSession({
    required this.clientNumber,
    required this.displayName,
    required this.role,
    required this.expiresAt,
  });

  final String clientNumber;
  final String displayName;
  final UserRole role;
  final DateTime expiresAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
