class DashboardSummary {
  const DashboardSummary({
    required this.clientNumber,
    required this.displayName,
    required this.subscriptionName,
    required this.expirationDate,
    required this.subscriptionStatus,
    required this.operations,
    required this.notifications,
    required this.installationStatus,
    required this.installationAddress,
    required this.technicianName,
    required this.technicianPhone,
  });

  final String clientNumber;
  final String displayName;
  final String subscriptionName;
  final DateTime expirationDate;
  final String subscriptionStatus;
  final List<String> operations;
  final List<String> notifications;
  final String installationStatus;
  final String installationAddress;
  final String technicianName;
  final String technicianPhone;
}
