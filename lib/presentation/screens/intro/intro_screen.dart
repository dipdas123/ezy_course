import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ezycourse/presentation/widgets/common_widgets.dart';
import 'package:ezycourse/utils/color_constants.dart';
import 'package:ezycourse/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../infrastructure/datasources/local/PrefUtils.dart';
import '../../../utils/app_logs.dart';
import '../../../utils/asset_constants.dart';
import '../../../utils/internet_connectivity.dart';
import '../../viewmodels/feed_viewmodel.dart';
import '../auth/login_screen.dart';
import '../feed/feed_screen.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({super.key});

  @override
  ConsumerState createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  var isConnectedStatus = true;
  StreamSubscription<List<ConnectivityResult>>? connection;

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  checkInternet() async {
    if (await InternetConnectivity().isInternetAvailable()) {
      redirect();
    } else {
      startNetworkListening();
    }
  }

  void startNetworkListening() {
    connection = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        Get.snackbar("Internet", "No internet connection ❌", backgroundColor: ColorConfig.redColor, colorText: ColorConfig.whiteColor, snackPosition: SnackPosition.BOTTOM);
        if (mounted) {
          setState(() {
            isConnectedStatus = false;
          });
        }
        print("No internet connection");
      } else {
        Get.snackbar("Internet", "Internet connection ✅.", backgroundColor: ColorConfig.whiteColor);
        if (mounted) {
          setState(() {
            isConnectedStatus = true;
            redirect();
          });
        }
        print("Connected to the internet: $result");
      }
    });
  }

  void stopListening() {
    connection?.cancel();
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
  void dispose() {
    stopListening();
    super.dispose();
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

          isConnectedStatus == false ? Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  getLoader(color: ColorConfig.whiteColor),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: ColorConfig.whiteColor.withOpacity(0.16),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: () {
                        InternetConnectivity.showEnableWiFiDialog(context);
                      },
                      child: Text("Open Wifi Settings",
                        style: textSize14w500.copyWith(color: ColorConfig.whiteColor, fontWeight: FontWeight.w600),),
                    ),
                  ),
                ],
              ),
            ),
          ) : const SizedBox(),

        ],
      ),
    );
  }

}