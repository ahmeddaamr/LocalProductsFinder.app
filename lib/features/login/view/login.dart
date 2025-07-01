import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/shared_widgets/sighn_up&log_in.dart';
import 'package:flutter_application_1/core/storage/storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/core/const/config.dart';
import 'package:flutter_application_1/features/user_profile/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // final url = config.URI+'/user/login';
  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('${config.URI}/user/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return {
      'token': data['token'],
      'user': data['user'],
    };
  } else {
    print('Login failed: ${response.body}');
    return null;
  }
}

  
  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }

  // bool _isLoading = false;

// void  handleSignUp() {
//   setState(() {
//     //true
//     _isLoading = false;
//   });

// Future.delayed(const Duration(seconds: 2), () {
//     setState(() {
//       _isLoading = false;
//     });
// )};
 
  
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: 
        SingleChildScrollView(
          // padding: const EdgeInsets.symmetric(horizontal: 8,),
          child: Column(
            children: [
              buildPageHeader(context: context, title: 'Log in'),
              buildTextField('E-mail', _emailController),
              // const SizedBox(height: 16),
              buildTextField('Password', _passwordController, obscureText: true),
              const SizedBox(height: 60),
              buildMainButton(
                buttonText:'Log in',
                onPressed:  () async {
                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all fields.')),
                    );
                    return;
                  }
                  try {
                    final result = await loginUser(_emailController.text, _passwordController.text);
                    
                    if (result != null) {
                      final token = result['token'] as String;
                      final userData = result['user'] as Map<String, dynamic>;

                      await saveToken(token);
                      
                      currentUser = UserModel(
                        name: userData['username'],
                        email: userData['email'],
                        password: _passwordController.text,  // Or store null for security if you don’t need it
                        country: userData['country']??'Egypt',
                        imagePath: null,  // You can adjust this if you have image in response
                      );

                      Navigator.pushReplacementNamed(context, Routes.home);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid credentials')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login error: $e')),
                    );
                  }
                }
              ),
                const SizedBox(height: 40),
                buildLine(),
                const SizedBox(height: 40),
                buildSocialButtons(
            onFacebookPressed: () {},
            onGooglePressed: () {
              // saveToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjg1YmU3MzQ0MmRiMjdkMjlmYjk0MjdjIn0.0QRrqvjUqxXtZEKP8ap1QLLkDG_6B1DtzR2CJw4vXeM")
              Navigator.pushReplacementNamed(context, Routes.home);
            },
          ),
          const SizedBox(height: 30),
          buildLinkedText(
            linkedText: "Don't have an account?",
            linkedActionText: 'Sign up',
            onLinkTap: () {
              Navigator.pushReplacementNamed(context, Routes.signUp);
            },
          ),

            ],
          ),
        ),
      ),
    );
  }

  




}