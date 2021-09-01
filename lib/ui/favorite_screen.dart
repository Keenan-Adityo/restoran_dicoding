import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_dicoding/provider/resto_provider.dart';
import 'package:restoran_dicoding/widgets/card_restaurant.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favoritePage';

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Restaurants'),
        backgroundColor: Colors.green,
      ),
      body: Consumer<FavoriteProvider>(builder: (context, provider, _) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: provider.favorites?.length,
            itemBuilder: (context, index) {
              var resto = provider.favorites![index];
              return CardRestaurant(
                resto: resto,
              );
            },
          );
        } else {
          return Column(
            children: [
              Text(
                'Empty Favorite Restaurant',
                textAlign: TextAlign.center,
              )
            ],
          );
        }
      }),
    );
  }
}
