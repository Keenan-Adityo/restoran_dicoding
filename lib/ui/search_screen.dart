
import 'package:flutter/material.dart';
import 'package:restoran_dicoding/provider/resto_provider.dart';
import 'package:restoran_dicoding/ui/searchview_screen.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/searchScreen';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: _controller,
            decoration: const InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Ketik disini',
              labelText: 'Cari Nama Resto atau Menu',
              labelStyle: TextStyle(color: Colors.white),
            ),
            onFieldSubmitted: (String? search) {
              context
                  .read<RestaurantProvider>()
                  .fetchSearchRestaurant(search!)
                  .then((value) {});
            },
          ),
          backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SearchList(),
      ),
      backgroundColor: Colors.green[100],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
