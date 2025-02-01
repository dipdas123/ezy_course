import 'package:ezycourse/core/entities/feed.dart';
import 'package:ezycourse/presentation/viewmodels/feed_viewmodel.dart';
import 'package:ezycourse/presentation/widgets/comment_bottom_sheet_widget.dart';
import 'package:ezycourse/presentation/widgets/reaction_counter_widget.dart';
import 'package:ezycourse/utils/asset_constants.dart';
import 'package:ezycourse/utils/color_constants.dart';
import 'package:ezycourse/utils/extensions/date_extension.dart';
import 'package:ezycourse/utils/size_config.dart';
import 'package:ezycourse/utils/string_constants.dart';
import 'package:ezycourse/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'ReactionDragger.dart';
import 'common_widgets.dart';

class PostCardWidget extends ConsumerStatefulWidget {
  const PostCardWidget({super.key});

  @override
  ConsumerState createState() => _PostCardWidget();
}

class _PostCardWidget extends ConsumerState<PostCardWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      var provider = ref.watch(feedViewModelProvider);

      return ListView.builder(
        controller: provider.scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: provider.feedList.length + (ref.watch(feedViewModelProvider.notifier).isLoadingMoreFeeds ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == provider.feedList.length) {
            // Loading more data indicator
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: getLoader(),
            );
          }
          var feed = provider.feedList[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: ColorConfig.feedsBGColor,
                borderRadius: BorderRadius.circular(8)
            ),
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
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    gradient: (feed?.bgColor ?? "").isNotEmpty ? ref.watch(feedViewModelProvider.notifier).getGradient(feed?.bgColor) : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: (feed?.bgColor ?? "").isNotEmpty
                      ?
                  SizedBox(
                    height: SizeConfig.screenHeight! / 4.5,
                    width: double.infinity,
                    child: GestureDetector(
                      onLongPress: () {
                        Clipboard.setData(ClipboardData(text: feed?.feedTxt ?? ""));
                        Get.snackbar("Copied", "Post text copied.", snackPosition: SnackPosition.BOTTOM);
                      },
                      child: LayoutBuilder(
                          builder: (context, constraints) {

                            bool isOverflowing = isTextOverflowing(
                              feed?.feedTxt ?? "",
                              constraints.maxWidth,
                              constraints.maxHeight,
                              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            );

                            return isOverflowing
                                ?
                            SingleChildScrollView(
                              child: Center(child: Text(feed?.feedTxt ?? "No content available", style: textSize16w500, textAlign: TextAlign.center,),
                              ),
                            )
                                :
                            Center(
                              child: Text(feed?.feedTxt ?? "No content available", style: textSize16w500, textAlign: TextAlign.center),
                            );
                          }),
                    ),
                  )
                      :
                  Text(feed?.feedTxt ?? ""),
                )
                    :
                Column(
                  children: [
                    Text(feed?.feedTxt ?? "", style: textSize16w500,),

                    const SizedBox(height: 5,),
                    (feed?.files ?? []).isNotEmpty ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: SizeConfig.screenHeight! / 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network((feed?.files ?? []).isNotEmpty ? (feed?.files?[0].fileLoc ?? "") : "", fit: BoxFit.contain,),
                        ),
                      ],
                    ) : const SizedBox(),
                  ],
                ),

                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    reactionCounterWidget(context, feed, provider),

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

                const Divider(thickness: 0.5,).marginOnly(top: 5),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ((provider.isLoadingCreateUpdateReact)  && (provider.selectedReactingItemsID == feed?.id)) ? getLoader()
                        :
                    SizedBox(
                      width: SizeConfig.screenWidth! / 1.7,
                      child: ReactionButton(
                        feed: feed,
                        isReacted: feed?.likeTypeList?.any((like) => like.feedId == feed.id) ?? false,
                        onReactionSelected: (reaction) {
                          var getReactedType = "";
                          var sameReaction = false;
                          var isAlreadyReacted = feed?.likeTypeList?.any((like) {
                            getReactedType = like.reactionType ?? "";
                            sameReaction = (like.reactionType ?? "" == feed.like?.reactionType ?? "") == true ? true : false;
                            return like.feedId == feed.id;
                          });

                          provider.selectedReactingItemsID = feed?.id ?? 0;
                          if (isAlreadyReacted == true) {
                            printInfo(info: "onReactionSelected :: getReactedType: $getReactedType");
                            sameReaction
                                ?
                            ref.watch(feedViewModelProvider.notifier).reactToPost(feedId: feed?.id ?? 0, reactionType: getReactedType)
                                :
                            ref.watch(feedViewModelProvider.notifier).reactToPost(feedId: feed?.id ?? 0, reactionType: reaction.name);
                          } else {
                            printInfo(info: "onReactionSelected :: Reaction selected: ${reaction.name}");
                            ref.watch(feedViewModelProvider.notifier).reactToPost(feedId: feed?.id ?? 0, reactionType: reaction.name);
                          }
                        },
                      ),
                    ),

                    // Expanded(
                    //   child: SizedBox(
                    //     height: getProportionateScreenHeight(500),
                    //     width: SizeConfig.screenWidth! / 1.5,
                    //     child: const FbReactionBox(),
                    //   ),
                    // ),

                    provider.isLoadingComment == true ? Center(child: getLoader()) :
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: ColorConfig.primaryColor,
                        onTap: () async {
                          ref.read(feedViewModelProvider.notifier).getComment(feed?.id);
                          provider.notify();
                          openCommentBottomSheet(context, feed, provider);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Image.asset(height: getProportionateScreenHeight(22), width: getProportionateScreenWidth(22), AssetConfig.comment_icon_filled),
                              ),

                              Text(StringConfig.comment,
                                style: const TextStyle(fontSize: 14, color: ColorConfig.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 0.5,).marginOnly(top: 5),

              ],
            ),
          );
        },

      );
    }
    );
  }

  openCommentBottomSheet(BuildContext context, Feed? feed, FeedViewModel provider) {
    provider.commentOrReplyController.clear();
    provider.isReplying = false;
    provider.notify();
    return CommentBottomSheetWidget().showSheet(context, feed, provider);
  }

  bool _isBottom(WidgetRef ref) {
    final scrollController = ScrollController();
    return scrollController.position.atEdge && scrollController.position.pixels != 0;
  }

}