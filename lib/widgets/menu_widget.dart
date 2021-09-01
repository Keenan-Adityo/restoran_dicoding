import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final detailresto;

  const Menu({required this.detailresto});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              // width: 100,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "FOODS",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 5),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: detailresto.menus.foods.length,
                        itemBuilder: (context, index) {
                          var item = detailresto.menus.foods[index];
                          return _menuItem(item);
                        },
                      ),
                    ),
                  ]),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "DRINKS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 5),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: detailresto.menus.drinks.length,
                        itemBuilder: (context, index) {
                          var item = detailresto.menus.drinks[index];
                          return _menuItem(item);
                        },
                      ),
                    ),
                  ]),
            ),
          ]),
    );
  }

  Widget _menuItem(dynamic item) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                height: 100,
                child: Image.asset(
                  'images/lunch.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 120,
                child: Text(
                  item.name,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        Positioned(
          top: 25,
          right: -22,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(180),
            child: Container(
              width: 50,
              height: 50,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
