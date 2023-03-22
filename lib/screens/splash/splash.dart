import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:law_bot/screens/init_screen/init_screen.dart';
import 'package:law_bot/screens/login/login_screen.dart';
import 'package:law_bot/theme/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth=FirebaseAuth.instance;
    return EasySplashScreen(
      logo: Image.asset(
        "assets/logo.png",
        color: ThemeManagement.instance.currentTheme.primaryColor,
      ),
      logoWidth: 150,
      backgroundColor:
          ThemeManagement.instance.currentTheme.scaffoldBackgroundColor,
      loaderColor: ThemeManagement.instance.currentTheme.primaryColor,
      showLoader: true,
      navigator: const InitScreen(),
      durationInSeconds: 5,
      loadingText: Text(
        "Loading...",
        style: TextStyle(
            color: ThemeManagement.instance.currentTheme.primaryColor),
      ),
    );
  }
}
