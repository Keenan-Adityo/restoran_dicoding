import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_dicoding/provider/resto_provider.dart';
import 'package:restoran_dicoding/utils/notification_helper.dart';
import 'package:restoran_dicoding/widgets/card_restaurant.dart';
import 'package:restoran_dicoding/widgets/drawer_widget.dart';

class RestaurantView extends StatefulWidget {
  static const routeName = '/restaurantView';

  @override
  _RestaurantViewState createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Rekomendasi Restoran',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/searchScreen');
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ))
          ],
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.green[100],
        drawer: DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(child: Consumer<RestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.HasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var resto = state.result.restaurants[index];
                    return CardRestaurant(
                      resto: resto,
                    );
                  },
                );
              } else if (state.state == ResultState.NoData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.Error) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text(''));
              }
            },
          )),
        ));
  }
}
