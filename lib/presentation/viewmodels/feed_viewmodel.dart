import 'package:ezycourse/presentation/screens/feed/feed_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import '../../core/entities/feed.dart';
import '../../core/usecases/post_usecases.dart';
import '../../providers/feed/feed_provider.dart';

final feedViewModelProvider = StateNotifierProvider.autoDispose<FeedViewModel, AsyncValue<List<Feed?>>>((ref) {
  final feedUseCases = ref.read(feedUseCasesProvider);
  return FeedViewModel(feedUseCases);
});

class FeedViewModel extends StateNotifier<AsyncValue<List<Feed?>>> {
  final FeedUseCases feedUseCases;
  List<Feed?> feedList = [];
  FeedViewModel(this.feedUseCases) : super(const AsyncValue.loading()) {
    getFeed();
  }

  Future<void> getFeed() async {
    state = const AsyncValue.loading();
    final response = await feedUseCases.getFeed();
    if (response.isNotEmpty) {
      feedList = response ?? [];
      state = AsyncValue.data(response ?? []);
    } else {
      state = AsyncValue.error('Feed fetching failed!!', StackTrace.current);
    }
  }
}