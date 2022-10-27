import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/pages/home_page.dart';
import 'package:lokerify/view/pages/register_page.dart';
import 'package:lokerify/view_model/auth_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

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

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.grey,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: whiteColor,
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
                  textInputAction: TextInputAction.next,
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
                              .login(emailCtrl.text, passwordCtrl.text)
                              .then((result) {
                            if (result != null) {
                              authProvider.showLoading();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ));
                            } else {
                              showError(authProvider.message);
                            }
                          });
                          Future.delayed(
                            const Duration(seconds: 4),
                            () => authProvider.showLoading(),
                          );
                        },
                        child: Text(
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
                        builder: (context) => RegisterPage(),
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
      ),
    );
  }
}
