import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/shared_widgets/sighn_up&log_in.dart';
import 'package:flutter_application_1/features/user_profile/user_model.dart';

class LoginPage extends StatefulWidget {
  final bool isNewUser;
  const LoginPage({super.key, this.isNewUser = false});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              buildPageHeader(context: context, title: 'Log in'),
              buildTextField('E-mail', _emailController),
              buildTextField('Password', _passwordController,
                  obscureText: true),
              const SizedBox(height: 60),
              buildMainButton(
                  buttonText: 'Log in',
                  onPressed: () {
                    if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all fields."),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }

                    // ENTER USER INFO HERE AFTER CHECkING 
                    currentUser = UserModel(
                      name: "Nada Nasser Mostafa",
                      email: "Nada123@gmail.com",
                      password: "123",
                      country: "Egypt",
                      imagePath:null,
                    );
// if ( pass == pass from api && email == email from api ){
// ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Logged in successfully"),
//     backgroundColor: Color.fromARGB(255, 76, 223, 74),
//         ),
//       );

                    if (widget.isNewUser) {
                      Navigator.pushReplacementNamed(context, Routes.onBording);
                    } else {
                      Navigator.pushReplacementNamed(context, Routes.home);
                    }
//     } else {

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Invalid email or password."),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//     }
                    
                  }),
              const SizedBox(height: 40),
              buildLine(),
              const SizedBox(height: 40),
              buildSocialButtons(
                onFacebookPressed: () {},
                onGooglePressed: () {},
                // onEmailPressed: () {}
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
