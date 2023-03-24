import 'package:flutter/material.dart';
import 'package:law_bot/theme/theme.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({
    Key? key,
    required this.isCompleted,
  }) : super(key: key);
  final ValueNotifier<bool> isCompleted;

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  void initState() {
    widget.isCompleted.addListener(() {
      if (mounted) {
        if (widget.isCompleted.value) Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 180,
          child: Material(
            color: ThemeManagement.instance.currentTheme.cardColor,
            borderRadius: BorderRadius.circular(30),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Center(
                      child: CircularProgressIndicator(
                    color:
                        ThemeManagement.instance.currentTheme.primaryColorLight,
                  )),
                  const SizedBox(height: 10),
                  Text(
                    "Please sit back while LawBot \u{1F916} predicts the outcome of the case \u{1F600}",
                    style: TextStyle(
                        fontSize: 18,
                        color: ThemeManagement
                            .instance.currentTheme.primaryColorLight),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
