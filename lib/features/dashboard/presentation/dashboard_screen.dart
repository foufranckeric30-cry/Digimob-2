import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/widgets/screen_states.dart';
import '../../auth/presentation/auth_controller.dart';
import '../domain/dashboard_summary.dart';
import 'dashboard_controller.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authControllerProvider).valueOrNull;
    if (session == null || session.isExpired) {
      return const Scaffold(body: EmptyView(message: 'Utilisateur non connecté.'));
    }
    final dashboard = ref.watch(
      dashboardControllerProvider((
        clientNumber: session.clientNumber,
        displayName: session.displayName,
      )),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        actions: [
          IconButton(
            tooltip: 'Déconnexion',
            onPressed: () {
              ref.read(authControllerProvider.notifier).logout();
              context.go('/');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: dashboard.when(
        loading: () => const LoadingView(),
        error: (error, _) => ErrorView(
          message: 'Impossible de charger votre tableau de bord.',
          onRetry: () => ref.invalidate(
            dashboardControllerProvider((
              clientNumber: session.clientNumber,
              displayName: session.displayName,
            )),
          ),
        ),
        data: (summary) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(
            dashboardControllerProvider((
              clientNumber: session.clientNumber,
              displayName: session.displayName,
            )),
          ),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text('Bonjour, ${summary.displayName}',
                  style: Theme.of(context).textTheme.headlineSmall),
              Text('N° client : ${summary.clientNumber}'),
              const SizedBox(height: 20),
              _SubscriptionCard(summary: summary),
              const SizedBox(height: 16),
              _Section(
                title: 'Actions rapides',
                child: Row(
                  children: [
                    _QuickAction(
                      icon: Icons.subscriptions_outlined,
                      label: 'Abonnement',
                      onTap: () {},
                    ),
                    _QuickAction(
                      icon: Icons.payment_outlined,
                      label: 'Paiement',
                      onTap: () {},
                    ),
                    _QuickAction(
                      icon: Icons.support_agent_outlined,
                      label: 'Support',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _Section(
                title: 'Notifications importantes',
                child: Column(
                  children: summary.notifications
                      .map((item) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.notifications_outlined,
                                color: AppColors.blue),
                            title: Text(item),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              _Section(
                title: 'Dernières opérations',
                child: Column(
                  children: summary.operations
                      .map((item) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.check_circle_outline,
                                color: AppColors.success),
                            title: Text(item),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  const _SubscriptionCard({required this.summary});
  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) => Card(
        color: AppColors.navy,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Abonnement actuel',
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              Text(summary.subscriptionName,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white)),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(summary.subscriptionStatus,
                      style: const TextStyle(color: Colors.greenAccent)),
                  Text(
                    'Expire le ${_date(summary.expirationDate)}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(child: Padding(padding: const EdgeInsets.all(12), child: child)),
        ],
      );
}

class _QuickAction extends StatelessWidget {
  const _QuickAction(
      {required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Expanded(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Icon(icon, color: AppColors.blue),
                const SizedBox(height: 4),
                Text(label, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
}

String _date(DateTime date) => '${date.day.toString().padLeft(2, '0')}/'
    '${date.month.toString().padLeft(2, '0')}/${date.year}';
