import 'package:flutter/material.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/widgets/avatar.dart';
import 'package:lokerify/view/widgets/custom_navigation_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: const CustomNavigationBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 150),
          child: Column(
            children: [
              const Avatar(
                w: 100,
                h: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Afiv Dicky Efendy',
                  style: titleStyle,
                ),
              ),
              Text(
                'adifens@gmail.com',
                style: subtitleStyle,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Container(
                  width: 120,
                  height: 50,
                  color: primaryColor,
                  child: Center(
                    child: Text(
                      'Keluar',
                      style: subtitleStyle.copyWith(color: whiteColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
