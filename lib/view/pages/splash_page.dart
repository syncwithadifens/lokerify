import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/pages/login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
      ),
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
            Text(
              'Lokerify',
              style: titleStyle,
            ),
            Text(
              'Cari pekerjaanmu secepatnya',
              style: subtitleStyle,
            )
          ],
        ),
      ),
    );
  }
}
