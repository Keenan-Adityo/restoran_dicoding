part of 'resto_provider.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper prefHelper;

  PreferencesProvider({required this.prefHelper}) {
    print('masuk');
    _getNotification();
    _getFirstLaunch();
  }

  bool _isNotificationActive = false;
  bool get isNotificationActive => _isNotificationActive;

  bool _isFirstLaunch = false;
  bool get isFirstLaunch => _isFirstLaunch;

  void _getFirstLaunch() async {
    _isFirstLaunch = await prefHelper.isFirstLaunch;
    notifyListeners();
  }

  void enableFisrtLaunch(bool value) {
    prefHelper.setFirstLaunch(value);
    _getFirstLaunch();
  }

  void _getNotification() async {
    _isNotificationActive = await prefHelper.isNotificationActive;
    notifyListeners();
  }

  void enableNotification(bool value) {
    prefHelper.setNotification(value);
    _getNotification();
  }
}
