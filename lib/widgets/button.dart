import 'package:flutter/material.dart';
import 'package:law_bot/theme/theme.dart';
import 'package:law_bot/utils/listener_widget.dart';

class StandardButton extends StatelessWidget {
  const StandardButton({
    required this.text,
    required this.onPressed,
    this.primary,
    this.onPrimary,
    Key? key,
  }) : super(key: key);
  final String text;
  final Color? primary;
  final Color? onPrimary;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListenerWidget(
        notifier: ThemeManagement.instance,
        builder: (context, ThemeManagement theme) {
          return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: primary ?? theme.currentTheme.primaryColor,
                  foregroundColor:
                      onPrimary ?? theme.currentTheme.scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: onPressed,
              child: Text(text));
        });
  }
}
