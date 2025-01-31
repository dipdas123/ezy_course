import 'dart:convert';

class Reply {
  final int id;
  final int schoolId;
  final int feedId;
  final int userId;
  final int replyCount;
  final int likeCount;
  final String commentTxt;
  final int parentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? file;
  final int? privateUserId;
  final int isAuthorAndAnonymous;
  final String? gift;
  final int? sellerId;
  final int? giftedCoins;
  final List<dynamic> replies;
  final User user;
  final List<dynamic> totalLikes;
  final List<dynamic> reactionTypes;
  final dynamic commentlike;

  Reply({
    required this.id,
    required this.schoolId,
    required this.feedId,
    required this.userId,
    required this.replyCount,
    required this.likeCount,
    required this.commentTxt,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
    this.file,
    this.privateUserId,
    required this.isAuthorAndAnonymous,
    this.gift,
    this.sellerId,
    this.giftedCoins,
    required this.replies,
    required this.user,
    required this.totalLikes,
    required this.reactionTypes,
    this.commentlike,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      id: json['id'],
      schoolId: json['school_id'],
      feedId: json['feed_id'],
      userId: json['user_id'],
      replyCount: json['reply_count'],
      likeCount: json['like_count'],
      commentTxt: json['comment_txt'],
      parentId: json['parrent_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      file: json['file'],
      privateUserId: json['private_user_id'],
      isAuthorAndAnonymous: json['is_author_and_anonymous'],
      gift: json['gift'],
      sellerId: json['seller_id'],
      giftedCoins: json['gifted_coins'],
      replies: List<dynamic>.from(json['replies']),
      user: User.fromJson(json['user']),
      totalLikes: List<dynamic>.from(json['totalLikes']),
      reactionTypes: List<dynamic>.from(json['reaction_types']),
      commentlike: json['commentlike'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'feed_id': feedId,
      'user_id': userId,
      'reply_count': replyCount,
      'like_count': likeCount,
      'comment_txt': commentTxt,
      'parrent_id': parentId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'file': file,
      'private_user_id': privateUserId,
      'is_author_and_anonymous': isAuthorAndAnonymous,
      'gift': gift,
      'seller_id': sellerId,
      'gifted_coins': giftedCoins,
      'replies': replies,
      'user': user.toJson(),
      'totalLikes': totalLikes,
      'reaction_types': reactionTypes,
      'commentlike': commentlike,
    };
  }
}

class User {
  final int id;
  final String fullName;
  final String profilePic;
  final String userType;
  final Map<String, dynamic> meta;

  User({
    required this.id,
    required this.fullName,
    required this.profilePic,
    required this.userType,
    required this.meta,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      profilePic: json['profile_pic'],
      userType: json['user_type'],
      meta: Map<String, dynamic>.from(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'profile_pic': profilePic,
      'user_type': userType,
      'meta': meta,
    };
  }
}
