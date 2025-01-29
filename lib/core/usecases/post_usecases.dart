import 'package:ezycourse/core/entities/user.dart';
import '../entities/feed.dart';
import '../repositories/post_repository.dart';

class FeedUseCases {
  final FeedRepository feedRepository;

  FeedUseCases(this.feedRepository);

  Future<List<Feed?>> getFeed() {
    return feedRepository.getFeed();
  }
}