import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/string.dart';
//import 'package:flutter_application_1/features/camera/view/camera_page.dart';

class HomeHeader extends StatelessWidget {
  final void Function(String query) onSearchChanged;

  const HomeHeader({super.key, required this.onSearchChanged});

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
                    onChanged: onSearchChanged,
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
