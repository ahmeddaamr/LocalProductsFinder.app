import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/features/home/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localproductsfinder/core/utils/string.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

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
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('seenOnboarding', false);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
      backgroundColor: MyColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Row (Back Arrow & Skip)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentIndex > 0)
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_sharp,
                          color: MyColors.arrowColor),
                      onPressed: () {
                        if (currentIndex > 0) {
                          _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                    ),
                  const Spacer(),
                  TextButton(
                    onPressed: skipOnboarding,
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          fontSize: 16,
                          color: MyColors.greenColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // PageView content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  final data = onboardingData[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(data["image"]!, height: 200),
                      const SizedBox(height: 20),
                      Text(
                        data["title"]!,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          data["description"]!,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // ...
            const SizedBox(height: 15),

            // Dots Indicator (moved to start)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // <-- left-aligned
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
            ),

            const SizedBox(height: 30), // optional spacing before button

            // Next/Start Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: nextScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.greenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
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

            const SizedBox(height: 50), // add bottom space to avoid screen edge
          ],
        ),
      ),
    );
  }
}
