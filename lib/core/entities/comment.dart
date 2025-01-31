import 'dart:convert';

class Comment {
  final int? id;
  final int? schoolId;
  final int? feedId;
  final int? userId;
  final int? replyCount;
  final int? likeCount;
  final String? commentTxt;
  final int? parentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? file;
  final int? privateUserId;
  final int? isAuthorAndAnonymous;
  final String? gift;
  final int? sellerId;
  final int? giftedCoins;
  final List<dynamic>? replies;
  final User? user;
  final dynamic privateUser;
  final List<dynamic>? reactionTypes;
  final List<dynamic>? totalLikes;
  final dynamic commentlike;

  Comment({
    this.id,
    this.schoolId,
    this.feedId,
    this.userId,
    this.replyCount,
    this.likeCount,
    this.commentTxt,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.file,
    this.privateUserId,
    this.isAuthorAndAnonymous,
    this.gift,
    this.sellerId,
    this.giftedCoins,
    this.replies,
    this.user,
    this.privateUser,
    this.reactionTypes,
    this.totalLikes,
    this.commentlike,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      schoolId: json['school_id'],
      feedId: json['feed_id'],
      userId: json['user_id'],
      replyCount: json['reply_count'],
      likeCount: json['like_count'],
      commentTxt: json['comment_txt'],
      parentId: json['parrent_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      file: json['file'],
      privateUserId: json['private_user_id'],
      isAuthorAndAnonymous: json['is_author_and_anonymous'],
      gift: json['gift'],
      sellerId: json['seller_id'],
      giftedCoins: json['gifted_coins'],
      replies: json['replies'] != null ? List<dynamic>.from(json['replies']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      privateUser: json['private_user'],
      reactionTypes: json['reaction_types'] != null ? List<dynamic>.from(json['reaction_types']) : null,
      totalLikes: json['totalLikes'] != null ? List<dynamic>.from(json['totalLikes']) : null,
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
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'file': file,
      'private_user_id': privateUserId,
      'is_author_and_anonymous': isAuthorAndAnonymous,
      'gift': gift,
      'seller_id': sellerId,
      'gifted_coins': giftedCoins,
      'replies': replies,
      'user': user?.toJson(),
      'private_user': privateUser,
      'reaction_types': reactionTypes,
      'totalLikes': totalLikes,
      'commentlike': commentlike,
    };
  }
}

class User {
  final int? id;
  final String? fullName;
  final String? profilePic;
  final String? userType;
  final Map<String, dynamic>? meta;

  User({
    this.id,
    this.fullName,
    this.profilePic,
    this.userType,
    this.meta,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      profilePic: json['profile_pic'],
      userType: json['user_type'],
      meta: json['meta'] != null ? Map<String, dynamic>.from(json['meta']) : null,
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
