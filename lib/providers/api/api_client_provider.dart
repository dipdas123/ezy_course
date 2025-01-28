import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/datasources/remote/api_client.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.read(dioProvider);
  return ApiClient(dio);
});