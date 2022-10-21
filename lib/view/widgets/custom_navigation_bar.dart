import 'package:flutter/material.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/pages/home_page.dart';
import 'package:lokerify/view/pages/profile_page.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    void navbarLogic(int index) {
      currentIndex = index;
      if (index == 0) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else if (index == 1) {
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProfilePage(),
          ),
        );
      }
    }

    return BottomNavigationBar(
      backgroundColor: whiteColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedItemColor: primaryColor,
      currentIndex: currentIndex,
      onTap: (value) => navbarLogic(value),
      items: [
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/office.png',
              height: 30,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/category.png',
              height: 30,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/profile.png',
              height: 30,
            ),
            label: ''),
      ],
    );
  }
}
