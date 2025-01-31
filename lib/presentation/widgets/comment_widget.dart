import 'package:ezycourse/core/entities/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import '../../utils/color_constants.dart';
import '../../utils/size_config.dart';
import '../../utils/style_utils.dart';

commentWidget(BuildContext context, Comment comment) {
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

          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("${comment.replyCount} Replies", style: textSize12w500).paddingOnly(top: 5, right: 8),
            ],
          ),
        ],
      ),
    ),
  );
}