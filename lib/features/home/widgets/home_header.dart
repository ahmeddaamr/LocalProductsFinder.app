import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:localproductsfinder/core/models/product.dart';
import 'package:localproductsfinder/core/utils/string.dart';

class HomeHeader extends StatefulWidget {
  final Future<List<Product>> futureProducts;

  const HomeHeader({super.key, required this.futureProducts});

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  late Fuzzy _fuzzy;
  final TextEditingController _searchController = TextEditingController();
  bool _isExpanded = false; // ✅ Controls search box expansion

  @override
  void initState() {
    super.initState();
    widget.futureProducts.then((products) {
      setState(() {
        _products = products;
        _initializeFuzzySearch();
      });
    });
  }

  // ✅ Initialize fuzzy search with product descriptions and categories
  void _initializeFuzzySearch() {
    _fuzzy = Fuzzy(
      _products,
      options: FuzzyOptions(
        keys: [
          WeightedKey(
            name: 'name',
            weight: 1.0,
            getter: (product) => product.name,
          ),
          WeightedKey(
            name: 'category',
            weight: 0.5,
            getter: (product) => product.category,
          ),
        ],
      ),
    );
  }

  // ✅ Filter products based on search query
  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = [];
      } else {
        _filteredProducts =
            _fuzzy
                .search(query)
                .map<Product>((result) => result.item as Product)
                .toList();
      }
    });
  }

  // ✅ Highlight matching text in search results
  RichText _highlightText(String text, String query) {
    if (query.isEmpty)
      return RichText(
        text: TextSpan(text: text, style: TextStyle(color: Colors.black)),
      );

    List<TextSpan> spans = [];
    int start = 0;
    while (true) {
      int index = text.toLowerCase().indexOf(query.toLowerCase(), start);
      if (index == -1) {
        spans.add(
          TextSpan(
            text: text.substring(start),
            style: TextStyle(color: Colors.black),
          ),
        );
        break;
      }
      if (index > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, index),
            style: TextStyle(color: Colors.black),
          ),
        );
      }
      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      );
      start = index + query.length;
    }

    return RichText(text: TextSpan(children: spans));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.09,
                child: Image.asset(Path.logo2),
                width: 30,
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    // onChanged: onSearchChanged,
                    decoration: InputDecoration(
                      hintText: "Search for a Product",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.camera,
                          );
                        },
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: _filterProducts,
                  ),
                ),
              ],
            ),
          ),

          if (_filteredProducts.isNotEmpty)
            Container(
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  var product = _filteredProducts[index];
                  return ListTile(
                    title: _highlightText(product.name, _searchController.text),
                    subtitle: Text('Category: ${product.name}'),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
