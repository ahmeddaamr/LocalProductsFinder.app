import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/string.dart';
class Product {
  final String name;
  final String image;
  final double rating;

  Product({required this.name, required this.image, required this.rating});
}

final List<Product> products = [
  Product(name: "Big Chips Salt & Vinegar", image: Path.chips, rating: 4.2),
  Product(name: "Corona Milk Hazelnut", image: Path.corona, rating: 4.5),
  Product(name: "Molto Mini Magnum", image: Path.molto, rating: 3.4),
  Product(name: "Molto Mini Magnum", image: Path.spiro, rating: 3.4),
];
////////////////////////////////////////////

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green, width: 0.8), // Green border
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Expanded(
            child: Center(
              child: Image.asset( product.image , fit: BoxFit.contain), 
            ),
          ),

          SizedBox(height: 8),

          
          Text(
            product.name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 5),

          // Rating & Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 16),
                  Text(product.rating.toString(), style: TextStyle(fontSize: 12)),
                ],
              ),
             
     ElevatedButton(
  onPressed: () {
    // TODO: Implement Add Review Logic
  },
  style: ElevatedButton.styleFrom(
    backgroundColor:MyColors.greenColor,
    foregroundColor: MyColors.whiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  ),

  child: Text(
    "Add Review",
    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  ),
),

            ],
          ),
        ],
      ),
    );
  }
}
