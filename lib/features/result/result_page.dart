import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/string.dart';

class ResultPage extends StatelessWidget {
  final File image;
  final bool? isLocal;
  final String? productName;

  const ResultPage({
    super.key,
    required this.image,
    required this.isLocal,
    this.productName,
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
            isLocal == null
                ? Image.asset(Path.error, height: 260)
                : Image.file(image, height: 220, width: 220),
            const SizedBox(height: 10),

            if (productName != null && isLocal != null)
              Text(
                productName!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 15),

            if (isLocal == null) ...[
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
                isLocal! ? Icons.location_on : Icons.block,
                color: isLocal!
                    ? Colors.green
                    : const Color.fromARGB(255, 198, 32, 20),
                size: 80,
              ),
              const SizedBox(height: 10),
              Text(
                isLocal! ? "The Product is Local" : "Not Local Product",
                style: TextStyle(
                  fontSize: 22,
                  color: isLocal!
                      ? Colors.green
                      : const Color.fromARGB(255, 198, 32, 20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                isLocal!
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
                  isLocal == null
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