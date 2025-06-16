import 'package:flutter/material.dart';
// import 'package:frontend/leave_review/views/leave_review_page.dart';

class ProductReviewsPage extends StatelessWidget {
  final List<Map<String, dynamic>> dummyReviews = [
    {"user": "Alice Johnson", "rating": 5, "comment": "Absolutely love it!"},
    {
      "user": "Michael Brown",
      "rating": 4,
      "comment": "Great product, but delivery took too long.",
    },
    {
      "user": "Sarah Lee",
      "rating": 3,
      "comment": "It’s okay, not the best but works fine.",
    },
    {
      "user": "David Smith",
      "rating": 5,
      "comment": "Superb quality, highly recommend!",
    },
    {
      "user": "Emma Wilson",
      "rating": 2,
      "comment": "Didn’t meet my expectations at all.",
    },
    {
      "user": "John Doe",
      "rating": 1,
      "comment": "Worst purchase ever. Do not buy.",
    },
    {
      "user": "Olivia Taylor",
      "rating": 4,
      "comment": "Nice and useful product.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double averageRating = _calculateAverageRating();
    int totalReviews = dummyReviews.length;
    Map<int, int> ratingFrequencies = _calculateRatingFrequencies();

    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "V Super Soda Diet Cola Can",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "    ${averageRating.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      _buildStarRating(averageRating),
                      SizedBox(height: 4),
                      Text(
                        " $totalReviews Reviews",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildRatingBars(ratingFrequencies, totalReviews),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(thickness: 1), // Adds a line before the reviews section
            SizedBox(height: 8),
            Text(
              "Users' Reviews",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: dummyReviews.length,
                itemBuilder: (context, index) {
                  return _buildReviewItem(dummyReviews[index]);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder:
                  //         // (context) => LeaveReviewPage(
                  //         //   imageUrl: "assets/prod1.png",
                  //         //   description: "V Cola",
                  //         // ),
                  //   // ),
                  // );
                },
                child: Text(
                  "Leave a Review",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateAverageRating() {
    if (dummyReviews.isEmpty) return 0.0;
    double total = dummyReviews.fold(
      0,
      (sum, review) => sum + review["rating"],
    );
    return total / dummyReviews.length;
  }

  Map<int, int> _calculateRatingFrequencies() {
    Map<int, int> freq = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var review in dummyReviews) {
      int rating = review["rating"];
      freq[rating] = (freq[rating] ?? 0) + 1;
    }
    return freq;
  }

  Widget _buildRatingBars(Map<int, int> frequencies, int total) {
    return Column(
      children: List.generate(5, (index) {
        int star = 5 - index;
        double percentage = total == 0 ? 0.0 : (frequencies[star]! / total);
        return Row(
          children: [
            Text("$star", style: TextStyle(fontSize: 16)),
            SizedBox(width: 8),
            Expanded(
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
              ),
            ),
            SizedBox(width: 8),
            Text("${frequencies[star]}", style: TextStyle(fontSize: 16)),
          ],
        );
      }),
    );
  }

  Widget _buildStarRating(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, color: Colors.amber);
        } else if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half, color: Colors.amber);
        } else {
          return Icon(Icons.star_border, color: Colors.amber);
        }
      }),
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/avatar1.png'),
            radius: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review["user"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                _buildStarRating(review["rating"].toDouble()),
                SizedBox(height: 4),
                Text(
                  review["comment"],
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
