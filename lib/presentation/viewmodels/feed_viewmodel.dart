import 'dart:convert';
import 'package:ezycourse/core/entities/create_update_reaction_body.dart';
import 'package:ezycourse/utils/asset_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import '../../core/entities/CreateFeedBody.dart';
import '../../core/entities/Reply.dart';
import '../../core/entities/comment.dart';
import '../../core/entities/create_feed.dart';
import '../../core/entities/create_update_reaction.dart';
import '../../core/entities/feed.dart';
import '../../core/usecases/post_usecases.dart';
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
    scrollController.addListener(scrollListener);
  }
  var isLoadingFeeds = false;
  bool isLoadingMoreFeeds = false;
  var isLoadingComment = false;
  var isLoadingCommentReply = false;
  var isLoadingCreateFeed = false;
  var isLoadingCreateUpdateReact = false;
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
  var selectedGradientBg = const LinearGradient(colors: [ColorConfig.whiteColor, ColorConfig.whiteColor]);
  var selectedBgGradientIndex = -1;
  var selectedGradientJson = "";
  int selectedReactingItemsID = 0;




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

  Future<void> getFeed({int? lastItemId, bool? shouldShowLoader}) async {
    if (lastItemId == null) {
      shouldShowLoader == true ? isLoadingFeeds = true : isLoadingFeeds = false;
      notifyListeners();
      final response = await feedUseCases.getFeed(lastItemId);
      isLoadingFeeds = false;

      if (response.isNotEmpty) {
        feedList.clear();
        feedList.addAll(response);
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