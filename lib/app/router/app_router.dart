
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/dashboard/presentation/role_dashboard_screen.dart';

class AppRouter {
  static const String initialRoute = '/';

  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const RoleDashboardScreen(),
      ),
    ],
  );
}
