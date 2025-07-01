import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/storage/storage.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/features/filter_page/filter_criteria.dart';
import 'package:flutter_application_1/features/home/widgets/filtter_button.dart';
import '../widgets/product_card.dart';
import '../widgets/home_header.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/core/models/product.dart'; // ✅ Import common Product model
import 'package:flutter_application_1/core/const/config.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static Future<List<Product>>? futureProducts;
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('${config.URI}/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> applyFilters(FilterCriteria criteria) async {
    final response = await http.post(
      Uri.parse("${config.URI}/product/filter"), // your API URL
      headers: {
        "Content-Type": "application/json",
        // "Authorization":"${readToken()}",
        },
      body: jsonEncode(criteria.toJson()),
    );
    print(jsonEncode(criteria.toJson()));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        filteredProducts = data.map((e) => Product.fromJson(e)).toList();
      });
    }
    else if(response.statusCode == 404){
      print(response.body);
    }else {
      // handle error
      print("Failed: ${response.statusCode}");
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
            if (futureProducts != null)
              HomeHeader(futureProducts: futureProducts!),

            // HomeHeader(onSearchChanged: updateSearch),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: FiltersButton(
                futureProducts: futureProducts!,
                onApply: applyFilters,
                ),
            ),

            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    ); // Show loading
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    ); // Show error
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }

                  // List<Product> products = snapshot.data!;
                  List<Product> productsToShow = filteredProducts.isNotEmpty 
                  ? filteredProducts 
                  : snapshot.data!;
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                      itemCount: productsToShow.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: productsToShow[index]);
                      // final random = Random();
                      // int randomIndex = random.nextInt(productsToShow.length);
                      // return ProductCard(product: productsToShow[randomIndex]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
    );
  }
}
