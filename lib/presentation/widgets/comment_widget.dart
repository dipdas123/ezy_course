import 'package:ezycourse/core/entities/comment.dart';
import 'package:ezycourse/presentation/viewmodels/feed_viewmodel.dart';
import 'package:ezycourse/presentation/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import '../../utils/color_constants.dart';
import '../../utils/size_config.dart';
import '../../utils/string_constants.dart';
import '../../utils/style_utils.dart';

commentWidget(BuildContext context, Comment comment, FeedViewModel provider) {
  return Card(
    color: ColorConfig.whiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0), // Adjust radius as needed
    ),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: CircleAvatar(radius: 20, backgroundImage: NetworkImage(comment.user?.profilePic ?? "")),
              ),

              Flexible(
                child: Container(
                  width: SizeConfig.screenWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    // color: ColorConfig.greyColor.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.user?.fullName ?? "", style: textSize14w700.copyWith(color: ColorConfig.textColorPrimary),),
                      Text(comment.commentTxt ?? "", style: textSize12w500.copyWith(color: ColorConfig.textColorSecondary),),
                    ],
                  ),
                ),
              ),
            ],
          ),

          (comment.replyCount ?? 0) != (-1) ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${comment.replyCount} Replies", style: textSize12w500).paddingOnly(top: 5, right: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    provider.isLoadingCreateReply ? getLoader() : InkWell(
                      onTap: () {
                        SystemChannels.textInput.invokeMethod("TextInput.show");
                        provider.isReplying = true;
                        provider.selectedCommentID = comment.id ?? 0;
                        provider.notify();
                      },
                      child: Row(
                        children: [
                          Text(StringConfig.reply, style: textSize12.copyWith(color: ColorConfig.primaryColor.withOpacity(0.75), fontWeight: FontWeight.w800),),
                          const SizedBox(width: 5,),
                          Icon(Icons.send_rounded, size: 25, color: ColorConfig.primaryColor.withOpacity(0.75)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ) : const SizedBox(),
        ],
      ),
    ),
  );
}