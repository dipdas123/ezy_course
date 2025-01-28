import 'package:ezycourse/core/entities/user.dart';
import '../repositories/auth_repository.dart';

class AuthUseCases {
  final AuthRepository authRepository;

  AuthUseCases(this.authRepository);

  Future<User?> login(String email, String password) {
    return authRepository.login(email, password);
  }
}