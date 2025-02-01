class Feed {
  final int? id;
  final int? schoolId;
  final int? userId;
  final int? courseId;
  final int? communityId;
  final int? groupId;
  final String? feedTxt;
  final String? status;
  final String? slug;
  final String? title;
  final String? activityType;
  final int? isPinned;
  final String? fileType;
  final List<File>? files;
  final int? likeCount;
  final int? commentCount;
  final int? shareCount;
  final int? shareId;
  final Map<String, dynamic>? metaData;
  final String? createdAt;
  final String? updatedAt;
  final String? feedPrivacy;
  final int? isBackground;
  final String? bgColor;
  final int? pollId;
  final int? lessonId;
  final int? spaceId;
  final int? videoId;
  final int? streamId;
  final int? blogId;
  final String? scheduleDate;
  final String? timezone;
  final int? isAnonymous;
  final int? meetingId;
  final int? sellerId;
  final String? publishDate;
  final bool? isFeedEdit;
  final String? name;
  final String? pic;
  final int? uid;
  final int? isPrivateChat;
  final dynamic poll;
  final dynamic group;
  final User? user;
  final List<LikeType>? likeTypeList;
  final dynamic follow;
  final dynamic savedPosts;
  final Like? like;
  final List<dynamic>? comments;
  final Meta? meta;

  Feed({
    this.id,
    this.schoolId,
    this.userId,
    this.courseId,
    this.communityId,
    this.groupId,
    this.feedTxt,
    this.status,
    this.slug,
    this.title,
    this.activityType,
    this.isPinned,
    this.fileType,
    this.files,
    this.likeCount,
    this.commentCount,
    this.shareCount,
    this.shareId,
    this.metaData,
    this.createdAt,
    this.updatedAt,
    this.feedPrivacy,
    this.isBackground,
    this.bgColor,
    this.pollId,
    this.lessonId,
    this.spaceId,
    this.videoId,
    this.streamId,
    this.blogId,
    this.scheduleDate,
    this.timezone,
    this.isAnonymous,
    this.meetingId,
    this.sellerId,
    this.publishDate,
    this.isFeedEdit,
    this.name,
    this.pic,
    this.uid,
    this.isPrivateChat,
    this.poll,
    this.group,
    this.user,
    this.likeTypeList,
    this.follow,
    this.savedPosts,
    this.like,
    this.comments,
    this.meta,
  });

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
    id: json['id'] as int?,
    schoolId: json['school_id'] as int?,
    userId: json['user_id'] as int?,
    courseId: json['course_id'] as int?,
    communityId: json['community_id'] as int?,
    groupId: json['group_id'] as int?,
    feedTxt: json['feed_txt'] as String?,
    status: json['status'] as String?,
    slug: json['slug'] as String?,
    title: json['title'] as String?,
    activityType: json['activity_type'] as String?,
    isPinned: json['is_pinned'] as int?,
    fileType: json['file_type'] as String?,
    files: json['files'] != null
        ? (json['files'] as List).map((e) => File.fromJson(e)).toList()
        : null,
    likeCount: json['like_count'] as int?,
    commentCount: json['comment_count'] as int?,
    shareCount: json['share_count'] as int?,
    shareId: json['share_id'] as int?,
    metaData: json['meta_data'] as Map<String, dynamic>?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    feedPrivacy: json['feed_privacy'] as String?,
    isBackground: json['is_background'] as int?,
    bgColor: json['bg_color'] as String?,
    pollId: json['poll_id'] as int?,
    lessonId: json['lesson_id'] as int?,
    spaceId: json['space_id'] as int?,
    videoId: json['video_id'] as int?,
    streamId: json['stream_id'] as int?,
    blogId: json['blog_id'] as int?,
    scheduleDate: json['schedule_date'] as String?,
    timezone: json['timezone'] as String?,
    isAnonymous: json['is_anonymous'] as int?,
    meetingId: json['meeting_id'] as int?,
    sellerId: json['seller_id'] as int?,
    publishDate: json['publish_date'] as String?,
    isFeedEdit: json['is_feed_edit'] as bool?,
    name: json['name'] as String?,
    pic: json['pic'] as String?,
    uid: json['uid'] as int?,
    isPrivateChat: json['is_private_chat'] as int?,
    poll: json['poll'],
    group: json['group'],
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    likeTypeList: (json['likeType'] as List<dynamic>?)
        ?.map((e) => LikeType.fromJson(e as Map<String, dynamic>))
        .toList(),
    follow: json['follow'],
    savedPosts: json['savedPosts'],
    like: json['like'] == null
        ? null
        : Like.fromJson(json['like'] as Map<String, dynamic>),
    comments: json['comments'] as List<dynamic>?,
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'school_id': schoolId,
    'user_id': userId,
    'course_id': courseId,
    'community_id': communityId,
    'group_id': groupId,
    'feed_txt': feedTxt,
    'status': status,
    'slug': slug,
    'title': title,
    'activity_type': activityType,
    'is_pinned': isPinned,
    'file_type': fileType,
    'files': files?.map((e) => e.toJson()).toList(),
    'like_count': likeCount,
    'comment_count': commentCount,
    'share_count': shareCount,
    'share_id': shareId,
    'meta_data': metaData,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'feed_privacy': feedPrivacy,
    'is_background': isBackground,
    'bg_color': bgColor,
    'poll_id': pollId,
    'lesson_id': lessonId,
    'space_id': spaceId,
    'video_id': videoId,
    'stream_id': streamId,
    'blog_id': blogId,
    'schedule_date': scheduleDate,
    'timezone': timezone,
    'is_anonymous': isAnonymous,
    'meeting_id': meetingId,
    'seller_id': sellerId,
    'publish_date': publishDate,
    'is_feed_edit': isFeedEdit,
    'name': name,
    'pic': pic,
    'uid': uid,
    'is_private_chat': isPrivateChat,
    'poll': poll,
    'group': group,
    'user': user?.toJson(),
    'likeType': likeTypeList?.map((e) => e.toJson()).toList(),
    'follow': follow,
    'savedPosts': savedPosts,
    'like': like?.toJson(),
    'comments': comments,
    'meta': meta?.toJson(),
  };
}

class User {
  final int? id;
  final String? fullName;
  final String? profilePic;
  final int? isPrivateChat;
  final String? expireDate;
  final String? status;
  final String? pauseDate;
  final String? userType;
  final Map<String, dynamic>? meta;

  User({
    this.id,
    this.fullName,
    this.profilePic,
    this.isPrivateChat,
    this.expireDate,
    this.status,
    this.pauseDate,
    this.userType,
    this.meta,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int?,
    fullName: json['full_name'] as String?,
    profilePic: json['profile_pic'] as String?,
    isPrivateChat: json['is_private_chat'] as int?,
    expireDate: json['expire_date'] as String?,
    status: json['status'] as String?,
    pauseDate: json['pause_date'] as String?,
    userType: json['user_type'] as String?,
    meta: json['meta'] as Map<String, dynamic>?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    'profile_pic': profilePic,
    'is_private_chat': isPrivateChat,
    'expire_date': expireDate,
    'status': status,
    'pause_date': pauseDate,
    'user_type': userType,
    'meta': meta,
  };
}

class LikeType {
  final String? reactionType;
  final int? feedId;
  final Map<String, dynamic>? meta;

  LikeType({
    this.reactionType,
    this.feedId,
    this.meta,
  });

  factory LikeType.fromJson(Map<String, dynamic> json) => LikeType(
    reactionType: json['reaction_type'] as String?,
    feedId: json['feed_id'] as int?,
    meta: json['meta'] as Map<String, dynamic>?,
  );

  Map<String, dynamic> toJson() => {
    'reaction_type': reactionType,
    'feed_id': feedId,
    'meta': meta,
  };
}

class Like {
  final int? id;
  final int? feedId;
  final int? userId;
  final String? reactionType;
  final String? createdAt;
  final String? updatedAt;
  final int? isAnonymous;
  final Map<String, dynamic>? meta;

  Like({
    this.id,
    this.feedId,
    this.userId,
    this.reactionType,
    this.createdAt,
    this.updatedAt,
    this.isAnonymous,
    this.meta,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
    id: json['id'] as int?,
    feedId: json['feed_id'] as int?,
    userId: json['user_id'] as int?,
    reactionType: json['reaction_type'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    isAnonymous: json['is_anonymous'] as int?,
    meta: json['meta'] as Map<String, dynamic>?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'feed_id': feedId,
    'user_id': userId,
    'reaction_type': reactionType,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'is_anonymous': isAnonymous,
    'meta': meta,
  };
}

class Meta {
  final int? views;

  Meta({
    this.views,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    views: json['views'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'views': views,
  };
}

class File {
  final String? fileLoc;
  final String? originalName;
  final String? extname;
  final String? type;
  final int? size;

  File({
    this.fileLoc,
    this.originalName,
    this.extname,
    this.type,
    this.size,
  });

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      fileLoc: json['fileLoc'] as String?,
      originalName: json['originalName'] as String?,
      extname: json['extname'] as String?,
      type: json['type'] as String?,
      size: json['size'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileLoc': fileLoc,
      'originalName': originalName,
      'extname': extname,
      'type': type,
      'size': size,
    };
  }
}
