import 'package:flutter/material.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/pages/home_page.dart';
import 'package:lokerify/view/pages/register_page.dart';
import 'package:lokerify/view_model/auth_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    void showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      ));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Lottie.asset('assets/login.json',
                    height: 250, fit: BoxFit.cover)),
            Text(
              'Log In',
              style: titleStyle.copyWith(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Email',
                style: subtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  filled: true,
                  fillColor: const Color(0xffF1F0F5),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Password',
                style: subtitleStyle,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: passwordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    filled: true,
                    fillColor: const Color(0xffF1F0F5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primaryColor),
                    child: TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await authProvider
                            .login(emailCtrl.text, passwordCtrl.text)
                            .then((result) {
                          if (result != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                          } else {
                            showError(authProvider.message);
                          }
                        });
                        Future.delayed(
                          const Duration(seconds: 4),
                          () {
                            setState(() {
                              isLoading = false;
                            });
                          },
                        );
                      },
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              'Let\'s Go',
                              style: subtitleStyle.copyWith(color: whiteColor),
                            ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ));
                  },
                  child: Text(
                    'Create New Account',
                    style: subtitleStyle.copyWith(
                        color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
