part of 'resto_provider.dart';

class AlarmProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRestaurants(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Activated!');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Canceled!');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
