import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/repositories/post_repository.dart';
import '../../core/usecases/post_usecases.dart';
import '../../infrastructure/repositories/post_repository_impl.dart';
import '../api/api_client_provider.dart';

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return FeedRepositoryImpl(apiClient);
});

final feedUseCasesProvider = Provider<FeedUseCases>((ref) {
  final feedRepository = ref.read(feedRepositoryProvider);
  return FeedUseCases(feedRepository);
});