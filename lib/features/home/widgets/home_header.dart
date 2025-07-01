import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:flutter_application_1/core/models/product.dart';
import 'package:flutter_application_1/core/utils/string.dart';

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
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _searchBoxKey = GlobalKey(); // مفتاح للـ Container مش الـ TextField
  OverlayEntry? _overlayEntry;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _removeOverlay();
      }
    });

    widget.futureProducts.then((products) {
      setState(() {
        _products = products;
        _initializeFuzzySearch();
      });
    });
  }

  void _initializeFuzzySearch() {
    _fuzzy = Fuzzy(
      _products,
      options: FuzzyOptions(
        keys: [
          WeightedKey(name: 'name', weight: 1.0, getter: (product) => product.name),
          WeightedKey(name: 'category', weight: 0.5, getter: (product) => product.category),
        ],
      ),
    );
  }

  void _filterProducts(String query) {
    setState(() {
      _hasText = query.isNotEmpty;
    });

    if (query.isEmpty) {
      _removeOverlay();
    } else {
      setState(() {
        _filteredProducts = _fuzzy.search(query).map<Product>((result) => result.item as Product).toList();
      });
      _showOverlay();
    }
  }

  RichText _highlightText(String text, String query) {
    if (query.isEmpty) {
      return RichText(text: TextSpan(text: text, style: const TextStyle(color: Colors.black)));
    }

    List<TextSpan> spans = [];
    int start = 0;
    while (true) {
      int index = text.toLowerCase().indexOf(query.toLowerCase(), start);
      if (index == -1) {
        spans.add(TextSpan(text: text.substring(start), style: const TextStyle(color: Colors.black)));
        break;
      }
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index), style: const TextStyle(color: Colors.black)));
      }
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ));
      start = index + query.length;
    }

    return RichText(text: TextSpan(children: spans));
  }

 void _showOverlay() {
  _removeOverlay();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final overlay = Overlay.of(context);
    final renderBox = _searchBoxKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy + size.height + 5, // يظهر بعد البوكس بـ 5 بكسل
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 300),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return ListTile(
                  title: _highlightText(product.name, _searchController.text),
                  subtitle: Text("Category: ${product.category}"),
                  onTap: () {
                    _searchController.text = product.name;
                    _removeOverlay();
                    setState(() => _hasText = true);
                    _focusNode.unfocus();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  });
}


  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
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
                width: 30,
                child: Image.asset(Path.logo2),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          CompositedTransformTarget(
            link: _layerLink,
            child: Container(
              key: _searchBoxKey,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(_hasText ? Icons.close : Icons.search),
                    onPressed: () {
                      if (_hasText) {
                        _searchController.clear();
                        _filterProducts('');
                        _focusNode.unfocus();
                      }
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: "Search for a Product",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, Routes.camera);
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
          ),
        ],
      ),
    );
  }
}
