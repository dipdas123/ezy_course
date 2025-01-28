import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/repositories/auth_repository.dart';
import '../../core/usecases/auth_usecases.dart';
import '../../infrastructure/repositories/auth_repository_impl.dart';
import '../api/api_client_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return AuthRepositoryImpl(apiClient);
});

final authUseCasesProvider = Provider<AuthUseCases>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthUseCases(authRepository);
});