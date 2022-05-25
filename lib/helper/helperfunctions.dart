import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharePreferenceUserLoggedInKey = "ISLOOGEDIN";
  static String sharePreferenceUserNameKey = "USERNAMEKEY";
  static String sharePreferenceUserEmailKey = "USEREMAILKEY";

  //saving data to SharedPreference

  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn)async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   return await prefs.setBool(sharePreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharePreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharePreferenceUserEmailKey, userEmail);
  }

  static Future<bool?> getUserLoggedInSharedPreference()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharePreferenceUserLoggedInKey);
  }

  static Future<String?> getUserNameSharedPreference()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharePreferenceUserNameKey);
  }

  static Future<String?> getUserEmailSharedPreference()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharePreferenceUserEmailKey);
  }

}