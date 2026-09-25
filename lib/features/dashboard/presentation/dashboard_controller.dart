import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/dashboard_repository.dart';
import '../domain/dashboard_summary.dart';

final dashboardRepositoryProvider =
    Provider<DashboardRepository>((ref) => DashboardRepository());

final dashboardControllerProvider = FutureProvider.autoDispose
    .family<DashboardSummary, ({String clientNumber, String displayName})>(
  (ref, account) => ref.read(dashboardRepositoryProvider).load(
        account.clientNumber,
        account.displayName,
      ),
);
