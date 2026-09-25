import '../domain/dashboard_summary.dart';

class DashboardRepository {
  Future<DashboardSummary> load(String clientNumber, String displayName) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return DashboardSummary(
      clientNumber: clientNumber,
      displayName: displayName,
      subscriptionName: 'DigiCâble Famille',
      expirationDate: DateTime.now().add(const Duration(days: 26)),
      subscriptionStatus: 'Actif',
      operations: const ['Abonnement activé', 'Paiement reçu'],
      notifications: const ['Votre abonnement arrive bientôt à expiration.'],
    );
  }
}
