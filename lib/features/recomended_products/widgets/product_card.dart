import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'rating_widget.dart';

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double height; // Adjustable card height

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.height = 140, // Default height
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
        transform: _isPressed ? Matrix4.diagonal3Values(0.98, 0.98, 1) : Matrix4.identity(),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: MyColors.greenColor, width: 0.5), // Green border
          ),
          color: MyColors.whiteColor,
          elevation: _isPressed ? 2 : 5,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: widget.height, 
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.imageUrl,
                    width: 80,
                    height: 100,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center, // Center content
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(height: 6),
                        const RatingWidget(),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.local_offer, size: 16, color: Colors.green),
                            const SizedBox(width: 4),
                            Text("Local", style: TextStyle(color: MyColors.fontColor)),
                          ],
                        ),
                        // const SizedBox(height: 10), // Adjust button position
                        Align(
                          alignment: Alignment.bottomRight, // Move button down
                          child: ElevatedButton(
                            onPressed: () {
                              /// View product details action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.greenColor,
                              foregroundColor: MyColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                              elevation: 4, 
                            ),
                            child: Text(
                              "View Reviews",
                              style: TextStyle(color: MyColors.whiteColor),
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
