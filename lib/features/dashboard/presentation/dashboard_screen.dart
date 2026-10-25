
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/widgets/screen_states.dart';
import '../../auth/presentation/auth_controller.dart';
import '../domain/dashboard_summary.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authControllerProvider).valueOrNull;

    if (session == null || session.isExpired) {
      return Scaffold(
        appBar: AppBar(title: const Text('DigiCâble')),
        body: const EmptyView(
          message: 'Utilisateur non connecté.',
        ),
      );
    }

    final account = (
      clientNumber: session.clientNumber,
      displayName: session.displayName,
    );

    final dashboard = ref.watch(
      dashboardControllerProvider(account),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('DigiCâble'),
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
        error: (error, stackTrace) => ErrorView(
          message: 'Impossible de charger votre tableau de bord.',
          onRetry: () {
            ref.invalidate(dashboardControllerProvider(account));
          },
        ),
        data: (summary) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(dashboardControllerProvider(account));
          },
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Bonjour, ${summary.displayName}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text('N° client : ${summary.clientNumber}'),
              const SizedBox(height: 20),

              // Informations sur l'abonnement.
              _SubscriptionCard(summary: summary),

              const SizedBox(height: 16),

              // Suivi de l'installation.
              _Section(
                title: 'Suivi de mon installation',
                child: Column(
                  children: [
                    _InfoTile(
                      icon: Icons.engineering_outlined,
                      title: 'Statut de l’installation',
                      value: summary.installationStatus,
                    ),
                    _InfoTile(
                      icon: Icons.location_on_outlined,
                      title: 'Adresse d’installation',
                      value: summary.installationAddress,
                    ),
                    _InfoTile(
                      icon: Icons.support_agent_outlined,
                      title: 'Technicien affecté',
                      value: summary.technicianName,
                    ),
                    _InfoTile(
                      icon: Icons.phone_outlined,
                      title: 'Contact du technicien',
                      value: summary.technicianPhone,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Actions rapides.
              _Section(
                title: 'Actions rapides',
                child: Row(
                  children: [
                    _QuickAction(
                      icon: Icons.subscriptions_outlined,
                      label: 'Abonnement',
                      onTap: () {
                        _showMessage(
                          context,
                          'Consultez les informations de votre abonnement ci-dessus.',
                        );
                      },
                    ),
                    _QuickAction(
                      icon: Icons.payment_outlined,
                      label: 'Paiement',
                      onTap: () {
                        _showMessage(
                          context,
                          'Le service de paiement sera ajouté ultérieurement.',
                        );
                      },
                    ),
                    _QuickAction(
                      icon: Icons.support_agent_outlined,
                      label: 'Support',
                      onTap: () {
                        _showMessage(
                          context,
                          'Le service de support sera ajouté ultérieurement.',
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Notifications.
              _Section(
                title: 'Notifications importantes',
                child: summary.notifications.isEmpty
                    ? const Text('Aucune notification pour le moment.')
                    : Column(
                        children: summary.notifications
                            .map(
                              (item) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(
                                  Icons.notifications_outlined,
                                  color: AppColors.blue,
                                ),
                                title: Text(item),
                              ),
                            )
                            .toList(),
                      ),
              ),

              const SizedBox(height: 16),

              // Historique des opérations.
              _Section(
                title: 'Dernières opérations',
                child: summary.operations.isEmpty
                    ? const Text('Aucune opération récente.')
                    : Column(
                        children: summary.operations
                            .map(
                              (item) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(
                                  Icons.check_circle_outline,
                                  color: AppColors.success,
                                ),
                                title: Text(item),
                              ),
                            )
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
  Widget build(BuildContext context) {
    final isActive =
        summary.subscriptionStatus.toLowerCase() == 'actif';

    return Card(
      color: AppColors.navy,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Abonnement actuel',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              summary.subscriptionName,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    summary.subscriptionStatus,
                    style: TextStyle(
                      color: isActive
                          ? Colors.greenAccent
                          : Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Expire le ${_formatDate(summary.expirationDate)}',
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.blue),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: child,
          ),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 4,
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.blue),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

String _formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');

  return '$day/$month/${date.year}';
}
