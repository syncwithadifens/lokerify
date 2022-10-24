import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/pages/login_page.dart';
import 'package:lokerify/view/widgets/avatar.dart';
import 'package:lokerify/view/widgets/custom_navigation_bar.dart';
import 'package:lokerify/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    setState(() {
      name = (snapshot.data() as Map<String, dynamic>)['name'];
      email = (snapshot.data() as Map<String, dynamic>)['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
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
                  name,
                  style: titleStyle,
                ),
              ),
              Expanded(
                child: Text(
                  email,
                  style: subtitleStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () => authProvider.logout().then((value) =>
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
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
      ),
    );
  }
}
