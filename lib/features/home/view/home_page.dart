import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/features/home/widgets/filtter_button.dart';
import '../widgets/product_card.dart';
import '../widgets/home_header.dart';
import '../widgets/bottom_nav_bar.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.homeBackgroundColor, 
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(), 
            
            const SizedBox(height: 10 , width: 20,),
          
            Padding(
               padding: const EdgeInsets.only(left: 20), 
               child: FiltersButton(), 
               ),
               
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: products.length, // Mock products list
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
