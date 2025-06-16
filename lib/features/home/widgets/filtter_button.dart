import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/filter_page/filter_lists.dart';
// import 'package:flutter_application_1/features/filter_page/filter_category.dart';
import 'package:flutter_application_1/features/filter_page/filter_view.dart';
// import 'package:flutter_application_1/features/filter_page/filter_widgets.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
// import 'package:flutter_application_1/features/filter_page/filter_rating.dart';
// import 'package:flutter_application_1/features/filter_page/filter_subcategory.dart';
class FiltersButton extends StatefulWidget {
  const FiltersButton({super.key});

  @override
  State<FiltersButton> createState() => _FiltersButtonState();
}

class _FiltersButtonState extends State<FiltersButton> {
  int selectedIndex = 0; // or null if you want no selection by default

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      
        
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: MyColors.backgroundColor,
          shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
           return FractionallySizedBox(
      heightFactor: 0.65, 
      child: 
      
      FilterForm(),);
          },
        );
      },
      
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyColors.greenColor, width: 1),
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
      ),
    );
  }
}
