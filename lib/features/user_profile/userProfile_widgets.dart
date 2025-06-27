import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/core/utils/fonts.dart';
// import 'package:flutterrequired BuildContext context, _application_1/core, required Future<Object?> Function() onTap, required Future<Object?> Function() onTap, required Future<Object?> Function() onTap/utils/string.dart';


Widget buildHeader({
  required BuildContext context,
  String? title,
 required VoidCallback onTap,
}) {
  return Row(
    children: [
      IconButton(
        icon: Icon(
          Icons.arrow_back_ios_sharp,
          color: MyColors.arrowColor,
          size: 18,
        ),
        onPressed: onTap ,
      ),
      Text(
        title ?? '',
        style: TextStyle(
          fontFamily: MyFonts.montserratFont,
          fontSize: 20,
          fontWeight: FontWeight.w200,
        ),
      ),
    ],
  );
}


///////////////////////////////////////////////////////////////////////


Widget buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
   
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

/////////////////////////////////////////////

Widget buildTextField({
  required String hintText,
  required IconData icon,
  required TextEditingController controller,
  bool isPassword = false,
  bool obscureText = true,
  void Function()? togglePasswordVisibility,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),

    child: 
    SizedBox(
  height: 45, 
  child:
    
    TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      cursorColor: Colors.grey,
    


      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintText: hintText,
        prefixIcon: Icon(icon),
        suffixIcon: isPassword


            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                  color: Colors.grey,
                ),

                onPressed: togglePasswordVisibility,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent, 

              )
            : null,


        filled: true,
        fillColor: Colors.grey.shade200,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),

        hintStyle: TextStyle(
          fontSize: 14, 
           color: Colors.black87,
        ),


      ),
    ),),
  );
}


////////////////////////////////////////////////

Widget buildUpdateButton({
  required String label,
  required VoidCallback onTap,
}) {
  return ElevatedButton(
    onPressed: onTap,

    style: ElevatedButton.styleFrom(
            fixedSize: const Size(330, 48),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),


       child: Text(
        label,
        style: TextStyle(
           fontSize: 15 , 
          
          color: Colors.white,),
      ),
    );
  
}
