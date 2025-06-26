import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/features/home/widgets/bottom_nav_bar.dart';
// import 'package:flutter_application_1/core/utils/fonts.dart';
import 'package:flutter_application_1/features/recomended_products/widgets/headerWidget.dart';
import 'package:flutter_application_1/features/recomended_products/widgets/product_card.dart';
import 'package:flutter_application_1/core/utils/string.dart';

// TODO: Backend Team - Fetch recommended products dynamically.
final List<Map<String, String>> sampleProducts = [
  {
    "imageUrl": Path.spiro,
    "title": "V Super Soda Diet Cola Can",
  },
  {
    "imageUrl": Path.spiro,
    "title": "X Energy Drink Zero Sugar",
  },
  {
    "imageUrl": Path.chips,
    "title": "Local tomato chips ",
  },
];

class RecommendedProductsPage extends StatelessWidget {
  const RecommendedProductsPage({super.key});
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: Column(
        children: [
          buildCustomHeader(
              context: context,
              title: 'Recommended Similar Products',
              onBack: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacementNamed(context, Routes.camera);
                }
              }),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sampleProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  imageUrl: sampleProducts[index]["imageUrl"]!,
                  title: sampleProducts[index]["title"]!,
                  ratee: 4.5,
                );
              },
            ),

          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 2,),
    );
  }
}
