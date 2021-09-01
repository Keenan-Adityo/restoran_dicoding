import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                  image: AssetImage('images/food.jpg'), fit: BoxFit.fill),
            ),
            child: Text(
              '',
              style: TextStyle(fontSize: 25),
            ),
          ),
          ListTile(
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pushNamed(context, '/settingPage');
              }),
          ListTile(
            title: const Text('Restoran Favorit'),
            onTap: () {
              Navigator.pushNamed(context, '/favoritePage');
            },
          ),
        ],
      ),
    );
  }
}
