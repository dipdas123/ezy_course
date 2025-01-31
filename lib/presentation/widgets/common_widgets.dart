import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../utils/asset_constants.dart';
import '../../utils/audio_constants.dart';
import '../../utils/color_constants.dart';
import '../../utils/size_config.dart';
import 'ReactionDragger.dart';

Widget getLoader({Color? color}) {
  return Container(
    height: getProportionateScreenHeight(25),
    alignment: Alignment.center,
    child: SizedBox(
      height: getProportionateScreenHeight(25),
      width: getProportionateScreenWidth(25),
      child: CircularProgressIndicator(
        strokeWidth: 6.0,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? ColorConfig.primaryColorLite),
      ),
    ),
  );
}

bool isTextOverflowing(String text, double maxWidth, double maxHeight, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: null,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: maxWidth);

  // print("textPainter.height > maxHeight :: ${textPainter.height > maxHeight}");
  return textPainter.height > maxHeight;
}

List<Reaction> reactionsList = [
  Reaction(
    id: 'like',
    name: 'LIKE', // Uppercase
    icon: AssetImage(AssetConfig.like_icon),
  ),
  Reaction(
    id: 'love',
    name: 'LOVE', // Uppercase
    icon: AssetImage(AssetConfig.love_icon),
  ),
  Reaction(
    id: 'haha',
    name: 'HAHA', // Uppercase
    icon: AssetImage(AssetConfig.haha_icon),
  ),
  Reaction(
    id: 'care',
    name: 'CARE', // Uppercase
    icon: AssetImage(AssetConfig.care_icon),
  ),
  Reaction(
    id: 'wow',
    name: 'WOW', // Uppercase
    icon: AssetImage(AssetConfig.wow_icon),
  ),
  Reaction(
    id: 'sad',
    name: 'SAD', // Uppercase
    icon: AssetImage(AssetConfig.haha_icon),
  ),
  Reaction(
    id: 'angry',
    name: 'ANGRY', // Uppercase
    icon: AssetImage(AssetConfig.angry_icon),
  ),
];

getReaction(String reactionFromApi) {
  return reactionsList.firstWhere((reaction) => reaction.name.toUpperCase() == reactionFromApi.toUpperCase(),
    orElse: () => Reaction(id: '', name: '', icon: const AssetImage('')),
  ).icon;
  // for(var reaction in reactionsList) {
  //   print("reactionFromApi :: $reactionFromApi >>> ${reaction.name == reactionFromApi}");
  //   return reaction.name.toUpperCase() == reactionFromApi.toUpperCase() ? reaction.icon : AssetImage(AssetConfig.like_icon2);
  // }
}

void playReactionSoundOnlyLike() async {
  final AudioPlayer audioPlayer = AudioPlayer();
  if (audioPlayer.state == PlayerState.playing) audioPlayer.stop();
  await audioPlayer.play(AssetSource(AudioConstant.facebook_like_react_sound_mp3));
}
