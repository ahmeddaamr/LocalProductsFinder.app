import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/core/utils/fonts.dart';

Widget buildCustomHeader({
  required BuildContext context,
  required String title,
  VoidCallback? onBack,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 40 , bottom: 10),
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp, color: MyColors.arrowColor , size: 20,),
          onPressed: onBack ?? () => Navigator.pop(context),
        ),
       
        Text(
          title,
          style: TextStyle(
            fontFamily: MyFonts.montserratFont,
            color: MyColors.fontColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
