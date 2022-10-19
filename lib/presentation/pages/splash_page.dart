import 'package:flutter/material.dart';
import 'package:lokerify/presentation/pages/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      ),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
            const Text('Lokerify'),
            const Text('Cari pekerjaanmu secepatnya')
          ],
        ),
      ),
    );
  }
}
