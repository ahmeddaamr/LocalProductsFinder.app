import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/features/home/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/core/utils/string.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": Path.onBoarding1,
      "title": "Support Local Products",
      "description":
          "Discover and choose locally made products while reading honest reviews from other users."
    },
    {
      "image": Path.onBoarding2,
      "title": "Search by Image",
      "description":
          "Easily find product details by taking a picture! Get instant info and discover local alternatives in just one tap."
    },
    {
      "image": Path.onBoarding3,
      "title": "Local vs Non Local",
      "description":
          "Discover what's local! Our app helps you identify local and non-local products instantly."
    },
    {
      "image": Path.onBoarding4,
      "title": "Find Local Alternatives",
      "description":
          "Easily discover locally made alternatives for your favorite products. Support local businesses and make informed choices!"
    },
  ];

  void nextScreen() async {
    if (currentIndex < onboardingData.length - 1) {
      setState(() => currentIndex++);
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('seenOnboarding', false);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  void previousScreen() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  void skipOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Top Row (Back Arrow & Skip)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentIndex > 0) // Show back arrow only if index > 0
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_sharp, color: Color.fromARGB(255, 69, 66, 66)),
                      onPressed: previousScreen,
                    ),
                  const Spacer(), 
                  TextButton(
                    onPressed: skipOnboarding,
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(onboardingData[currentIndex]["image"]!,
                        height: 250),
                    const SizedBox(height: 20),
                    Text(
                      onboardingData[currentIndex]["title"]!,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      onboardingData[currentIndex]["description"]!,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  onboardingData.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: currentIndex == index ? 10 : 8,
                    height: currentIndex == index ? 10 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? MyColors.greenColor
                          : Colors.grey,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Next/Started Button (Moved to Bottom Right)
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 40, left: 100), // Moved right
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: nextScreen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.greenColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentIndex == onboardingData.length - 1
                              ? "Started"
                              : "Next",
                          style: TextStyle(color: MyColors.whiteColor),
                        ),
                        const SizedBox(width: 8),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
