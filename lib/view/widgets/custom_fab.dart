import 'package:flutter/material.dart';

import '../../theme/styles.dart';
import '../pages/category_page.dart';

class CustomFab extends StatelessWidget {
  const CustomFab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: blackColor,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CategoryPage(),
          ),
        );
      },
      child: Image.asset(
        'assets/ic_category.png',
        width: 50,
        height: 50,
        color: whiteColor,
      ),
    );
  }
}
