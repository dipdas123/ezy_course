import 'package:audioplayers/audioplayers.dart';

class AudioConstant {
  static String mp3Path = 'mp3';

  static final String boxDown = "$mp3Path/sound_box_down.mp3";
  static final String boxUp = "$mp3Path/sound_box_up.mp3";
  static final String focus = "$mp3Path/sound_focus.mp3";
  static final String pick = "$mp3Path/sound_pick.mp3";
  static final String shortPressLike = "$mp3Path/sound_short_press_like.mp3";

  static String facebook_like_react_sound_mp3 = "$mp3Path/facebook_like_react_sound_mp3.mp3";
}

void playReactionSoundOnlyLike() async {
  final AudioPlayer audioPlayer = AudioPlayer();
  if (audioPlayer.state == PlayerState.playing) audioPlayer.stop();
  await audioPlayer.play(AssetSource(AudioConstant.facebook_like_react_sound_mp3));
}

void playReactionSoundOnLongPress() async {
  final AudioPlayer audioPlayer = AudioPlayer();
  if (audioPlayer.state == PlayerState.playing) audioPlayer.stop();
  await audioPlayer.play(AssetSource(AudioConstant.boxUp));
}

void playReactionSoundOnFingerMove() async {
  final AudioPlayer audioPlayer = AudioPlayer();
  if (audioPlayer.state == PlayerState.playing) audioPlayer.stop();
  await audioPlayer.play(AssetSource(AudioConstant.focus));
}

void playReactionSoundOnFingerDown() async {
  final AudioPlayer audioPlayer = AudioPlayer();
  if (audioPlayer.state == PlayerState.playing) audioPlayer.stop();
  await audioPlayer.play(AssetSource(AudioConstant.boxDown));
}