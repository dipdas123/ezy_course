import 'package:flutter/material.dart';

import '../../utils/color_constants.dart';
import '../../utils/size_config.dart';
import '../../utils/style_utils.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({super.key, required this.btnText, this.buttonIcon = Icons.navigate_next_rounded,
    required this.onPressed, this.isPrimaryButton = true, this.textSize = 14, this.btnColor, this.btnTextColor, this.height, this.startIcon, this.endIcon});

  String btnText;
  IconData? buttonIcon;
  final Function()? onPressed;
  bool? isPrimaryButton;
  double? textSize;
  Color? btnColor;
  Color? btnTextColor;
  double? height;
  String? startIcon;
  String? endIcon;
  var kTDefaultRadius = 12.0;
  var kTDefaultTextSize = 14.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: isPrimaryButton!
          ? Container(
              height: height ?? getProportionateScreenHeight(45),
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(kTDefaultRadius), color: btnColor ?? ColorConfig.primaryColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    btnText.isEmpty ? Icon(buttonIcon, size: 35, color: ColorConfig.whiteColor,) :  Text(btnText, style: headline1.copyWith(fontSize: textSize, color: btnTextColor ?? ColorConfig.whiteColor), textAlign: TextAlign.center),
                  ],
                ),
              ),
            )
          : Container(
              height: height ?? getProportionateScreenHeight(45),
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: btnColor ?? ColorConfig.primaryColor),
                  borderRadius: BorderRadius.circular(kTDefaultRadius),
                  color: ColorConfig.whiteColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              btnText.isEmpty ? Icon(buttonIcon, size: 50, color: ColorConfig.whiteColor,) : Text(btnText, style: headline1.copyWith(fontSize: kTDefaultTextSize, color: btnTextColor ?? ColorConfig.primaryColor), textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}
