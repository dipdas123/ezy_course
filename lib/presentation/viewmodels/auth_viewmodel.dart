import 'package:ezycourse/presentation/screens/feed/feed_screen.dart';
import 'package:ezycourse/utils/PrefUtils.dart';
import 'package:ezycourse/utils/extensions/string_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import '../../core/usecases/auth_usecases.dart';
import '../../providers/auth/auth_provider.dart';

final authViewModelProvider = StateNotifierProvider.autoDispose<AuthViewModel, AsyncValue<String?>>((ref) {
  final authUseCases = ref.read(authUseCasesProvider);
  return AuthViewModel(authUseCases);
});

class AuthViewModel extends StateNotifier<AsyncValue<String?>> {
  final AuthUseCases authUseCases;
  AuthViewModel(this.authUseCases) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final response = await authUseCases.login(email, password);
    if (response != null) {
      PrefUtils.storeEmail(email);
      PrefUtils.storePassword(password);
      PrefUtils.storeToken("${(response.type ?? "").capitalizeFirst} ${response.token}" ?? ""); // Getting As: Bearer Token
      state = AsyncValue.data(response.token ?? "");
      Get.offAll(()=> const FeedScreen());
    } else {
      state = AsyncValue.error('Login failed!!', StackTrace.current);
    }
  }
}