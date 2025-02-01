import 'dart:convert';
import 'package:ezycourse/core/entities/create_comment_or_reply_body.dart';
import 'package:ezycourse/core/entities/create_update_reaction_body.dart';
import 'package:ezycourse/infrastructure/datasources/local/PrefUtils.dart';
import 'package:ezycourse/presentation/screens/auth/login_screen.dart';
import 'package:ezycourse/utils/asset_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:sqflite/sqflite.dart';
import '../../core/entities/CreateFeedBody.dart';
import '../../core/entities/Reply.dart';
import '../../core/entities/comment.dart';
import '../../core/entities/comment_reply_create_response.dart';
import '../../core/entities/create_feed.dart';
import '../../core/entities/create_update_reaction.dart';
import '../../core/entities/feed.dart';
import '../../core/usecases/post_usecases.dart';
import '../../infrastructure/datasources/local/database.dart';
import '../../providers/feed/feed_provider.dart';
import '../../utils/color_constants.dart';
import '../../utils/style_utils.dart';

final feedViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  final feedUseCases = ref.read(feedUseCasesProvider);
  return FeedViewModel(feedUseCases);
});

class FeedViewModel extends ChangeNotifier {
  final FeedUseCases feedUseCases;
  FeedViewModel(this.feedUseCases) {
    getFeed();
    scrollController.addListener(scrollListener);
  }

  DatabaseHelper dbHelper = DatabaseHelper();
  var bottomNavIndex = 0;
  var isLoadingFeeds = false;
  bool isLoadingMoreFeeds = false;
  var isLoadingComment = false;
  var isLoadingCommentReply = false;
  var isLoadingCreateFeed = false;
  var isLoadingCreateUpdateReact = false;
  var isLoadingCreateComment = false;
  var isLoadingCreateReply = false;
  var isLoadingLogout = false;
  var isReplying = false;
  List<Feed?> feedList = [];
  ScrollController scrollController = ScrollController();
  List<Comment> commentList = [];
  List<Reply> replyList = [];
  ValueNotifier<int?> expandedIndex = ValueNotifier<int?>(null);
  Map<String, AssetImage> reactionIcons = {
    "LIKE": AssetImage(AssetConfig.like_icon2),
    "LOVE": AssetImage(AssetConfig.love_react2_icon),
    "CARE": AssetImage(AssetConfig.care_icon),
    "HAHA": AssetImage(AssetConfig.haha_icon),
    "WOW": AssetImage(AssetConfig.wow_icon),
    "SAD": AssetImage(AssetConfig.sad_icon),
    "ANGRY": AssetImage(AssetConfig.angry_icon),
  };
  // Create Post
  var isBgVisible = false;
  final TextEditingController postController = TextEditingController();
  final TextEditingController commentOrReplyController = TextEditingController();
  var selectedGradientBg = const LinearGradient(colors: [ColorConfig.whiteColor, ColorConfig.whiteColor]);
  var selectedBgGradientIndex = -1;
  var selectedGradientJson = "";
  int selectedReactingItemsID = 0;
  int selectedCommentID = 0;
  var commentOrReplyText = "";






  LinearGradient? getGradient(String? bgColor) {
    if (bgColor == null || bgColor.isEmpty) return null;
    // printInfo(info: "bgColor :: ${jsonEncode(bgColor)}");

    try {
      String decodedJson = bgColor;

      // Handle double-escaped JSON
      if (decodedJson.startsWith("\"") && decodedJson.endsWith("\"")) {
        decodedJson = jsonDecode(decodedJson); // Decode once
      }

      final decodedMap = jsonDecode(decodedJson);
      final gradientString = decodedMap["backgroundImage"] as String;

      // Extract RGB colors
      final regex = RegExp(r'rgb\((\d+), (\d+), (\d+)\)');
      final matches = regex.allMatches(gradientString);

      if (matches.length >= 2) {
        final colors = matches.map((match) {
          return Color.fromRGBO(
            int.parse(match.group(1)!),
            int.parse(match.group(2)!),
            int.parse(match.group(3)!),
            1, // Full opacity
          );
        }).toList();

        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        );
      }
    } catch (e) {
      debugPrint("Error parsing gradient: $e");
    }

    return null;
  }

  void getSelectedGradientJsonForBgColor(LinearGradient? selectedGradient) {
    if (selectedGradient == null) return;
    print("Selected JSON: ${GradientColorList.gradientsColor.indexOf(selectedGradient)}");
    print("Selected JSON: ${selectedGradient}");

    int index = GradientColorList.gradientsColor.indexOf(selectedGradient);
    if (index >= 0 && index < GradientColorList.feedBackGroundGradientColors.length) {
      selectedGradientJson = (jsonEncode(GradientColorList.feedBackGroundGradientColors[index]));
      print("Selected JSON: $selectedGradientJson");
      // Use this JSON for background settings
    } else {
      selectedGradientJson = "";
      isBgVisible = false;
      selectedBgGradientIndex = -1;
      selectedGradientBg = const LinearGradient(colors: [ColorConfig.whiteColor, ColorConfig.whiteColor]);
      Get.snackbar("Error!", "Selected gradient does not have a matching JSON.");
    }
    notify();
  }

  void scrollListener() {
    if (scrollController.position.atEdge && scrollController.position.pixels != 0) {
      if (!isLoadingMoreFeeds) {
        getFeed(lastItemId: feedList.isNotEmpty ? feedList.last?.id : null);
      }
    }
  }

  Future<void> getFeed({int? lastItemId, bool? shouldShowLoader = true}) async {
    if (lastItemId == null) {
      shouldShowLoader == true ? isLoadingFeeds = true : isLoadingFeeds = false;
      notifyListeners();
      final response = await feedUseCases.getFeed(lastItemId);
      isLoadingFeeds = false;

      if (response.isNotEmpty) {
        feedList.clear();
        feedList.addAll(response);
        for (var feed in feedList) {
          if (feed != null) {
            await insertFeed(feed);
          }
        }

        printInfo(info: "getFeedsFromSqfLite :: ${await dbHelper.getFeeds()}");
      } else {
        feedList.clear();
      }

    } else {
      isLoadingMoreFeeds = true;
      notifyListeners();
      final response = await feedUseCases.getFeed(lastItemId);

      if (response.isNotEmpty) {
        if (isLoadingMoreFeeds) {
          feedList.addAll(response);
          isLoadingMoreFeeds = false;
        }
      } else {
        isLoadingMoreFeeds = false;
      }
    }

    notifyListeners();
  }

  Future<int> insertFeed(Feed feed) async {
    Database db = await dbHelper.database;
    return await db.insert(
      'Feed',
      {
        'id': feed.id,
        'school_id': feed.schoolId,
        'user_id': feed.userId,
        'course_id': feed.courseId,
        'community_id': feed.communityId,
        'group_id': feed.groupId,
        'feed_txt': feed.feedTxt,
        'status': feed.status,
        'file_type': feed.fileType,
        'like_count': feed.likeCount,
        'comment_count': feed.commentCount,
        'share_count': feed.shareCount,
        'share_id': feed.shareId,
        'feed_privacy': feed.feedPrivacy,
        'is_background': feed.isBackground != null ? 1 : 0,
        'bg_color': feed.bgColor,
        'space_id': feed.spaceId,
        'publish_date': feed.publishDate,
        'name': feed.name,
        'likeType': jsonEncode((feed.likeTypeList ?? []).map((e) => e.toJson()).toList()),
        'follow': feed.follow,
        'like': jsonEncode(feed.like?.toJson()),
        'comments': feed.comments,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Comment>> getComment(int? feedID) async {
    isLoadingComment = true;
    final response = await feedUseCases.getCommentOfAFeed(feedID);
    isLoadingComment = false;

    if (response.isNotEmpty) {
      commentList.clear();
      commentList = response ?? [];
    } else {
      commentList.clear();
    }

    notifyListeners();
    return commentList;
  }

  Future<List<Reply>> getReply(int? commentID) async {
    isLoadingCommentReply = true;
    final response = await feedUseCases.getCommentReplyOfAFeed(commentID);
    isLoadingCommentReply = false;

    if (response.isNotEmpty) {
      replyList.clear();
      replyList = response ?? [];
    } else {
      replyList.clear();
    }

    notifyListeners();
    return replyList;
  }

  Future<CreatePost> createNewFeed() async {
    isLoadingCreateFeed = true;
    var body = CreateFeedBody(
      feedTxt: postController.text, communityId: 2914, spaceId: 5883, uploadType: 'text',
      activityType: 'group', isBackground: 0, bgColor: selectedGradientJson,
    );
    final response = await feedUseCases.createNewFeed(body);
    isLoadingCreateFeed = false;

    if (("${response.id ?? 0}").isNotEmpty) {
      getFeed();
      Get.back();
    } else {
      Get.snackbar("Failed!", "Post creation failed, please try again.");
    }

    notify();
    return response;
  }

  Future<CreateUpdateReaction> reactToPost({required int feedId, required String reactionType}) async {
    isLoadingCreateUpdateReact = true;
    notify();
    var body = CreateUpdateReactionBody(
      feedId: feedId, reactionType: reactionType.toUpperCase(), action: "deleteOrCreate", reactionSource: "COMMUNITY",
    );
    final response = await feedUseCases.createOrUpdateReaction(body);
    isLoadingCreateUpdateReact = false;

    if (response.likeType != null) {
      getFeed(shouldShowLoader: false);
    } else {
      Get.snackbar("Failed!", "Post reacting failed, please try again.");
    }

    notify();
    return response;
  }

  Future<CreateCommentOrReplyResponse> createComment({required int feedId, required int feedUserID}) async {
    isLoadingCreateComment = true;
    notify();
    var body = CreateCommentOrReplyBody(
      feedId: feedId, feedUserId: feedUserID, commentTxt: commentOrReplyController.text, commentSource: "group",
    );
    final response = await feedUseCases.createComment(body);
    isLoadingCreateComment = false;

    if ((response.commentText ?? "").isNotEmpty) {
      getComment(feedId);
      getFeed(shouldShowLoader: false);
      isReplying = false;
      commentOrReplyController.clear();
    } else {
      Get.snackbar("Failed!", "Commenting failed, please try again.");
    }

    notify();
    return response;
  }

  Future<CreateCommentOrReplyResponse> replyComment({required int feedId, required int feedUserID, required int commentParentID}) async {
    isLoadingCreateReply = true;
    notify();
    var body = CreateCommentOrReplyBody(
      feedId: feedId, feedUserId: feedUserID, parentId: commentParentID, commentTxt: commentOrReplyController.text, commentSource: "COMMUNITY",
    );
    final response = await feedUseCases.replyComment(body);
    isLoadingCreateReply = false;

    if ((response.commentText ?? "").isNotEmpty) {
      getComment(feedId);
      getReply(selectedCommentID);
      getFeed(shouldShowLoader: false);
      isReplying = false;
      commentOrReplyController.clear();
      Get.snackbar("Replied", "success");
    } else {
      Get.snackbar("Failed!", "Comment replying failed, please try again.");
    }

    notify();
    return response;
  }

  Future<dynamic> logout() async {
    isLoadingLogout = true;
    notify();

    final response = await feedUseCases.logout();
    isLoadingLogout = false;

    if ((response["msg"] ?? "").isNotEmpty) {
      Get.snackbar("Logout", "${response["msg"] ?? ""}", snackPosition: SnackPosition.BOTTOM, colorText: ColorConfig.whiteColor, backgroundColor: ColorConfig.greenColor);
      PrefUtils.clearSharedPreferences();
      Get.offAll(()=> LoginScreen());
    } else {
      Get.snackbar("Failed!", "Logout failed, please try again.", snackPosition: SnackPosition.BOTTOM, colorText: ColorConfig.whiteColor, backgroundColor: ColorConfig.redColor);
    }

    notify();
    return response;
  }

  void clearCommentField() {
    isReplying = false;
    commentOrReplyController.clear();
    commentOrReplyText = "";
    selectedCommentID = 0;
    notify();
  }

  @override
  void dispose() {
    postController.dispose();
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void notify() {
    notifyListeners();
  }

}