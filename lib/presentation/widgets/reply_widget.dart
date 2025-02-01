import 'package:ezycourse/core/entities/Reply.dart';
import 'package:ezycourse/presentation/viewmodels/feed_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/color_constants.dart';
import '../../utils/size_config.dart';
import '../../utils/string_constants.dart';
import '../../utils/style_utils.dart';
import 'common_widgets.dart';

Widget replyWidget(BuildContext context, Reply reply, FeedViewModel provider) {
  return Container(
    width: SizeConfig.screenWidth,
    margin: EdgeInsets.only(left: getProportionateScreenWidth(20), right: 0, top: 5, bottom: 5),
    child: Card(
      color: ColorConfig.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Adjust radius as needed
      ),
      child: Row(
        children: [
          Flexible(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(reply?.user?.profilePic ?? ""),
              ),
            ),
          ),

          Flexible(
            flex: 1,
            child: SizedBox(
              width: SizeConfig.screenWidth,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  // color: ColorConfig.greyColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(reply?.user?.fullName ?? "",
                      style: textSize14w700.copyWith(color: ColorConfig.textColorPrimary),
                    ),
                    Text(reply?.commentTxt ?? "",
                      style: textSize12w500.copyWith(color: ColorConfig.textColorSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    ),
  );
}