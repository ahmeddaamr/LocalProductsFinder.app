import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/models/ratings.dart';
import 'package:localproductsfinder/core/const/config.dart';
import 'package:http/http.dart' as http;
import 'package:localproductsfinder/core/models/user_model.dart';
import 'dart:convert';
class ReviewCard extends StatelessWidget {
  // final String userName;
  // final int rating;
  // final String comment;
  final ProductRatings productRating;
  const ReviewCard({
    // required this.userName,
    // required this.rating,
    // required this.comment,
    required this.productRating,
    super.key,
  });
  Future<UserModel> fetchUser() async {
    final response = await http.get(Uri.parse('${config.URI}/user/get/${productRating.userId}'));
    final data = jsonDecode(response.body);
    // If the response is a list, get the first element; if it's a map, use as is
    if (data is List && data.isNotEmpty) {
      return UserModel.fromJson(data[0]);
    } else if (data is Map<String, dynamic>) {
      return UserModel.fromJson(data);
    } else {
      throw Exception('Unexpected user response format');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage("lib/assets/images/user_avatar.jpg"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<UserModel>(
                  future: fetchUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        'Loading...',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                        'Error',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    } else if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < productRating.rating.floor()
                          ? Icons.star
                          : (index < productRating.rating
                                ? Icons.star_half
                                : Icons.star_border),
                      color: Colors.amber,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(productRating.comment, style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
