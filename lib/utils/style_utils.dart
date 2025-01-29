import 'package:flutter/material.dart';
import 'color_constants.dart';

const TextStyle headline1 = TextStyle(fontWeight: FontWeight.w600, color: ColorConfig.textColorPrimary, fontSize: 12);
const TextStyle headline2 = TextStyle(fontWeight: FontWeight.w600, color: Colors.black54, fontSize: 12);
const TextStyle textSize20 = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
const TextStyle textSize16Bold = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
const TextStyle textSize12 = TextStyle(fontSize: 12);
final TextStyle textSize12Primary = TextStyle(fontSize: 12, color: ColorConfig.primaryColor);
const TextStyle textSize17White = TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold);
const TextStyle textSize40Black = TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold);
const TextStyle textSize14w700 = TextStyle(color: Colors.black54,fontWeight: FontWeight.w700);
const TextStyle textSize14w300 = TextStyle(color: Colors.black54,fontWeight: FontWeight.w300);
const TextStyle textSize9White = TextStyle(fontWeight: FontWeight.w700, color: ColorConfig.whiteColor, fontSize: 9);
const TextStyle textSize10White = TextStyle(fontWeight: FontWeight.w600, color: ColorConfig.backgroundColorPrimary, fontSize: 10);
const TextStyle textSize10 = TextStyle( fontSize: 10);
const TextStyle textSize26= TextStyle(fontSize: 26);
const TextStyle textSize32 = TextStyle(fontSize: 32);
const TextStyle textSize14White = TextStyle(color: ColorConfig.backgroundColorPrimary, fontWeight: FontWeight.w500);
const TextStyle textSize18w600 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
const TextStyle textSize18w500 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
const TextStyle textSize12w600 = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white);
const TextStyle textSize14w600 = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
const TextStyle textSize14w400 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
const TextStyle textSize14w500 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
const TextStyle textSize16w500 = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
const TextStyle textSize12w500 = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ColorConfig.textColorSecondary);
const TextStyle textSize12w500PrimaryTextColor = TextStyle(fontSize: 12, color: ColorConfig.textColorPrimary, fontWeight: FontWeight.w500);
const TextStyle textSize12w500PrimaryColor = TextStyle(fontSize: 12, color: ColorConfig.primaryColor, fontWeight: FontWeight.w600);
const TextStyle textSize13w500 = TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorConfig.textColorSecondary);
const TextStyle textSize14Primary = TextStyle(fontWeight: FontWeight.w500, color: ColorConfig.primaryColor);
const TextStyle textColorRed = TextStyle( color: ColorConfig.redColor, fontWeight: FontWeight.w500, fontSize: 12);
const TextStyle textSize12Red = TextStyle( color: ColorConfig.redColor);
const TextStyle textStyle8 = TextStyle(fontSize: 8);

class GradientColorList {
  static List gradientsColor = const [
    LinearGradient(
      begin: Alignment(-1.0, 0.0),
      end: Alignment(1.0, 0.0),
      transform: GradientRotation(90),
      colors: [
        Color(0xFFFFFFFF),
        Color(0xFFFFFFFF),
      ],
    ),
    LinearGradient(
      begin: Alignment(-1.0, 0.0),
      end: Alignment(1.0, 0.0),
      transform: GradientRotation(90),
      colors: [
        Color(0xFFff00ea),
        Color(0xFFff7300),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      transform: GradientRotation(-135),
      colors: [
        Color.fromRGBO(72, 229, 169, 1),
        Color.fromRGBO(143, 199, 173, 1),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(116, 167, 126, 1),
        Color.fromRGBO(24, 175, 78, 1),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFff7f11),
        Color(0xFFff7f11),
      ],
    ),
    LinearGradient(
      begin: Alignment(-1.0, 0.0),
      end: Alignment(1.0, 0.0),
      transform: GradientRotation(90),
      colors: [
        Color(0xFF00ffe1),
        Color(0xFFe9ff42),
      ],
    )
  ];
  static List feedBackGroundGradientColors = [
    "{\"backgroundImage\":\"linear-gradient(45deg, rgb(255, 115, 0) 0%, rgb(255, 0, 234) 100%)\"}",
    "{\"backgroundImage\":\"linear-gradient(135deg, rgb(143, 199, 173), rgb(72, 229, 169))\"}",
    "{\"backgroundImage\":\"linear-gradient(135deg, rgb(116, 167, 126), rgb(24, 175, 78))\"}",
    "{\"backgroundImage\":\"linear-gradient(45deg, rgb(255, 127, 17) 0%, rgb(255, 127, 17) 100%)\"}",
    "{\"backgroundImage\":\"linear-gradient(45deg, rgb(233, 255, 66) 0%, rgb(0, 255, 225) 100%)\"}"
  ];
}