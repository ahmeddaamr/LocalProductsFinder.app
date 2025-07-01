import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/core/const/config.dart';
// import 'package:flutter_application_1/core/storage/storage.dart' as Storage;
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/home/widgets/bottom_nav_bar.dart';
// import 'package:flutter_application_1/features/login/view/login.dart';
import 'package:flutter_application_1/features/userProfileOptions_page/profileimage.dart';
import 'package:flutter_application_1/features/userProfileOptions_page/selection%20widgets.dart';
import 'package:flutter_application_1/features/user_profile/UserProfile_widgets.dart';
import 'package:flutter_application_1/features/user_profile/userProfile_view.dart';
import 'package:flutter_application_1/features/user_profile/user_model.dart';
import 'package:flutter_application_1/core/storage/storage.dart';
// import 'package:http/http.dart';
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
            buildHeader(
              context: context,
              title: 'Profile',
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.home);
              },
            ),
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
            // buildProfileOption(
            //   icon: Icons.logout,
            //   label: "Log out ?",
            //   onTap: () async {
            //     try {
            //       final response = await http.delete(
            //         Uri.parse('${config.URI}/user/logout'),
            //         headers: {
            //           'Content-Type': 'application/json',
            //           'Authorization': 'Bearer ${await readToken()}',
            //         },
            //       );

            //       if (response.statusCode == 204 ||
            //           response.statusCode == 200) {
            //         await deleteToken();
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(content: Text('Logged out successfully')),
            //         );
            //         Navigator.pushReplacementNamed(context, Routes.login);
            //       } else {
            //         final body = jsonDecode(response.body);
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(
            //             content: Text(
            //               'Failed to log out: ${body['error'] ?? 'Unknown error'}',
            //             ),
            //           ),
            //         );
            //       }
            //     } catch (e) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text('Failed to log out: $e')),
            // //       );
            //     }
            //   },
            // ),
          
              buildProfileOption(
              icon: Icons.logout,
              label: "Log out ?",
              onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logged out successfully')),
                    );
                Navigator.pushReplacementNamed(context, Routes.login);
                
              }
            ),
          
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 3),
    );
  }
}
