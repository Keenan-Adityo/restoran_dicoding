import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_dicoding/provider/resto_provider.dart';
import 'package:restoran_dicoding/widgets/card_restaurant.dart';

class SearchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, searchprovider, _) {
        if (searchprovider.searchState == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (searchprovider.searchState == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: searchprovider.searchresult.restaurants.length,
            itemBuilder: (context, index) {
              var resto = searchprovider.searchresult.restaurants[index];
              return CardRestaurant(
                resto: resto,
              );
            },
          );
        } else if (searchprovider.searchState == ResultState.NoData) {
          return Center(child: Text(searchprovider.message));
        } else if (searchprovider.searchState == ResultState.Error) {
          return Center(child: Text(searchprovider.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }
}
