import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localproductsfinder/core/const/config.dart';
import 'package:localproductsfinder/core/storage/storage.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/features/shared_widgets/sighn_up&log_in.dart';
import 'package:localproductsfinder/core/utils/string.dart';

class signupPage extends StatefulWidget {
  const signupPage({super.key});

  @override
  State<signupPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<signupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _countryController = TextEditingController();
  // final url = config.URI;
  Future<String?> signupUser(String username,String email, String password, String country) async {
    print("pre-request");
    final response = await http.post(
      Uri.parse('${config.URI}/user/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username':username,'email': email, 'password': password,'country':country}),
    );
    
    if (response.statusCode == 201) {
      print("Signup successful");
      final data = jsonDecode(response.body);
      return data['token']; // Assuming response contains { "token": "..." }
    } else {
      print('Signup failed: ${response.body}');
      return null;
    }
  }


//   bool _isLoading = false;

// void handleLogin() {
//   setState(() {
//     //true
//     _isLoading = false;
//   });

  // Future.delayed(const Duration(seconds: 2), () {
  //   setState(() {
  //     _isLoading = false;
  //   });
  // });
// }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child:SingleChildScrollView(
       child: Column(children: [
            buildPageHeader(context: context, title: 'Create Account'),
            buildTextField('Username',_usernameController),
            buildTextField('E-mail',_emailController),
            buildTextField('Password',_passwordController, obscureText: true),
            buildTextField('Country',_countryController),
            const SizedBox(height: 40),
            buildMainButton(
              buttonText:'Sign up',
              onPressed: () {
                //TODO : Back-End "
                if (_usernameController.text.isEmpty ||
                      _emailController.text.isEmpty ||
                      _passwordController.text.isEmpty ||
                      _countryController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill in all fields."),
                        backgroundColor: Colors.redAccent,
                      ),
                      );
                      return;
                }
                signupUser(_usernameController.text,_emailController.text, _passwordController.text,_countryController.text).then((token) async {
                    if (token != null) {
                      // Save token to secure storage or state management
                      await saveToken(token);
                    Navigator.pushReplacementNamed(context, Routes.onBording);
                    } else {
                      // Handle login failure
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login failed. Please try again.')),
                      );
                    }
                  });

                //Navigator.pushReplacementNamed(context, Routes.login);
              } ),
          const SizedBox(height: 40),
          buildLine(),
          const SizedBox(height: 40),
          buildSocialButtons(
            onFacebookPressed: () {
              // TODO: Back-End Facebook sign up logic


            },
            onGooglePressed: () {
              // TODO: Back-End Google sign up logic



            },
            
          ),
          const SizedBox(height: 15),
          buildLinkedText(
              linkedText: "have an account?",
              linkedActionText: 'Log In',
              onLinkTap: () {
                Navigator.pushReplacementNamed(context, Routes.login);
              },),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),);
  }
}
