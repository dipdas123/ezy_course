import 'package:ezycourse/core/entities/feed.dart';
import 'package:ezycourse/presentation/viewmodels/feed_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../utils/asset_constants.dart';
import '../../utils/size_config.dart';
import '../../utils/string_constants.dart';

reactionCounterWidget(BuildContext context, Feed? feed, FeedViewModel provider) {
  return Column(
    children: [
      const SizedBox(height: 10,),
      Row(
        children: [
          for (var reaction in (feed?.likeTypeList ?? []).map((e) => e.reactionType).toSet().take(2))
            Container(
              width: getProportionateScreenWidth(16),
              height: getProportionateScreenHeight(16),
              padding: const EdgeInsets.only(right: 5.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: provider.reactionIcons[reaction] ?? AssetImage(AssetConfig.like_icon2),
                    fit: BoxFit.contain,
                  )
              ),
            ),

          const SizedBox(width: 5),
          Text(feed?.likeCount == 0 ? StringConfig.noReactionsYet : "${feed?.likeCount ?? 0}",
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    ],
  );
}