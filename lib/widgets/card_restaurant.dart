import 'package:flutter/material.dart';
import 'package:restoran_dicoding/provider/resto_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

class CardRestaurant extends StatelessWidget {
  final resto;

  const CardRestaurant({required this.resto});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green[100],
      child: InkWell(
        focusColor: Colors.green,
        highlightColor: Colors.green[400],
        splashColor: Colors.green,
        onTap: () {
          context
              .read<RestaurantProvider>()
              .fetchRestaurant(resto.id)
              .then((value) {
            Navigator.pushNamed(context, '/detailScreen', arguments: resto);
          });
        },
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Hero(
                  tag: resto.id!,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image:
                        "https://restaurant-api.dicoding.dev/images/small/${resto.pictureId}",
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        resto.name,
                        style: TextStyle(
                            color: Colors.green[900],
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        resto.city,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rate,
                            color: Colors.yellow,
                          ),
                          Text('${resto.rating}')
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
