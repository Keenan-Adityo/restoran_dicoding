import 'package:flutter/material.dart';

class AdvertisementPage extends StatelessWidget {
  static const routeName = '/advertisementPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(children: <Widget>[
            SafeArea(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('images/food.jpg')),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Lapar, tapi tidak tahu restoran yang enak di budget dan mulut?',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(16.0),
                    ),
                    Container(
                      child: Text(
                        'Cobalah cek restoran-restoran yang saya rekomendasikan ini!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(6.0),
                        child: ElevatedButton(
                            key: Key('tombolMasuk'), 
                            onPressed: () {
                              print('${DateTime.now()}');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Silahkan nikmati dokumentasi saya!')));
                              Navigator.pushReplacementNamed(
                                  context, '/restaurantView');
                            },
                            child: Text('Klik Disini untuk melihatnya!'))),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
