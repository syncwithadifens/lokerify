import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/pages/home_page.dart';
import 'package:lokerify/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

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
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 105,
                  height: 105,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColor,
                    border: Border.all(color: primaryColor),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColor,
                    image: authProvider.avatar != null
                        ? DecorationImage(
                            image: FileImage(File(authProvider.avatar!.path)),
                            fit: BoxFit.cover)
                        : const DecorationImage(
                            image: AssetImage('assets/avatar.jpg'),
                            fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                    right: 8,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () => authProvider.selectImg(),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                          border: Border.all(color: whiteColor, width: 2),
                        ),
                        child: Icon(
                          Icons.add,
                          color: whiteColor,
                        ),
                      ),
                    )),
              ],
            )),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  'Fill in your data',
                  style: titleStyle.copyWith(fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Name',
                style: subtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                controller: nameCtrl,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
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
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Email',
                style: subtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
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
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Password',
                style: subtitleStyle,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: passwordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: authProvider.isHide,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => authProvider.showPassword(),
                      icon: Icon(
                        Icons.visibility,
                        color: primaryColor,
                      ),
                    ),
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
            authProvider.isLoading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primaryColor),
                    child: TextButton(
                      onPressed: () async {
                        authProvider.showLoading();
                        await authProvider
                            .register(emailCtrl.text, passwordCtrl.text,
                                nameCtrl.text)
                            .then((result) {
                          if (result == 'ok') {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                          } else {
                            Future.delayed(
                              const Duration(seconds: 2),
                              () {
                                authProvider.showLoading();
                                showError(authProvider.message);
                              },
                            );
                          }
                        });
                      },
                      child: Text(
                        'Yeahhh',
                        style: subtitleStyle.copyWith(color: whiteColor),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: subtitleStyle.copyWith(
                        color: Colors.grey, fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Log In',
                        style: subtitleStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
