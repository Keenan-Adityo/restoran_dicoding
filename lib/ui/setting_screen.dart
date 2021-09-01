import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_dicoding/provider/resto_provider.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/settingPage';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PreferencesProvider>(
          builder: (context, provider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Material(
                  child: ListTile(
                    title: Text(
                      'Schedule Notification',
                    ),
                    trailing: Consumer<AlarmProvider>(
                      builder: (context, scheduled, _) {
                        return Switch.adaptive(
                          value: provider.isNotificationActive,
                          onChanged: (value) async {
                            scheduled.scheduledRestaurants(value);
                            provider.enableNotification(value);
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
