import 'package:ezycourse/core/entities/comment.dart';
import 'package:ezycourse/core/entities/feed.dart';
import 'package:ezycourse/presentation/viewmodels/feed_viewmodel.dart';
import 'package:ezycourse/presentation/widgets/common_widgets.dart';
import 'package:ezycourse/presentation/widgets/reaction_counter_widget.dart';
import 'package:ezycourse/presentation/widgets/reply_widget.dart';
import 'package:ezycourse/utils/color_constants.dart';
import 'package:ezycourse/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../utils/asset_constants.dart';
import '../../utils/size_config.dart';
import '../../utils/string_constants.dart';
import 'comment_widget.dart';
import 'custom_textfield.dart';

class CommentBottomSheetWidget {
  showSheet(BuildContext context, Feed? feed, FeedViewModel provider) {
    printInfo(info: "CommentList :: ${provider.commentList}");

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      backgroundColor: ColorConfig.backgroundColorPrimary,
      constraints: BoxConstraints(
        maxHeight: SizeConfig.screenHeight! / 1.1,
      ),
      builder: (BuildContext context) {
        return Consumer(
            builder: (context, WidgetRef ref, Widget? child) {
              var provider = ref.watch(feedViewModelProvider);

              return DraggableScrollableSheet(
                initialChildSize: 1.0,
                minChildSize: 0.25,
                maxChildSize: 1.0,
                expand: false,
                shouldCloseOnMinExtent: true,
                builder: (BuildContext context, ScrollController scrollController) {
                  return Scaffold(
                    backgroundColor: ColorConfig.backgroundColorPrimary,
                    resizeToAvoidBottomInset: true,
                    body: Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: Stack(
                        children: [
                          ListView(
                            controller: scrollController,
                            padding: const EdgeInsets.only(bottom: 100),
                            physics: const BouncingScrollPhysics(),
                            children: [
                              reactionCounterWidget(context, feed, provider),
                              const SizedBox(height: 20),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: ExpansionPanelList.radio(
                                  expandIconColor: ColorConfig.greyColor,
                                  animationDuration: const Duration(microseconds: 500),
                                  expandedHeaderPadding: EdgeInsets.zero,
                                  dividerColor: Colors.transparent,
                                  materialGapSize: 0,
                                  expansionCallback: (index, isExpanded) async {
                                    Comment comment = provider.commentList[index];
                                    provider.selectedCommentID = comment.id ?? 0;
                                    if ((comment.replyCount ?? 0) >= 0) {
                                      if (isExpanded) {
                                        provider.getReply(provider.selectedCommentID);
                                      }
                                    } else {
                                      provider.replyList.clear();
                                    }
                                    provider.notify();
                                  },
                                  children: provider.commentList.map<ExpansionPanelRadio>((Comment comment) {
                                    return ExpansionPanelRadio(
                                      backgroundColor: ColorConfig.backgroundColorPrimary,
                                      splashColor: ColorConfig.greyColor,
                                      value: comment.id ?? 0,
                                      canTapOnHeader: true,
                                      headerBuilder: (BuildContext context, bool isExpanded) {
                                        return commentWidget(context, comment, provider);
                                      },
                                      body: provider.isLoadingCommentReply
                                          ? Center(child: Container(margin: const EdgeInsets.all(10), child: getLoader()))
                                          : provider.replyList.isEmpty
                                          ? Text(StringConfig.noRepliesYet)
                                          : Column(
                                        children: provider.replyList.map((reply) {
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: replyWidget(context, reply, provider),
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),

                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: ColorConfig.backgroundColorPrimary,
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  provider.isLoadingCreateReply ? getLoader() : Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                      width: SizeConfig.screenWidth,
                                      child: CustomTextField(
                                        controller: provider.commentOrReplyController,
                                        borderColor: ColorConfig.whiteColor,
                                        hintText: provider.isReplying ? StringConfig.reply : StringConfig.comment,
                                        maxLines: null,
                                        suffixOnTap: () {
                                          provider.clearCommentField();
                                          provider.notify();
                                        },
                                        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                                        fillColor: ColorConfig.greyColor.withOpacity(0.25),
                                        autoValidateMode: AutovalidateMode.onUserInteraction,
                                        style: const TextStyle(color: ColorConfig.textColorPrimary),
                                        hintStyle: const TextStyle(color: ColorConfig.greyColor),
                                        onChanged: (value) {},
                                        validator: (value) {
                                          if ((value ?? "").isEmpty) {
                                            return "Enter your comment";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),

                                  provider.isLoadingCreateComment ? getLoader() : Flexible(
                                    flex: 0,
                                    child: InkWell(
                                      onTap: () {
                                        if (!provider.isReplying) {
                                          if (provider.commentOrReplyController.text.isNotEmpty) {
                                            provider.createComment(feedId: feed?.id ?? 0, feedUserID: feed?.userId ?? 0);
                                            provider.notify();
                                          } else {
                                            Get.snackbar("Error!", "Please write some comment first.", backgroundColor: ColorConfig.redColor, colorText: ColorConfig.whiteColor);
                                          }
                                        }else {
                                          if (provider.commentOrReplyController.text.isNotEmpty) {
                                            provider.replyComment(feedId: feed?.id ?? 0, feedUserID: feed?.userId ?? 0, commentParentID: provider.selectedCommentID);
                                            provider.notify();
                                          } else {
                                            Get.snackbar("Error!", "Please write some reply first.", backgroundColor: ColorConfig.redColor, colorText: ColorConfig.whiteColor);
                                          }
                                        }
                                        SystemChannels.textInput.invokeMethod("TextInput.hide");
                                      },
                                      child: Container(
                                        height: getProportionateScreenHeight(47),
                                        width: getProportionateScreenWidth(47),
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: ColorConfig.primaryColor,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Image.asset(AssetConfig.comment_send_icon),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            });
      },
    );
  }
}
