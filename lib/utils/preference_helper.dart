import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const Notification = 'Notification';
  static const FirstLaunch = 'FirstLaunch';

  Future<bool> get isFirstLaunch async {
    final prefs = await sharedPreferences;
    return prefs.getBool(FirstLaunch) ?? false;
  }

  void setFirstLaunch(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(FirstLaunch, value);
  }

  Future<bool> get isNotificationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(Notification) ?? false;
  }

  void setNotification(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(Notification, value);
  }
}
