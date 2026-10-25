
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/domain/auth_session.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../coordinator/presentation/coordinator_screen.dart';
import '../../technician/presentation/technician_screen.dart';
import 'dashboard_screen.dart';

class RoleDashboardScreen extends ConsumerWidget {
  const RoleDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return authState.when(
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Erreur de connexion : $error'),
          ),
        ),
      ),
      data: (session) {
        if (session == null || session.isExpired) {
          return const _AccessDeniedScreen();
        }

        switch (session.role) {
          case UserRole.client:
            return const DashboardScreen();

          case UserRole.technicien:
            return const TechnicianScreen();

          case UserRole.coordinatrice:
            return const CoordinatorScreen();
        }
      },
    );
  }
}

class _AccessDeniedScreen extends ConsumerWidget {
  const _AccessDeniedScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accès sécurisé'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 56,
              ),
              const SizedBox(height: 16),
              const Text(
                'Accès refusé',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Votre session est absente ou expirée. '
                'Veuillez vous reconnecter.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).logout();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Déconnexion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
