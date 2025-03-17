import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/utils/string.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
class FiltersButton extends StatelessWidget {
  const FiltersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    
    GestureDetector(
      onTap: () {
   
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: 300, // Adjust height as needed
              child: const Column(
                children: [
                  Text("Filter Options", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  // Add filter options here
                  Text("Coming soon..."),
                ],
              ),
            );
          },
        );
      },
    
       
     child: Container(
     
      height: 40, 
      padding: const EdgeInsets.symmetric(horizontal: 15), 
      decoration: BoxDecoration(
        color: MyColors.whiteColor, 
        borderRadius: BorderRadius.circular(20), 
        border: Border.all(color: MyColors.greenColor , width: 1), // Green border
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Path.filter, 
            height: 18, 
            width: 18,
          ),
          const SizedBox(width: 5), 
          const Text(
            "F i l t e r s",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
    ));
  }
}
