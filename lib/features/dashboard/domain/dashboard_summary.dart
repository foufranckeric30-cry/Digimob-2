class DashboardSummary {
  const DashboardSummary({
    required this.clientNumber,
    required this.displayName,
    required this.subscriptionName,
    required this.expirationDate,
    required this.subscriptionStatus,
    required this.operations,
    required this.notifications,
  });

  final String clientNumber;
  final String displayName;
  final String subscriptionName;
  final DateTime expirationDate;
  final String subscriptionStatus;
  final List<String> operations;
  final List<String> notifications;
}
