
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../../auth/presentation/auth_controller.dart';
import '../data/technician_repository.dart';
import '../domain/technician_intervention.dart';

final technicianRepositoryProvider =
    Provider<TechnicianRepository>((ref) => TechnicianRepository());

final technicianInterventionsProvider =
    FutureProvider.autoDispose<List<TechnicianIntervention>>(
  (ref) => ref.read(technicianRepositoryProvider).loadInterventions(),
);

class TechnicianScreen extends ConsumerWidget {
  const TechnicianScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authControllerProvider).valueOrNull;

    if (session == null || session.isExpired) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Retour à la connexion'),
          ),
        ),
      );
    }

    final interventions = ref.watch(technicianInterventionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Espace Technicien'),
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
      body: interventions.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Impossible de charger les interventions.'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () =>
                    ref.invalidate(technicianInterventionsProvider),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
        data: (items) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(technicianInterventionsProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Bienvenue, ${session.displayName}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text('${items.length} interventions de démonstration'),
              const SizedBox(height: 16),
              if (items.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('Aucune intervention attribuée.'),
                  ),
                ),
              ...items.map(
                (item) => _InterventionCard(intervention: item),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InterventionCard extends StatelessWidget {
  const _InterventionCard({required this.intervention});

  final TechnicianIntervention intervention;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.assignment_outlined,
                  color: AppColors.blue,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    intervention.id,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                _StatusLabel(status: intervention.status),
              ],
            ),
            const Divider(height: 24),
            Text(
              intervention.clientName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _DetailRow(
              icon: Icons.badge_outlined,
              text: 'Client : ${intervention.clientNumber}',
            ),
            _DetailRow(
              icon: Icons.location_on_outlined,
              text: intervention.address,
            ),
            _DetailRow(
              icon: Icons.phone_outlined,
              text: intervention.phone,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(intervention.id),
                      content: Text(
                        'Client : ${intervention.clientName}\n'
                        'Numéro : ${intervention.clientNumber}\n'
                        'Adresse : ${intervention.address}\n'
                        'Téléphone : ${intervention.phone}\n'
                        'Statut : ${intervention.status}',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Fermer'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Voir le dossier'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusLabel extends StatelessWidget {
  const _StatusLabel({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      'Terminée' => AppColors.success,
      'En cours' => AppColors.blue,
      _ => Colors.orange.shade800,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.blue),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
