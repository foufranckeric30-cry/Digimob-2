class AuthSession {
  const AuthSession({
    required this.clientNumber,
    required this.displayName,
    required this.expiresAt,
  });

  final String clientNumber;
  final String displayName;
  final DateTime expiresAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
