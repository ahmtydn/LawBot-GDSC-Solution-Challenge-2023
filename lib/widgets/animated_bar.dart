import 'package:flutter/material.dart';
import 'package:law_bot/theme/theme.dart';

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 4,
      width: isActive ? 12 : 0,
      margin: const EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
          color: ThemeManagement.instance.currentTheme.primaryColorLight,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}
