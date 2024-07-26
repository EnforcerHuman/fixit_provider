import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _isVerifiedKey = 'isVerified';
  static const String _userIdKey = 'userId';
  // Set login status
  static Future<void> setLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  // Get login status
  static Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> setVerificationStatus(bool isVerified) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isVerifiedKey, isVerified);
  }

  static Future<bool> getVerificationStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isVerifiedKey) ?? false;
  }

  static Future<void> setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userIdKey, userId);
  }

  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey) ?? '';
  }
}
