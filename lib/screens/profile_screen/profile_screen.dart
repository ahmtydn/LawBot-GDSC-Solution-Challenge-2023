import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:law_bot/auth/auth.dart';
import 'package:law_bot/utils/listener_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListenerWidget(
            notifier: BotAuth.instance,
            builder: (context, snapshot) {
              return Column(
                children: [
                  const Center(child: Text("Profile")),
                  TextButton(
                      onPressed: () async {
                        BotAuth.instance.logOut();
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      child: const Text("Sign Out"))
                ],
              );
            }));
  }
}
