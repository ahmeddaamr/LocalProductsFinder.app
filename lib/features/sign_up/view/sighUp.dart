import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/features/lg_in/login.dart';
import 'package:flutter_application_1/features/shared_widgets/sighn_up&log_in.dart';
import 'package:flutter_application_1/core/utils/string.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: 
      Padding(
      
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildPageHeader(context: context, title: 'Create Account'),
              buildTextField('Username', _usernameController),
              buildTextField('E-mail', _emailController),
              buildTextField('Password', _passwordController,
                  obscureText: true),
              buildTextField('Country', _countryController),
              const SizedBox(height: 40),
              buildMainButton(
                  buttonText: 'Sign up',
                    onPressed: () {
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

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage(isNewUser: true ,)),
                    );
                    
                  }),
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
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
