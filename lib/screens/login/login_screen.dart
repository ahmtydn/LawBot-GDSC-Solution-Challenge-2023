import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:law_bot/screens/init_screen/init_screen.dart';
import 'package:law_bot/theme/theme.dart';

const users = {
  'ahmet@gmail.com': '12345',
};

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => const Duration(milliseconds: 2250);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String?> _authUser(LoginData data) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: data.name, password: data.password);
      if (user.user != null) {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    throw Exception();
  }

  Future<String?> _signupUser(SignupData data) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: data.name!, password: data.password!);
      if (user.user != null) {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    throw Exception();
  }

  Future<String?>? _recoverPassword(String name) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: FlutterLogin(
        theme: LoginTheme(
            accentColor: Colors.white,
            inputTheme: const InputDecorationTheme(
                iconColor: Colors.black,
                hoverColor: Colors.black,
                suffixIconColor: Colors.black,
                prefixIconColor: Colors.black,
                focusColor: Colors.black,
                prefixStyle: TextStyle(color: Colors.black)),
            buttonTheme: LoginButtonTheme(
              backgroundColor:
                  ThemeManagement.instance.currentTheme.primaryColorLight,
            ),
            primaryColor:
                ThemeManagement.instance.currentTheme.primaryColorLight,
            switchAuthTextColor:
                ThemeManagement.instance.currentTheme.hintColor,
            buttonStyle: TextStyle(
                color: ThemeManagement.instance.currentTheme.primaryColor),
            pageColorDark:
                ThemeManagement.instance.currentTheme.scaffoldBackgroundColor,
            primaryColorAsInputLabel: false,
            pageColorLight:
                ThemeManagement.instance.currentTheme.scaffoldBackgroundColor),
        hideForgotPasswordButton: true,
        title: 'LawBot',
        onLogin: _authUser,
        userType: LoginUserType.email,
        onSignup: _signupUser,
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const InitScreen(),
          ));
        },
        onRecoverPassword: _recoverPassword,
      ),
    );
  }
}
