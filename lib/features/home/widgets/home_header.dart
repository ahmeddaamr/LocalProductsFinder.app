import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/camera/view/camera_page.dart';


class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
   Widget build(BuildContext context) {
double screenWidth = MediaQuery.of(context).size.width; // Get screen width
double screenHeight = MediaQuery.of(context).size.height; // Get screen height


    return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Responsive padding
          child: Column(
        children: [
              
             Row(
            mainAxisAlignment: MainAxisAlignment.start,
                children: [SizedBox(
                  height: screenHeight * 0.09, 
                  child: Image.asset(Path.logo2),
                width: 50, // Adjust size as needed
              
              ),
        ]),

              SizedBox(height: screenHeight * 0.02), // Space below logo

              // Search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10)],
                ),
                child: Row(
                  children: [
                    Expanded(
                   child: TextField(
                    decoration:InputDecoration(
                    hintText: "Search for a Product",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.camera_alt),

                 onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.camera);
                 },
              ),
    border: InputBorder.none,
            ),

                      ),
                    ),
                    
                ],
                ),
            )]

    
    // Padding(
    //  padding: const EdgeInsets.all(16.0),
    
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [

    //       const Text(
    //         "Home",
    //         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    //       ),

    //       const SizedBox(height: 10),

    //       TextField(

    //         decoration:
    //          InputDecoration(
    //           hintText: "Search for a Product",
    //           prefixIcon: const Icon(Icons.search),
    //           suffixIcon: IconButton(
    //             icon: const Icon(Icons.camera_alt),


    //             onPressed: () {

    //               // TODO: Implement image search
    //             },
    //           ),



    //           border: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(10),
    //             borderSide: BorderSide(color: Colors.grey.shade300),
    //           ),
    //           filled: true,
    //           fillColor: Colors.white,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  ),);}
}
