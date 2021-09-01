import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_dicoding/provider/resto_provider.dart';
import 'package:restoran_dicoding/ui/detail_restaurant.dart';

class DetailResto extends StatelessWidget {
  static const routeName = '/detailScreen';

  final resto;

  const DetailResto(this.resto);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantProvider>(builder: (context, detailprovider, _) {
        if (detailprovider.detailState == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (detailprovider.detailState == ResultState.HasData) {
          return SingleChildScrollView(
            child: CardDetail(
              detailresto: detailprovider.detailresult,
              resto: resto,
            ),
          );
        } else if (detailprovider.detailState == ResultState.NoData) {
          return Center(child: Text(detailprovider.message));
        } else if (detailprovider.detailState == ResultState.Error) {
          return Center(child: Text(detailprovider.message));
        } else {
          return Center(child: Text(''));
        }
      }),
      backgroundColor: Colors.white,
    );
  }
}
