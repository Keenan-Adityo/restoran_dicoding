import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> titles;
  final Function(int) onTap;

  CustomTabBar({
    required this.onTap,
    required this.selectedIndex,
    required this.titles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: titles
            .map((e) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 40,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            onTap(titles.indexOf(e));
                          },
                          child: Column(
                            children: [
                              Text(
                                e,
                                style: (titles.indexOf(e) == selectedIndex)
                                    ? TextStyle(
                                        fontWeight: FontWeight.w800,
                                      )
                                    : TextStyle(fontWeight: FontWeight.normal),
                              ),
                              Container(
                                width: 50,
                                height: 4,
                                margin: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: (titles.indexOf(e) == selectedIndex)
                                        ? Colors.white
                                        : Colors.transparent),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
