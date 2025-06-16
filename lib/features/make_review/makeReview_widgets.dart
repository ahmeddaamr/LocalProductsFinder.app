import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/fonts.dart';
import 'package:flutter_application_1/core/utils/string.dart';
///header
Widget buildReviewHeader({
  required BuildContext context,
  String ? title,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp , color: MyColors.arrowColor,),
          onPressed: () => Navigator.pop(context),
        ),

        SizedBox(width: 10,),

        Text(
          title ?? '',
          style:  TextStyle( fontFamily: MyFonts.montserratFont,
              ),
        ),

      ],
    ),
  );
}



//////////////button
Widget buildReviewButton({
  required String label,
  required VoidCallback onTap,
}) {
  return ElevatedButton(
    onPressed: onTap,

    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
),
    padding: EdgeInsets.symmetric(vertical: 16),
     minimumSize: Size(double.infinity, 50),
    ),

    child: Text(
      label,
      style: TextStyle(
        fontFamily: MyFonts.montserratFont,
        color: Colors.white,
        fontSize: 16.0,
      ),
    ),

    
  );
}

/// Widget to display product image and title
Widget buildProductImageAndTitle({
  required String productImageUrl,
  required String productTitle,
  double imageSize = 100,
  double spacing = 15,

}) {
  return Column(
    children: [
      
      Image.network(
        productImageUrl,
        width: imageSize,
        height: imageSize,
      ),
      SizedBox(height: spacing),
      Text(
        productTitle,
        style: 
            const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
      ),
    ],
  );
}



Widget buildReviewTextField({
  required String hintText,
  required TextEditingController controller,
}) {
  return TextField(
    controller: controller,
    maxLines: 5, 
    decoration: InputDecoration(
      hintText: hintText,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20,
      ),
      hintStyle: TextStyle(
        
        color: const Color.fromARGB(255, 159, 158, 158),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.green),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.green),
      ),
    ),
  );
}

Widget buildReviewRatingBar({
  required double initialRating,
  required ValueChanged<double> onRatingUpdate,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(5, (index) {
      return IconButton(
        icon: Icon(
          Icons.star_rate_sharp ,
          color: index < initialRating ? Colors.grey:Colors.amber ,
        ),
        onPressed: () => onRatingUpdate(index + 1.0),
      );
    }),
  );
}

Widget buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        // fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}
