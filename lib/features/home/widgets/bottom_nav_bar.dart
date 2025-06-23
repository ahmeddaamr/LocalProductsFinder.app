import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/string.dart';



class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // TODO: Implement Navigation to Different Pages
    switch (index) {
      case 0:
       Navigator.pushReplacementNamed(context, Routes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, Routes.camera);
        break;
case 2:
       Navigator.pushReplacementNamed(context, Routes.review);
        break;


       case 3:
        Navigator.pushReplacementNamed(context, Routes.profile);
         break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: MyColors.whiteColor,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.camera_alt_rounded), label: ''),

//         BottomNavigationBarItem(icon: Image.asset(Path.image
//     , // Path to your image
//     width: 24, // Adjust width as needed
//     height: 24, // Adjust height as needed
//   ),
//   label: '', // Keep empty if no text is needed
// ),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        
      ],
    );
  }
}
