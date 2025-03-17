import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/core/utils/fonts.dart';
import 'package:localproductsfinder/core/utils/string.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}


class _SplashState extends State<Splash> {
  @override

  void initState(){
    super.initState();

   Timer(const Duration(seconds: 3),(){
   
     Navigator.pushReplacementNamed(context, Routes.home);
   });
  }
  





  @override
  Widget build(BuildContext context) {

    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
    backgroundColor: MyColors.backgroundColor,
    
 body: 
 
 
 Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(
              width: 100, 
              height: 100,
              child: Image.asset(Path.logo2), 
            ),

      SizedBox(
    width: MediaQuery.of(context).size.width * 0.9, 
    child:Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    
    Text(
      'Local Product',
      style: TextStyle(
        fontSize: 26,
        fontFamily: MyFonts.montserratFont,
        color: MyColors.fontColor,
      ),
    ),

    const SizedBox(height: 5),
    AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText(
          'F  i  n  d  e  r',
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: MyFonts.montserratFont,
            color: MyColors.buttonColor,
            letterSpacing: 3,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      isRepeatingAnimation: false,
    ),
  
        ]),),],
        ),
            ),
          
        );
  }
}

