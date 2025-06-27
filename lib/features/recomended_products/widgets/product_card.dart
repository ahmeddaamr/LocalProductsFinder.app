import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
// import 'package:localproductsfinder/core/utils/string.dart';
import 'package:localproductsfinder/features/reviews/reviews_page.dart';
import 'rating_widget.dart';
import 'package:localproductsfinder/core/models/product.dart';

class ProductCard extends StatefulWidget {
  final double height;
  final Product product;
  const ProductCard({
    super.key,
    required this.product,
    this.height = 140, 
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: _isPressed
            ? Matrix4.diagonal3Values(0.98, 0.98, 1)
            : Matrix4.identity(),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: MyColors.greenColor, width: 0.5),
          ),
          color: MyColors.whiteColor,
          elevation: _isPressed ? 2 : 5,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: widget.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    widget.product.imageUrl, // ✅ Load images dynamically on scroll
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator()); // ✅ Show loader while loading
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 50, color: Colors.red); // ✅ Handle missing images
                    },
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(height: 6),
                         RatingWidget(rate: 4.5),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.location_on_sharp,
                                size: 16, color: Colors.green),
                            const SizedBox(width: 4),
                            Text("Local",
                                style: TextStyle(color: MyColors.fontColor)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              height: 34,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductReviewsPage(product: widget.product),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.greenColor,
                                  foregroundColor: MyColors.whiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    
                                  ),
                                ),
                                child: Text(
                                  "View Reviews",
                                  style: TextStyle(
                                    color: MyColors.whiteColor,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
