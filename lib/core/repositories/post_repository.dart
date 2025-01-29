import '../entities/feed.dart';

abstract class FeedRepository {
  Future<List<Feed?>> getFeed();
}
