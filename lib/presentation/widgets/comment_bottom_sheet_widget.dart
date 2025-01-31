import 'package:ezycourse/core/entities/comment.dart';
import 'package:ezycourse/core/entities/feed.dart';
import 'package:ezycourse/presentation/viewmodels/feed_viewmodel.dart';
import 'package:ezycourse/presentation/widgets/common_widgets.dart';
import 'package:ezycourse/presentation/widgets/reaction_counter_widget.dart';
import 'package:ezycourse/presentation/widgets/reply_widget.dart';
import 'package:ezycourse/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../utils/asset_constants.dart';
import '../../utils/size_config.dart';
import '../../utils/string_constants.dart';
import 'comment_widget.dart';

class CommentBottomSheetWidget {
  showSheet(BuildContext context, Feed? feed, FeedViewModel provider) {
    printInfo(info: "CommentList :: ${provider.commentList}");

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorConfig.backgroundColorPrimary,
      builder: (BuildContext context) {

        return Consumer(
            builder: (context, WidgetRef ref, Widget? child) {
              var provider = ref.watch(feedViewModelProvider);

              return Container(
                height: SizeConfig.screenHeight! /1.1,
                padding: const EdgeInsets.all(16),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [

                    reactionCounterWidget(context, feed, provider),

                    const SizedBox(height: 20,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ExpansionPanelList.radio(
                        expandIconColor: ColorConfig.greyColor,
                        animationDuration: const Duration(microseconds: 500),
                        // initialOpenPanelValue: 1,
                        expandedHeaderPadding: EdgeInsets.zero,
                        dividerColor: Colors.transparent,
                        materialGapSize: 0,
                        expansionCallback: (index, isExpanded) async {
                          Comment comment = provider.commentList[index];
                          if ((comment.replyCount ?? 0) >= 0) {
                            if (isExpanded) {
                              ref.read(feedViewModelProvider.notifier).getReply(comment.id);
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

                              return commentWidget(context, comment);
                            },
                            body: provider.isLoadingCommentReply ? Center(child: Container(margin: const EdgeInsets.all(10), child: getLoader()))
                                : provider.replyList.isEmpty ? Text(StringConfig.noRepliesYet)
                                : Column(
                              children: provider.replyList.map((reply) {

                                return replyWidget(context, reply);
                              }).toList(),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                  ],
                ),
              );
            }
        );
      },
    );
  }
}