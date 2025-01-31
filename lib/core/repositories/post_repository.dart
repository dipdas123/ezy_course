import 'package:ezycourse/core/entities/CreateFeedBody.dart';
import 'package:ezycourse/core/entities/comment.dart';
import '../entities/Reply.dart';
import '../entities/create_feed.dart';
import '../entities/create_update_reaction.dart';
import '../entities/create_update_reaction_body.dart';
import '../entities/feed.dart';

abstract class FeedRepository {
  Future<List<Feed?>> getFeed(int? lastItemId);
  Future<List<Comment>> getCommentOfAFeed(int? feedID);
  Future<List<Reply>> getCommentReplyOfAFeed(int? commentID);
  Future<CreatePost> createPost(CreateFeedBody body);
  Future<CreateUpdateReaction> createOrUpdateReaction(CreateUpdateReactionBody body);
}
