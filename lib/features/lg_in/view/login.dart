import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/shared_widgets/sighn_up&log_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  @override
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
                onPressed:  () {
                  //TODO : "Back-End"  check before navigation//

                  // if( checkLogin(_emailController.text, _passwordController.text)) {
                  // if  new user              
                  // Navigator.pushReplacementNamed(context, Routes.onBording);
                  // else existing user

                  Navigator.pushReplacementNamed(context, Routes.home);
                }
              ),
const SizedBox(height: 40),
buildLine(),
const SizedBox(height: 40),
 buildSocialButtons(
            onFacebookPressed: () {
              // TODO: Implement Facebook sign up logic


            },
            onGooglePressed: () {
              // TODO: Implement Google sign up logic



            },
            // onEmailPressed: () {
            //   // TODO: Implement Email sign up logic



              
            // },
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
