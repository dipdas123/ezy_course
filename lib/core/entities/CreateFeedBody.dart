import 'dart:convert';

class CreateFeedBody {
  final String feedTxt;
  final int communityId;
  final int spaceId;
  final String uploadType;
  final String activityType;
  final int isBackground;
  final String? bgColor;

  CreateFeedBody({
    required this.feedTxt,
    required this.communityId,
    required this.spaceId,
    required this.uploadType,
    required this.activityType,
    required this.isBackground,
    this.bgColor,
  });

  Map<String, dynamic> toJson() {
    return {
      "feed_txt": feedTxt,
      "community_id": communityId,
      "space_id": spaceId,
      "uploadType": uploadType,
      "activity_type": activityType,
      "is_background": isBackground,
      "bg_color": bgColor,
    };
  }

  factory CreateFeedBody.fromJson(Map<String, dynamic> json) {
    return CreateFeedBody(
      feedTxt: json["feed_txt"],
      communityId: json["community_id"],
      spaceId: json["space_id"],
      uploadType: json["uploadType"],
      activityType: json["activity_type"],
      isBackground: json["is_background"],
      bgColor: json["bg_color"],
    );
  }
}
