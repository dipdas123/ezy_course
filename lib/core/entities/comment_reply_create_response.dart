class CreateCommentOrReplyResponse {
  String? commentText;

  CreateCommentOrReplyResponse({
    this.commentText,
  });

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'comment_txt': commentText,
    };
  }

  // Create an object from a JSON map
  factory CreateCommentOrReplyResponse.fromJson(Map<String, dynamic> json) {
    return CreateCommentOrReplyResponse(
      commentText: json['comment_txt'],
    );
  }
}