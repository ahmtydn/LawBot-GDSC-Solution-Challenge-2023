import 'package:flutter/material.dart';

class NewCaseScreen extends StatefulWidget {
  const NewCaseScreen({Key? key}) : super(key: key);

  @override
  State<NewCaseScreen> createState() => _NewCaseScreenState();
}

class _NewCaseScreenState extends State<NewCaseScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child:  Center(
        child: Text("New Case"),
      ),
    );
  }
}
