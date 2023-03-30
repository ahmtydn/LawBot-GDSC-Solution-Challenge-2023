import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BotService with ChangeNotifier {
  static BotService? _instance;
  static BotService get instance {
    _instance ??= BotService();
    return _instance!;
  }

  late User _user;
  bool signed = false;
  bool onboard = false;

  User get user {
    return _user;
  }

  BotService() {
    checkOnboard();
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      signed = event != null;
      if (event != null) {
        _user = event;
      }
      notifyListeners();
    });
  }

  Future<void> checkOnboard() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    onboard = preferences.getBool("onboard") ?? false;
    notifyListeners();
  }

  void clearShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("onboard");
  }

  Future<void> logOut() async {
    return FirebaseAuth.instance.signOut();
  }
}
