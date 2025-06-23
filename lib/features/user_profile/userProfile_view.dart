import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/make_review/makeReview_widgets.dart';
import 'UserProfile_widgets.dart';
import 'user_image.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:image_picker/image_picker.dart';
File? _selectedImage;
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {


Future<void> _pickImage() async {
  final pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery, 
    imageQuality: 70, 
  );

  if (pickedFile != null) {
    setState(() {
      _selectedImage = File(pickedFile.path);
    });
  }
}

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

bool obscureOld = true;
bool obscureNew = true;
File? selectedImage;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    countryController.dispose();
    super.dispose();
  }

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

        ProfileHeader(
          userName: 'Nada Nasser',
          onImageChanged: (image) {
          selectedImage = image;
          },
        ),

             SizedBox(
              height: 40,
            ),
            buildSectionTitle("Personal Information"),
            buildTextField(
              hintText: "User Name",
              icon: Icons.person,
              controller: usernameController,
            ),
            buildTextField(
              hintText: "Email",
              icon: Icons.language,
              controller: emailController,
            ),
            buildTextField(
              hintText: "Old Password",
              icon: Icons.lock_outline,
              controller: oldPasswordController,
              isPassword: true,
              obscureText: obscureOld,
              togglePasswordVisibility: () {
                setState(() {
                  obscureOld =! obscureOld;
                });
              },
            ),

            buildTextField(
              hintText: "New Password",
              icon: Icons.lock,
              controller: newPasswordController,
              isPassword: true,
              obscureText: obscureNew,
              togglePasswordVisibility: () {
                setState(() {
                  obscureNew = !obscureNew;
                });
              },
            ),

            buildTextField(
              hintText: "Your Country",
              icon: Icons.language,
              controller: countryController,
            ),

            SizedBox(
              height: 90,
            ),

            buildReviewButton(
              label: "Update",
              onTap: () {
            //TODO Back-End : update the user profile here 
            // use this path to send image to backend >>> selectedImage?.path
            
          print('image: ${selectedImage?.path}');

            // Navigator.pop(context);
                          },
            ),
          ],
        ),
      ),
    );
  }
}

