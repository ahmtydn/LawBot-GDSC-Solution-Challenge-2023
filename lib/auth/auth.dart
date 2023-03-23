import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class BotAuth with ChangeNotifier {
  static BotAuth? _instance;
  static BotAuth get instance {
    _instance ??= BotAuth();
    return _instance!;
  }

  late User _user;
  bool signed = false;

  User get user {
    return _user;
  }

  BotAuth() {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      signed = event != null;
      if( event != null) {
        _user = event;
      }
      notifyListeners();
    });
  }

  Future<void> logOut() async {
    return FirebaseAuth.instance.signOut();
  }
}
