import 'dart:io';
import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/core/utils/string.dart';
import 'package:localproductsfinder/core/models/product.dart';
class ResultPage extends StatelessWidget {
  // final File image;
  // final bool? isLocal;
  // final String? productName;
  final Product product;

  const ResultPage({
    super.key,
    // required this.image,
    // required this.isLocal,
    // this.productName, required productId,
    required this.product,
  });

  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: MyColors.whiteColor,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_sharp , size: 22, color: MyColors.arrowColor,),
                onPressed: () => Navigator.pushReplacementNamed(context , Routes.camera),
              ),
            ),
            const SizedBox(height: 20),
            product.isLocal == null
                ? Image.asset(Path.error, height: 260)
                : Image.file(File(product.imageUrl), height: 220, width: 220),
            const SizedBox(height: 10),

            if (product.name != null && product.isLocal != null)
              Text(
                product.name!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 15),

            if (product.isLocal == null) ...[
              const Icon(
                Icons.error_outline,
                color: Colors.orange,
                size: 60,
              ),
              const Text(
                "Can't identify the product",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ] else ...[
              Icon(
                product.isLocal == "Yes" ? Icons.location_on : Icons.block,
                color: product.isLocal == "Yes"
                    ? Colors.green
                    : const Color.fromARGB(255, 198, 32, 20),
                size: 80,
              ),
              const SizedBox(height: 10),
              Text(
                product.isLocal == "Yes" ? "The Product is Local" : "Not Local Product",
                style: TextStyle(
                  fontSize: 22,
                  color: product.isLocal == "Yes"
                      ? Colors.green
                      : const Color.fromARGB(255, 198, 32, 20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                product.isLocal == "Yes"
                    ? "Feel free to use it"
                    : "Try to use different products",
              ),
            ],

            SizedBox(height: 100,),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.recommendation);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  product.isLocal == null
                      ? "View Similar Products"
                      : "View Recommendations",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}