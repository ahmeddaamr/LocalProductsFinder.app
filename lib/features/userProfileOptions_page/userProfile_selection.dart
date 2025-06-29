import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localproductsfinder/core/const/config.dart';
// import 'package:localproductsfinder/core/storage/storage.dart' as Storage;
import 'package:localproductsfinder/core/utils/string.dart';
import 'package:localproductsfinder/features/home/widgets/bottom_nav_bar.dart';
import 'package:localproductsfinder/features/reviewsHistory/view/reviewHistoryView.dart';
// import 'package:localproductsfinder/features/login/view/login.dart';
import 'package:localproductsfinder/features/userProfileOptions_page/profileimage.dart';
import 'package:localproductsfinder/features/userProfileOptions_page/selection%20widgets.dart';
import 'package:localproductsfinder/features/user_profile/UserProfile_widgets.dart';
import 'package:localproductsfinder/features/user_profile/userProfile_view.dart';
import 'package:localproductsfinder/features/user_profile/user_model.dart';
import 'package:localproductsfinder/core/storage/storage.dart';
// import 'package:http/http.dart';
// import 'package:localproductsfinder/shared/globals.dart';

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
            buildProfileOption(
              icon: Icons.history, 
              label: "Review History", 
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReviewHistoryPage()),
                );
              },
            ),
            buildProfileOption(
              icon: Icons.logout,
              label: "Log out ?",
              onTap: () async {
                try {
                  final response = await http.delete(
                    Uri.parse('${config.URI}/user/logout'),
                    headers: {
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer ${await readToken()}',
                    },
                  );

                  if (response.statusCode == 204 ||
                      response.statusCode == 200) {
                    await deleteToken();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logged out successfully')),
                    );
                    Navigator.pushReplacementNamed(context, Routes.login);
                  } else {
                    final body = jsonDecode(response.body);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Failed to log out: ${body['error'] ?? 'Unknown error'}',
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to log out: $e')),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 3),
    );
  }
}
