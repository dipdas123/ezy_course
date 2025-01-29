import 'package:ezycourse/core/entities/feed.dart';
import 'package:ezycourse/presentation/viewmodels/feed_viewmodel.dart';
import 'package:ezycourse/utils/asset_constants.dart';
import 'package:ezycourse/utils/color_constants.dart';
import 'package:ezycourse/utils/extensions/date_extension.dart';
import 'package:ezycourse/utils/size_config.dart';
import 'package:ezycourse/utils/string_constants.dart';
import 'package:ezycourse/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'ReactionDragger.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      var provider = ref.watch(feedViewModelProvider);

      return ListView.builder(
        itemCount: provider.feedList.length,
        itemBuilder: (context, index) {
          var feed = provider.feedList[index];

          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        (feed?.user?.profilePic ?? "").isEmpty
                            ?
                        Image.asset(AssetConfig.user_icon_rounded)
                            :
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(feed?.user?.profilePic ?? ""),
                        ),

                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(feed?.user?.fullName ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(DateTime.parse(feed?.publishDate ?? "").timeAgo ?? "", style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),

                    InkWell(
                      onTap: () {
                        Get.snackbar("Coming", "Coming soon...", snackPosition: SnackPosition.BOTTOM);
                      },
                      child: Image.asset(AssetConfig.three_dot_icon,
                        height: getProportionateScreenHeight(25),
                        width: getProportionateScreenWidth(25),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Divider(thickness: 0.4, color: ColorConfig.greyColor,),
                ),

                const SizedBox(height: 5),
                feed?.fileType == "text"
                    ?
                Container(
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    gradient: (feed?.bgColor ?? "").isNotEmpty ? provider.getGradientForBgColor(feed?.bgColor ?? "") : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: (feed?.bgColor ?? "").isNotEmpty
                      ?
                  SizedBox(
                    height: SizeConfig.screenHeight! / 4.5,
                    child: Center(child: Text(feed?.feedTxt ?? "", style: textSize16w500,)),
                  )
                      :
                  Text(feed?.feedTxt ?? ""),
                )
                    :
                Column(
                  children: [
                    Text(feed?.feedTxt ?? "", style: textSize16w500,),

                    Container(
                      height: SizeConfig.screenHeight! / 5,
                      width: SizeConfig.screenWidth! / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Image.network(feed?.pic ?? "", fit: BoxFit.contain,),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                          for (var reaction in (feed?.likeType ?? []).map((e) => e.reactionType).toSet().take(2))
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

                    Row(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Image.asset(height: getProportionateScreenHeight(15), width: getProportionateScreenWidth(15), AssetConfig.comment_icon),
                            ),

                            Text(feed?.commentCount == 0 ? StringConfig.noCommentsYet : "${feed?.commentCount ?? 0} ${StringConfig.comments}",
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        const SizedBox(width: 5,),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 3.0, left: 3.0),
                              child: Icon(Icons.share, size: 15,),
                            ),
                            Text(feed?.shareCount == 0 ? StringConfig.noSharesYet : "${feed?.shareCount ?? 0} ${StringConfig.shares}",
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReactionButton(
                      isReacted: feed?.likeType?.any((like) => like.feedId == feed.id) ?? false,
                      onReactionSelected: (reaction) {
                        // Handle reaction selection here
                        // provider.reactToPost(
                        //   feedId: feed?.id ?? "",
                        //   reactionType: reaction.id,
                        // );
                      },
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Image.asset(height: getProportionateScreenHeight(22), width: getProportionateScreenWidth(22), AssetConfig.comment_icon_filled),
                        ),

                        Text(StringConfig.comment,
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          );
        },

      );
    }
    );
  }
}