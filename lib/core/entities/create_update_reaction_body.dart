class CreateUpdateReactionBody {
  final int? feedId;
  final String? reactionType;
  final String? action;
  final String? reactionSource;

  CreateUpdateReactionBody({
    this.feedId,
    this.reactionType,
    this.action,
    this.reactionSource,
  });

  // Optional: Add a factory constructor to create an instance from JSON
  factory CreateUpdateReactionBody.fromJson(Map<String, dynamic> json) {
    return CreateUpdateReactionBody(
      feedId: json['feed_id'] as int?,
      reactionType: json['reaction_type'] as String?,
      action: json['action'] as String?,
      reactionSource: json['reactionSource'] as String?,
    );
  }

  // Optional: Add a method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'feed_id': feedId,
      'reaction_type': reactionType,
      'action': action,
      'reactionSource': reactionSource,
    };
  }
}