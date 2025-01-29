
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  static  clearSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }


  static void storeToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('fcm', token);
  }

  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('fcm') ?? "";
  }


  static void storeMsisdn(String msisdn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('msisdn', msisdn);
  }

  static Future<String> getMsisdn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('msisdn') ?? "";
  }


  static void storeEmail(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('Email', email);
  }

  static Future<String> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('Email') ?? "";
  }


  static void storePassword(String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('password', password);
  }

  static Future<String> getPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('password') ?? "";
  }

}
