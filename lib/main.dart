import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restoran_dicoding/provider/resto_provider.dart';
import 'package:restoran_dicoding/ui/advertisement_screen.dart';
import 'package:restoran_dicoding/ui/favorite_screen.dart';
import 'package:restoran_dicoding/ui/restaurants_screen.dart';
import 'package:restoran_dicoding/ui/detail_screen.dart';
import 'package:restoran_dicoding/ui/search_screen.dart';
import 'package:restoran_dicoding/ui/setting_screen.dart';
import 'package:restoran_dicoding/utils/background_services.dart';
import 'package:restoran_dicoding/utils/db_helper.dart';
import 'package:restoran_dicoding/utils/notification_helper.dart';
import 'package:restoran_dicoding/utils/preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/api/api_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  await AndroidAlarmManager.initialize();

  _service.initializeIsolate();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<RestaurantProvider>(
              create: (_) => RestaurantProvider(apiService: ApiService())),
          ChangeNotifierProvider(
            create: (_) => AlarmProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
              prefHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
          ChangeNotifierProvider<FavoriteProvider>(
            create: (_) => FavoriteProvider(databaseHelper: DatabaseHelper()),
          ),
        ],
        child: MaterialApp(
          title: 'Purwokerto Restaurant',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/advertisementPage',
          routes: {
            '/advertisementPage': (context) => AdvertisementPage(),
            '/restaurantView': (context) => RestaurantView(),
            '/detailScreen': (context) =>
                DetailResto(ModalRoute.of(context)!.settings.arguments),
            '/searchScreen': (context) => SearchPage(),
            '/settingPage': (context) => SettingPage(),
            '/favoritePage': (context) => FavoritePage(),
          },
        ));
  }
}
