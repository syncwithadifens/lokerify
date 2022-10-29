import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:lokerify/service/api_repository.dart';
import 'package:lokerify/theme/styles.dart';
import 'package:lokerify/view/pages/home_page.dart';
import 'package:lokerify/view/pages/splash_page.dart';
import 'package:lokerify/view_model/auth_provider.dart';
import 'package:lokerify/view_model/category_provider.dart';
import 'package:lokerify/view_model/job_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JobProvider>(
          create: (context) =>
              JobProvider(apiRepository: ApiRepository(Client())),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) =>
              CategoryProvider(apiRepository: ApiRepository(Client())),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lokerify',
        theme: ThemeData(primaryColor: primaryColor),
        home: FirebaseAuth.instance.currentUser != null
            ? const HomePage()
            : const SplashPage(),
      ),
    );
  }
}
