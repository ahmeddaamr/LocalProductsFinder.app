import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/userProfileOptions_page/profileimage.dart';
import 'package:flutter_application_1/features/userProfileOptions_page/selection%20widgets.dart';
import 'package:flutter_application_1/features/user_profile/UserProfile_widgets.dart';
import 'package:flutter_application_1/features/user_profile/userProfile_view.dart';
import 'package:flutter_application_1/features/user_profile/user_image.dart';

class UserProfileSelection extends StatefulWidget {
  const UserProfileSelection({Key? key}) : super(key: key);

  @override
  State<UserProfileSelection> createState() => _UserProfileSelectionState();
}

class _UserProfileSelectionState extends State<UserProfileSelection> {
  File? selectedImage;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor: Colors.white,
      body: SingleChildScrollView(


        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
          SizedBox(height: 20,),
            buildHeader(context: context, title:'Profile'),
            SizedBox(
              height: 30,
            ),

       ProfileAvatar(
  userName: "Nada Nasser",
  imagePath: " ", 
  onEditTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfileView()),
    );
  },
),


             SizedBox(
              height: 40,
            ),
          
        
  
              
        
        
        
        
        
        ],),),
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    );
  }
}