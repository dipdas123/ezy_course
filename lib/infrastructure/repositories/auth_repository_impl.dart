import 'package:dio/dio.dart';
import 'package:ezycourse/core/entities/user.dart';
import 'package:ezycourse/infrastructure/datasources/remote/api_endpoints.dart';
import '../../core/repositories/auth_repository.dart';
import '../datasources/remote/api_client.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;
  AuthRepositoryImpl(this.apiClient);

  @override
  Future<User?> login(String email, String password) async {
    try {
      final response = await apiClient.postRequest(
        endpoint: loginUrl,
        data: {
          'email': email,
          'password': password,
          'app_token': '',
        },
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');

        if (e.response?.data is Map<String, dynamic>) {
          final errorMap = e.response?.data as Map<String, dynamic>;
          throw Exception(errorMap.toString());
        }
      }
      print('Login error: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
    return null;
  }
}