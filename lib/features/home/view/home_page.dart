import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/features/home/widgets/filtter_button.dart';
import '../widgets/product_card.dart';
import '../widgets/home_header.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localproductsfinder/core/models/product.dart';  // ✅ Import common Product model
import 'package:localproductsfinder/core/const/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static Future<List<Product>>? futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts ??= fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
  // final response = await http.get(Uri.parse('http://127.0.0.1:5000/products'));
  final response = await http.get(Uri.parse('${config.URI}/products'));
  // final response = await http.get(Uri.parse('https://a3cd-102-46-16-89.ngrok-free.app/products'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Product.fromJson(item)).toList(); 
  } else {
    throw Exception('Failed to load products');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.homeBackgroundColor, 
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (futureProducts != null) // ✅ Ensure futureProducts is initialized
              HomeHeader(futureProducts: futureProducts!), 
            
            const SizedBox(height: 10 , width: 20,),
          
            const Padding(
               padding: EdgeInsets.only(left: 20), 
               child: FiltersButton(), 
               ),
               
            const SizedBox(height: 10),
            Expanded(
               child: FutureBuilder<List<Product>>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator()); // Show loading
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}')); // Show error
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }

                  List<Product> products = snapshot.data!;
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  );
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