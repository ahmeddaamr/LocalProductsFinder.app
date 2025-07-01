import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/fonts.dart';
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

Widget buildCountryDropdownField({
  required IconData icon,
  required TextEditingController controller,
  required List<String> countries,
}) {
  
  final uniqueCountries = countries.toSet().toList();

 
  if (controller.text.isNotEmpty &&
      !uniqueCountries.contains(controller.text)) {
    uniqueCountries.add(controller.text);
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: SizedBox(
      height: 45,
      child: DropdownButtonFormField<String>(
        value: controller.text.isNotEmpty ? controller.text : null,
        onChanged: (value) {
          controller.text = value!;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          hintText: "Country",
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down),
        dropdownColor: Colors.white,
        menuMaxHeight: 200,
        items: uniqueCountries
            .map((country) => DropdownMenuItem<String>(
                  value: country,
                  child: Text(
                    country,
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ))
            .toList(),
      ),
    ),
  );
}

/////////////////////////////////////
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
