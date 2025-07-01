import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/reviewsHistory/view/reviewHistoryView.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final int productId;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    this.productId = 0,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return;
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, Routes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, Routes.camera);
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ReviewHistoryPage()),
        );
        break;
      case 3:
        Navigator.pushReplacementNamed(context, Routes.editProfile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: MyColors.whiteColor,

          // ✅ استخدم selectedIndex فقط إذا كان >= 0
          currentIndex: selectedIndex >= 0 ? selectedIndex : 0,

          // ✅ اعطلي التلوين لو selectedIndex < 0
          selectedItemColor: selectedIndex >= 0
              ? const Color.fromARGB(255, 13, 205, 36)
              : Colors.grey.withOpacity(0.0),

          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(size: 25),
          unselectedIconTheme: const IconThemeData(size: 26),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          onTap: (index) => _onItemTapped(context, index),

          items: List.generate(4, (index) {
            final icons = [
              Icons.home,
              Icons.camera_alt_rounded,
              Icons.star_purple500_sharp,
              Icons.person,
            ];
            return BottomNavigationBarItem(
              icon: Icon(
                icons[index],
                color: selectedIndex == index
                    ? const Color.fromARGB(255, 13, 205, 36)
                    : Colors.grey,
              ),
              label: '',
            );
          }),
        ),
      ),
    );
  }
}
