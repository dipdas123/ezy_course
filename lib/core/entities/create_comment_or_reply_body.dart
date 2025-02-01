class CreateCommentOrReplyBody {
  int? feedId;
  int? feedUserId;
  String? commentTxt;
  String? commentSource;
  int? parentId; // Added parent_id field

  CreateCommentOrReplyBody({
    this.feedId,
    this.feedUserId,
    this.commentTxt,
    this.commentSource,
    this.parentId, // Added parentId to the constructor
  });

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'feed_id': feedId,
      'feed_user_id': feedUserId,
      'comment_txt': commentTxt,
      'commentSource': commentSource,
      'parrent_id': parentId, // Added parent_id to JSON
    };
  }

  // Create an object from a JSON map
  factory CreateCommentOrReplyBody.fromJson(Map<String, dynamic> json) {
    return CreateCommentOrReplyBody(
      feedId: json['feed_id'],
      feedUserId: json['feed_user_id'],
      commentTxt: json['comment_txt'],
      commentSource: json['commentSource'],
      parentId: json['parrent_id'], // Added parentId from JSON
    );
  }
}