import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_dicoding/provider/resto_provider.dart';

class UserReview extends StatefulWidget {
  final detailresto;

  const UserReview({required this.detailresto});
  @override
  _UserReviewState createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.all(16),
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Center(
            child: Text(
              "Tambahkan Review",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 5),
          child: Container(
            color: Colors.white,
            child: TextField(
              cursorColor: Colors.black,
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    )),
                focusColor: Colors.black,
                hintText: 'Isi nama anda',
                labelText: "Nama",
              ),
              expands: false,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 5, 16, 16),
          child: Container(
            color: Colors.white,
            child: TextField(
              maxLines: 4,
              cursorColor: Colors.black,
              controller: reviewController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    )),
                focusColor: Colors.black,
                hintText: 'Isi review anda',
                labelText: "Review",
                alignLabelWithHint: true,
              ),
              expands: false,
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              final String name = nameController.text;
              final String review = reviewController.text;
              final String id = widget.detailresto.id;

              await context
                  .read<RestaurantProvider>()
                  .fetchAddReview(name, review, id)
                  .then((value) {});

              await context
                  .read<RestaurantProvider>()
                  .fetchRestaurant(id)
                  .then((value) {});
            },
            child: Text("Submit Review")),
      ]),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    super.dispose();
  }
}
