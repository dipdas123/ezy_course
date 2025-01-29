import 'package:ezycourse/presentation/screens/feed/feed_screen.dart';
import 'package:ezycourse/utils/asset_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
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
  var isLoading = false;
  List<Feed?> feedList = [];
  FeedViewModel(this.feedUseCases) : super();

  Future<void> getFeed() async {
    isLoading = true;
    final response = await feedUseCases.getFeed();
    isLoading = false;

    if (response.isNotEmpty) {
      feedList.clear();
      feedList = response ?? [];
    } else {
      feedList.clear();
    }

    notifyListeners();
  }

  LinearGradient getGradientForBgColor(String? bgColorJson) {
    if (bgColorJson == null || bgColorJson.isEmpty) {
      return const LinearGradient(colors: [ColorConfig.whiteColor, ColorConfig.whiteColor]);
    }
    int index = GradientColorList.feedBackGroundGradientColors.indexWhere((element) => element == bgColorJson);
    if (index != -1 && index < GradientColorList.gradientsColor.length) {
      return GradientColorList.gradientsColor[index];
    }
    return const LinearGradient(colors: [ColorConfig.whiteColor, ColorConfig.whiteColor]);
  }

  Map<String, AssetImage> reactionIcons = {
    "LIKE": AssetImage(AssetConfig.like_icon2),
    "LOVE": AssetImage(AssetConfig.love_react2_icon),
    "CARE": AssetImage(AssetConfig.care_icon),
    "HAHA": AssetImage(AssetConfig.haha_icon),
    "WOW": AssetImage(AssetConfig.wow_icon),
    "SAD": AssetImage(AssetConfig.sad_icon),
    "ANGRY": AssetImage(AssetConfig.angry_icon),
  };
}