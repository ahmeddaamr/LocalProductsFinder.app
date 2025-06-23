import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/fonts.dart';
import 'package:flutter_application_1/core/utils/string.dart';
///header
Widget buildReviewHeader({
  required BuildContext context,
  String ? title,
}) {
  return 
  // Padding(
    // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0), child:
   Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        
       
        IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp , color: MyColors.arrowColor, size: 20,),
          onPressed: () => Navigator.pop(context),
        ),

        // SizedBox(width: 2,),

        Text(
          title ?? '',
          style:  TextStyle( fontFamily: MyFonts.montserratFont, fontSize: 20 , fontWeight: FontWeight.w200 , 
              ),
        ),

      ],
    );
  // );
}



//////////////button
Widget buildReviewButton({
  required String label,
  required VoidCallback onTap,
}) {
  return ElevatedButton(
    onPressed: onTap,

    style: ElevatedButton.styleFrom(
            fixedSize: const Size(330, 48),
            //maximumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            // padding: const EdgeInsets.symmetric(vertical: 0),
          ),
    child: Text(
      label,
      style: TextStyle(
         fontFamily: MyFonts.montserratFont,
         fontWeight: FontWeight.w100,
        color: Colors.white,
        fontSize: 16,
      ),
    ),

    
  );
}

/// Widget to display product image and title
Widget buildProductImageAndTitle({
  required String productImageUrl,
  required String productTitle,
  double imageSize = 130,
  double spacing = 15,

}) {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Image.asset(

          productImageUrl,
          width: imageSize,
          height: imageSize,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      SizedBox(height: spacing),
      Center(
        child: Text(
          productTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(height: spacing),
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
        borderSide: BorderSide(color:MyColors.buttonColor,),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color:MyColors.buttonColor,),
      ),
    ),
  );
}

Widget buildReviewRatingBar({
  required double initialRating,
  required ValueChanged<double> onRatingUpdate,
}) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.center,
    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: List.generate(5, (index) {
      return
      
      
      Padding(padding: EdgeInsets.symmetric( horizontal: 5 ),
      child: 
       IconButton(
        
        icon: Icon(
          size: 50 , 
          Icons.star_rate_sharp ,
          color: index < initialRating ? Colors.grey:Colors.amber ,
        ),
        onPressed: () => onRatingUpdate(index + 1.0),
      ),);
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
