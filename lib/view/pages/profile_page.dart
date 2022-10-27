import 'package:flutter/material.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/pages/login_page.dart';
import 'package:lokerify/view/widgets/avatar.dart';
import 'package:lokerify/view/widgets/custom_navigation_bar.dart';
import 'package:lokerify/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_fab.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      floatingActionButton: const CustomFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomNavigationBar(),
      body: authProvider.isLoading
          ? Center(
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
                        authProvider.name,
                        style: titleStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${authProvider.userEmail}',
                        style: subtitleStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTap: () => authProvider.logout().then((value) =>
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (route) => false)),
                        child: Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: Text(
                              'Log Out',
                              style: subtitleStyle.copyWith(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
    );
  }
}
