import 'dart:io';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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

            const SizedBox(height: 10),

            if (isLocal == null) ...[
              const Icon(
                Icons.error_outline,
                color: Colors.orange,
                size: 60,
              ), //Note:########Optional Icon########
              const Text(
                "Can't identify the product",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              //const Text("Please try another image"),
            ] 
            
            
            else ...[
              Icon(
                isLocal! ? Icons.location_on : Icons.block,
                color: isLocal! ? Colors.green : Colors.red,
                size: 60,
              ),
              Text(
                isLocal! ? "The Product is Local" : "Not Local Product",
                style: TextStyle(
                  fontSize: 22,
                  color: isLocal! ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                isLocal!
                    ? "Feel free to use it"
                    : "Try to use different products",
              ),
            ],

            const Spacer(),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                 Navigator.pushReplacementNamed(context, Routes.recommendation);
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 70,
                  vertical: 15,
                ),
              ),
              child: Text(
                style: TextStyle(color: Colors.white),
                isLocal == null
                    ? "View Similar Products"
                    : "View Recommendations",
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
