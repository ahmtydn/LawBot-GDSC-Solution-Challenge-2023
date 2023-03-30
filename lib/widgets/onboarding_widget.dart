import 'package:flutter/material.dart';
import 'package:law_bot/theme/theme.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Image.asset(image, height: 350),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color:
                  ThemeManagement.instance.currentTheme.scaffoldBackgroundColor,
              fontSize: 22,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 15),
        Text(
          description,
          style: TextStyle(
              color:
                  ThemeManagement.instance.currentTheme.scaffoldBackgroundColor,
              fontSize: 20,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
