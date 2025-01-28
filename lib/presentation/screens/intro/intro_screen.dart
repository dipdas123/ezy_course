import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../utils/PrefUtils.dart';
import '../../../utils/app_logs.dart';
import '../../../utils/asset_constants.dart';
import '../auth/login_screen.dart';
import '../feed/feed_screen.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({super.key});

  @override
  ConsumerState createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {

  @override
  void initState() {
    redirect();
    super.initState();
  }

  redirect() async {
    await Future.delayed(const Duration(seconds: 3));
    var token = await PrefUtils.getToken();
    AppLogs.infoLog("token :: $token");

    if (token.isNotEmpty) {
      Get.offAll(()=> const FeedScreen());
    } else {
      Get.offAll(()=> LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AssetConfig.splashBgMain,
              fit: BoxFit.fill,
            ),
          ),

          Image.asset(
              AssetConfig.splashBgTopCircle,
              fit: BoxFit.fitWidth,
            ),

          Image.asset(
            AssetConfig.splashBgMiddleCircle,
            fit: BoxFit.contain,
          ),

          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 120,
              child: Image.asset(AssetConfig.appLogo),
            ),
          ),

        ],
      ),
    );
  }
}