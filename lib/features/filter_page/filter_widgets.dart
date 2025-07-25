
import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/features/filter_page/filter_lists.dart';
// import 'package:localproductsfinder/core/utils/string.dart';
Widget buildFilterButtonBycategory({
  String? label,
  required VoidCallback onTap,
  required bool selected,
  bool enabled = true,
}) {
  label ??= "All";

  return GestureDetector(
    onTap: enabled ? onTap : null,
    child: Opacity(
      opacity: enabled ? 1.0 : 0.4,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.green),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}





  Widget buildFilterButtonByRating({
   required String rating,
  required VoidCallback onTap,
  required bool selected,
}) {
 

   return GestureDetector(
     onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.green),
        ),

        child: 
        Row(children: [
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text
        ( rating,
          style: TextStyle(
             color: Colors.black, 
            fontWeight: FontWeight.w500,
          ),),
        ]),
      ),
    );
  }


Widget buildButton({required String label , onPress
                        }) {
  return ElevatedButton(
   onPressed: onPress,

    style: ElevatedButton.styleFrom(
      elevation: 0, 
      shadowColor: Colors.transparent, 
      fixedSize: const Size(150, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),

      backgroundColor: label == "Apply" ? MyColors.buttonColor : MyColors.fiterCancleButton, 
    ),
    child: Text(
      label,
      style: TextStyle(
        color: label == "Apply" ? Colors.white : Colors.green,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}



  Widget buildHeader(BuildContext context, String title) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            // FilterData.tempSelectedCategories.clear();
            // FilterData.tempSelectedSubCategories.clear();
            // FilterData.tempSelectedRatings.clear();
            Navigator.pop(context);
          },
        ),
         const SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(fontFamily: "Montserrat", fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }



  Widget buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }


