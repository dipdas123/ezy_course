import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'color_constants.dart';

class InternetConnectivity{
  void checkInternetConnection(Function(bool) onStatusChanged)  {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) async {
      debugPrint("Internet ConnectivityResult -> $result");

      if (result.contains(ConnectivityResult.none)) {
        _whenDisconnected(result);
        onStatusChanged(false);
      } else {
        _whenConnected(result);
        onStatusChanged(true);
      }
    });
  }


  _whenDisconnected(List<ConnectivityResult> result) {
    if (!result.contains(ConnectivityResult.ethernet) &&
        !result.contains(ConnectivityResult.mobile) &&
        !result.contains(ConnectivityResult.wifi)) {
      Get.snackbar("Internet", "No internet connection ❌", backgroundColor: ColorConfig.redColor, colorText: ColorConfig.whiteColor, snackPosition: SnackPosition.BOTTOM);
    }
  }

  _whenConnected(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.ethernet) ||
        result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      Get.snackbar("Internet", "Internet connection ✅.", backgroundColor: ColorConfig.whiteColor);
    }
  }

  Future<bool> isInternetAvailable() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }

  static showEnableWiFiDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enable WiFi"),
          content: const Text("WiFi is turned off. Please enable it to connect to the internet."),
          actions: [
            TextButton(
              onPressed: () {
                AppSettings.openAppSettings(type: AppSettingsType.wifi);
                Get.back();
              },
              child: const Text("Open Settings"),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

}

