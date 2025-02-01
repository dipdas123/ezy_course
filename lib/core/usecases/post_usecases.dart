import 'package:ezycourse/core/entities/CreateFeedBody.dart';
import 'package:ezycourse/core/entities/create_update_reaction.dart';

import '../entities/Reply.dart';
import '../entities/comment.dart';
import '../entities/comment_reply_create_response.dart';
import '../entities/create_comment_or_reply_body.dart';
import '../entities/create_feed.dart';
import '../entities/create_update_reaction_body.dart';
import '../entities/feed.dart';
import '../repositories/post_repository.dart';

class FeedUseCases {
  final FeedRepository feedRepository;

  FeedUseCases(this.feedRepository);

  Future<List<Feed?>> getFeed(int? lastItemId) {
    return feedRepository.getFeed(lastItemId);
  }

  Future<List<Comment>> getCommentOfAFeed(int? feedID) {
    return feedRepository.getCommentOfAFeed(feedID);
  }

  Future<List<Reply>> getCommentReplyOfAFeed(int? commentID) {
    return feedRepository.getCommentReplyOfAFeed(commentID);
  }

  Future<CreatePost> createNewFeed(CreateFeedBody body) {
    return feedRepository.createPost(body);
  }

  Future<CreateUpdateReaction> createOrUpdateReaction(CreateUpdateReactionBody body) {
    return feedRepository.createOrUpdateReaction(body);
  }

  Future<CreateCommentOrReplyResponse> createComment(CreateCommentOrReplyBody body) {
    return feedRepository.createComment(body);
  }

  Future<CreateCommentOrReplyResponse> replyComment(CreateCommentOrReplyBody body) {
    return feedRepository.replyComment(body);
  }

  Future<dynamic> logout() {
    return feedRepository.logout();
  }
}