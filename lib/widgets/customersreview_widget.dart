import 'package:flutter/material.dart';

class CustomersReview extends StatelessWidget {
  final detailresto;

  const CustomersReview({required this.detailresto});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Review",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: detailresto.customerReviews.length,
          itemBuilder: (context, index) {
            var reviews = detailresto.customerReviews[index];
            return Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              reviews.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                      Text(
                        ('${reviews.review} (${reviews.date})'),
                        textAlign: TextAlign.start,
                      ),
                    ]),
              ),
            );
          },
        ),
      ],
    );
  }
}
