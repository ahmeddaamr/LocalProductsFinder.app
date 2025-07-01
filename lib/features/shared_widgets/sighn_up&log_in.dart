 import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
// import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/string.dart';
// Widget buildTextField({
//     // Context ,
//     TextEditingController? controller,
//     String? hint,
//     int maxLines = 1,
//     TextInputType keyboardType = TextInputType.text,
//     Widget? suffixIcon,
//   })
  
//    {
//     return TextFormField(
//       controller: controller,
//       maxLines: maxLines,
//       keyboardType: keyboardType,
//       style: TextStyle(color: MyColors.fontColor , fontSize: 14),
//       decoration: inputDecoration(hint: hint, suffixIcon: suffixIcon),
//     );
//   }


//    InputDecoration inputDecoration({String? hint, Widget? suffixIcon}) {
//     return InputDecoration(
//       hintText: hint,
//       suffixIcon: suffixIcon,
//       filled: true,
//       fillColor: MyColors.searchFontColor,
      
      
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
      
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none,
//       ),
//     );

//   }



// Widget buildHeader(BuildContext context, String title) {
//   return Row(
//     children: [
//       GestureDetector(
//         // onTap: () {
//         //   Navigator.pop(context);
//         // },

//         child: Icon(
//           Icons.arrow_back_ios_new_outlined,
//           color: MyColors.greenColor,
//           size: 20,
//         ),
//       ),

//       const SizedBox(width: 10),
      
//       Text(
//         title,
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: MyColors.fontColor,
//         ),
//       ),
//     ],
//   );
// }















///////////////////header/////////////////////////
Widget buildPageHeader

({
  required BuildContext context,
  required String title,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 110), 
      
      Center(
        child: Image.asset(
          Path.logo2, 
          height: 50,
        ),
      ),
      const SizedBox(height: 30),
      Padding(padding: const EdgeInsets.only(left: 20),
      child:Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),),
      const SizedBox(height: 12),
    ],
  );
}


//////////////////////text feild //////////////////
Widget buildTextField(String hintText
 , Controller, 
  {bool obscureText = false}) 
  {
return Padding(
    padding: const EdgeInsets.all(8),
  
    child:
  SizedBox(
  height: 50.0,
    child: TextField(
      controller: Controller,
      obscureText: obscureText,
     
      decoration: InputDecoration(
  
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: TextStyle(color: MyColors.arrowColor, fontSize: 13),
        hintText: hintText,
        filled: true,
        fillColor: MyColors.loginInputColor,
        
        border: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    ),),
  );
}
////////////////////////////////////


Widget buildCountryDropdown(
  TextEditingController controller,
  List<String> countries,
) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: SizedBox(
      height: 50.0,
      child: DropdownButtonFormField<String>(
        value: controller.text.isNotEmpty ? controller.text : null,
        onChanged: (value) {
          controller.text = value!;
        },
        decoration: InputDecoration(
           contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16 , ),
          hintText: 'Country',
          hintStyle: TextStyle(color: MyColors.arrowColor, fontSize: 13),

          filled: true,
          fillColor: MyColors.loginInputColor,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),

        ),
        icon: const Icon(Icons.arrow_drop_down),
        dropdownColor: Colors.white,      
        menuMaxHeight: 200,        
        items: countries
            .map((country) => DropdownMenuItem<String>(
                  value: country,
                  child: Text(country, style: const TextStyle(fontSize: 13)),
                ))
            .toList(),
      ),
    ),
  );
}



/////////////////////////////////////////////button ///////////////////////
Widget buildMainButton({
  required String buttonText,
  required  onPressed, 
  
}) {
  return Column(
    children: [
      SizedBox(
        child: ElevatedButton(
          onPressed: onPressed,
          
          style: 
          ElevatedButton.styleFrom(
            fixedSize: const Size(330, 48),

            backgroundColor:MyColors.greenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(buttonText , style: TextStyle(color: MyColors.whiteColor,fontSize: 12),
        ),
      ),),

       
    ],
  );
}

Widget buildLine(
){
return 
Padding(padding: EdgeInsets.symmetric(horizontal: 50),
  child:  
Row(
    children: [
      Expanded(
        child: Divider(
          color: Colors.grey[400],
          thickness: 1,
        ),
      ),
      const SizedBox(width: 10),
      Text(
        'or',
        style: TextStyle(color: Colors.grey[600]),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Divider(
          color: Colors.grey[400],
          thickness: 1,
        ),
      ),
    ],
  ),);
}



Widget buildLinkedText({
 String? linkedText,
  String? linkedActionText,
  VoidCallback? onLinkTap,
}) {
  return  Padding(
          padding: const EdgeInsets.only(top: 16),
          child: GestureDetector(
            onTap: onLinkTap,
            child: RichText(
              text: TextSpan(
                text: linkedText,
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: ' $linkedActionText',
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
        );
}




/////////////////////////////////////////////social buttons ///////////////////////
Widget buildSocialButtons({
  required VoidCallback onFacebookPressed,
  required VoidCallback onGooglePressed,
  // required VoidCallback onEmailPressed,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildSocialButton(
        icon: Icons.facebook,
        color: Colors.blue,
        onPressed: onFacebookPressed,
      ),
      const SizedBox(width: 16),
      _buildSocialButton(
        icon: Icons.g_mobiledata,
        color: Colors.red,
        onPressed: onGooglePressed,
      ),
      // const SizedBox(width: 16),
      // _buildSocialButton(
      //   icon: Icons.alternate_email,
      //   color: Colors.lightBlue,
      //   onPressed: onEmailPressed,
      // ),
    ],
  );
}

Widget _buildSocialButton({
  required IconData icon,
  required Color color,
  required VoidCallback onPressed,
}) {
  return Material(
    color: Colors.transparent,
    shape: const CircleBorder(),
    child: InkWell(
      customBorder: const CircleBorder(),
      onTap: onPressed,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
    ),
  );
}



