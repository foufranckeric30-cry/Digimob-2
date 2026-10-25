import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';
import '../domain/auth_session.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository());

final authControllerProvider =
    NotifierProvider<AuthController, AsyncValue<AuthSession?>>(
  AuthController.new,
);

class AuthController extends Notifier<AsyncValue<AuthSession?>> {
  @override
  AsyncValue<AuthSession?> build() => const AsyncData(null);

  Future<void> login(String identifier, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).login(identifier, password),
    );
  }

  void logout() => state = const AsyncData(null);
}
