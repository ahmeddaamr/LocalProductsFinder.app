import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/core/const/config.dart';
import 'package:flutter_application_1/core/storage/storage.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
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
  // static const List<String> countryList = [
  //   "United States",
  //   "Canada",
  //   "United Kingdom",
  //   "Germany",
  //   "France",
  //   "Egypt",
  //   "India",
  //   "China",
  //   "Australia",
  //   "Brazil",
  //   "Saudi Arabia",
  //   "South Africa",
  //   "Japan",
  //   // 👉 Add more countries as needed
  // ];
  // final url = config.URI;
  Future<String?> signupUser(
    String username,
    String email,
    String password,
    String country,
  ) async {
    print("pre-request");
    final response = await http.post(
      Uri.parse('${config.URI}/user/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'country': country,
      }),
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

  bool isStrongPassword(String password) {
    final passwordRegEx = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    );
    return passwordRegEx.hasMatch(password);
  }

  bool isValidEmail(String email) {
    final emailRegEx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegEx.hasMatch(email);
  }

  Widget buildCountryDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8),

      child: SizedBox(
        height: 50.0,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            hintStyle: TextStyle(color: MyColors.arrowColor, fontSize: 13),
            labelText: 'Country',
            filled: true,
            fillColor: MyColors.loginInputColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          value:
              _countryController.text.isNotEmpty
                  ? _countryController.text
                  : null,
          items:
              countriesList.map((country) {
                return DropdownMenuItem(value: country, child: Text(country));
              }).toList(),
          dropdownColor:
              MyColors.loginInputColor, // Change dropdown background color
          onChanged: (value) {
            if (value != null) {
              _countryController.text = value;
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildPageHeader(context: context, title: 'Create Account'),
              buildTextField('Username', _usernameController),
              buildTextField('E-mail', _emailController),
              buildTextField(
                'Password',
                _passwordController,
                obscureText: true,
              ),
              buildCountryDropdown(),
              const SizedBox(height: 40),
              buildMainButton(
                buttonText: 'Sign up',
                onPressed: () {
                  final password = _passwordController.text.trim();
                  final email = _emailController.text.trim();

                  if (!isValidEmail(email)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid email address.'),
                      ),
                    );
                    return;
                  }
                  if (!isStrongPassword(password)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Password must be at least 8 characters long including uppercase, lowercase, number, and special character.',
                        ),
                      ),
                    );
                    return;
                  }
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
                  signupUser(
                    _usernameController.text,
                    _emailController.text,
                    _passwordController.text,
                    _countryController.text,
                  ).then((token) async {
                    if (token != null) {
                      // Save token to secure storage or state management
                      await saveToken(token);
                      currentUser = UserModel(
                        name: _usernameController.text,
                        email: _emailController.text,
                        password:
                            _passwordController
                                .text, // Or store null for security if you don’t need it
                        country: _countryController.text,
                        imagePath:
                            null, // You can adjust this if you have image in response
                      );
                      Navigator.pushReplacementNamed(context, Routes.onBording);
                    } else {
                      // Handle login failure
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Signup failed. Please try again.'),
                        ),
                      );
                    }
                  });

                  //Navigator.pushReplacementNamed(context, Routes.login);
                },
              ),
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
