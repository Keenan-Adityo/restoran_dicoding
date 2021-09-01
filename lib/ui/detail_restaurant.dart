import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_dicoding/data/model/restaurantlist.dart';
import 'package:restoran_dicoding/provider/resto_provider.dart';
import 'package:restoran_dicoding/widgets/addreview_widget.dart';
import 'package:restoran_dicoding/widgets/customersreview_widget.dart';
import 'package:restoran_dicoding/widgets/customtabbar_widget.dart';
import 'package:restoran_dicoding/widgets/menu_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class CardDetail extends StatefulWidget {
  final detailresto;
  final resto;
  final int initialPage;

  const CardDetail(
      {required this.detailresto, this.resto, this.initialPage = 0});

  @override
  _CardDetailState createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  late int selectedPage;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    selectedPage = widget.initialPage;
    pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                  tag: widget.detailresto.id!,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image:
                        "https://restaurant-api.dicoding.dev/images/medium/${widget.detailresto.pictureId}",
                  )),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        child: IconButton(
                          icon: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Spacer(),
                      Consumer<FavoriteProvider>(
                          builder: (context, provider, child) {
                        return FutureBuilder<bool>(
                            future: provider.isFavorite(widget.resto.id),
                            builder: (context, snapshot) {
                              bool isFavorite = snapshot.data ?? false;
                              return GestureDetector(
                                onTap: () {
                                  isFavorite
                                      ? provider.removeFavorite(widget.resto.id)
                                      : provider.addFavorite(widget.resto);

                                  final snackBar = SnackBar(
                                    content: Text(isFavorite
                                        ? 'Success Remove from favorite'
                                        : 'Success Add to Favorite'),
                                    duration: Duration(seconds: 2),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                  child: Icon(
                                    isFavorite
                                        ? EvaIcons.heart
                                        : EvaIcons.heartOutline,
                                    color: isFavorite
                                        ? Colors.white
                                        : Colors.white,
                                  ),
                                ),
                              );
                            });
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white),
            child: Column(
              children: [
                Container(
                  color: Colors.green,
                  width: double.infinity,
                  child: CustomTabBar(
                    titles: ['Details', 'Menu', 'Review'],
                    selectedIndex: selectedPage,
                    onTap: (index) {
                      setState(() {
                        selectedPage = index;
                      });
                      pageController.jumpToPage(selectedPage);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 460,
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedPage = index;
                });
              },
              children: [
                Container(
                  child: _detailRestaurant(
                    context,
                    widget.detailresto,
                  ),
                ),
                Container(
                  child: _menuRestaurant(
                    context,
                    widget.detailresto,
                  ),
                ),
                Container(
                  color: Colors.green[200],
                  child: _reviewRestaurant(
                    context,
                    widget.detailresto,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRestaurant(BuildContext context, Restaurant detailresto) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Center(
            child: Text(
              widget.detailresto.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.location_city),
                  SizedBox(height: 8.0),
                  Text(
                    '${widget.detailresto.address}, ${widget.detailresto.city}',
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.star_rate,
                    color: Colors.yellow,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '${widget.detailresto.rating}',
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          child: Text(
            widget.detailresto.description,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Maaf, saya sedang libur!')));
            },
            child: Center(
              child: Container(
                child: Row(
                  children: [
                    Icon(Icons.warning),
                    Text('Laporkan masalah'),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _menuRestaurant(BuildContext context, Restaurant detailresto) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Menu",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Menu(detailresto: widget.detailresto)
          ],
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Maaf, saya sedang libur!')));
            },
            child: Center(
              child: Container(
                child: Row(
                  children: [
                    Icon(Icons.warning),
                    Text('Laporkan masalah'),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _reviewRestaurant(BuildContext context, Restaurant detailresto) {
    return ListView(
      children: [
        Card(
          color: Colors.grey[200],
          margin: EdgeInsets.all(16),
          child: Padding(
              padding: EdgeInsets.all(5),
              child: CustomersReview(detailresto: widget.detailresto)),
        ),
        UserReview(detailresto: widget.detailresto),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Maaf, saya sedang libur!')));
            },
            child: Center(
              child: Container(
                child: Row(
                  children: [
                    Icon(Icons.warning),
                    Text('Laporkan masalah'),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
