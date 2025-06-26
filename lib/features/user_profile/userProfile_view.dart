import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/make_review/makeReview_widgets.dart';
import 'package:flutter_application_1/features/user_profile/user_model.dart';
import 'package:flutter_application_1/features/user_profile/user_update_logic.dart';
import 'UserProfile_widgets.dart';
import 'user_image.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  ////////////////////////controllers/////////////////////
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController countryController;

  bool obscureOld = true;
  bool obscureNew = true;
  File? selectedImage;
  
  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: currentUser?.name ?? '');
    emailController = TextEditingController(text: currentUser?.email ?? '');
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    countryController = TextEditingController(text: currentUser?.country ?? '');
  
  }

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
            const SizedBox(height: 20),
            buildHeader(context: context, title: 'Profile', onTap: () { Navigator.pushReplacementNamed(context, Routes.editProfile );}),
            const SizedBox(height: 30),
         
            ProfileHeader(
              userName: currentUser?.name ?? '',
              initialImagePath: currentUser?.imagePath,
              onImageChanged: (image) {
                selectedImage = image;
               
              },
            ),
         
            const SizedBox(height: 40),
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
                  obscureOld = !obscureOld;
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
            const SizedBox(height: 90),
           buildReviewButton(
  label: "Update",
 onTap: () {

  final updatedUser = UserUpdateHelper.getUpdatedUser(
    currentUser: currentUser!,
    newName: usernameController.text,
    newEmail: emailController.text,
    newPassword: newPasswordController.text,
    newCountry: countryController.text,
    newImagePath: selectedImage?.path, 
  );
  if (updatedUser != null) {
    setState(() {
      currentUser = updatedUser;
    
    
    
    });
    
    // TODO: Call the API here to save user new  updated data by that list >>>  currentUser that carries all user info 



 ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Changed successfully."),
        
      ),
    );

  } else {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("No changes made.")),
    );
oldPasswordController.clear();
newPasswordController.clear();
  }


},


),

          ],
        ),
      ),
    );
  }
}
