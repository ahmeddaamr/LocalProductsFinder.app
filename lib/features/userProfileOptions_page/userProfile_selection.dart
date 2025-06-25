import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/home/widgets/bottom_nav_bar.dart';
import 'package:flutter_application_1/features/lg_in/login.dart';
import 'package:flutter_application_1/features/userProfileOptions_page/profileimage.dart';
import 'package:flutter_application_1/features/userProfileOptions_page/selection%20widgets.dart';
import 'package:flutter_application_1/features/user_profile/UserProfile_widgets.dart';
import 'package:flutter_application_1/features/user_profile/userProfile_view.dart';
import 'package:flutter_application_1/features/user_profile/user_model.dart';
// import 'package:flutter_application_1/shared/globals.dart';

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
            const SizedBox(height: 20),
            buildHeader(context: context, title: 'Profile' , onTap: () { Navigator.pushReplacementNamed(context, Routes.home );} ),
            const SizedBox(height: 30),
            ProfileAvatar(
              userName: currentUser?.name ?? '',
              imagePath: currentUser?.imagePath ?? '',
            ),
            buildUserEmail(currentUser?.email ?? ''),
            const SizedBox(height: 40),
            const SizedBox(height: 40),
            buildProfileOption(
              icon: Icons.person,
              label: "Edit profile",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileView()),
                );
              },
            ),
            buildProfileOption(
              icon: Icons.logout,
              label: "Log out ?",
              onTap: () =>
            
                Navigator.pushReplacementNamed(context, Routes.login)
                
              ,
            ),
            
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar( selectedIndex: 2, ),
    );
  }
}
