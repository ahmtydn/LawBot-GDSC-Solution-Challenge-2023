import 'package:flutter/material.dart';
import 'package:law_bot/theme/theme.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: isOpen ? 320 : 111,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: ThemeManagement
                                      .instance.currentTheme.primaryColor,
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  "About App",
                                  style: TextStyle(
                                      color: ThemeManagement
                                          .instance.currentTheme.primaryColor,
                                      fontSize: 23),
                                ),
                                const Spacer(),
                                isOpen
                                    ? const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        // color: primaryColor,
                                      )
                                    : const Icon(
                                        Icons.keyboard_arrow_right,
                                        // color: primaryColor,
                                      ),
                              ],
                            ),
                          ),
                          isOpen
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 45,
                                      right: 15,
                                      bottom: 10),
                                  child: Text(
                                    "Our project aims to develop an application that will help lawyers and judges by combining the subjects of law and artificial intelligence. This application will analyze the details in a case file using artificial intelligence and as a result predict a constitutional case outcome. In this way, the decision-making processes of lawyers and judges will be faster and more accurate.",
                                    style: TextStyle(
                                        color: ThemeManagement
                                            .instance.currentTheme.primaryColor,
                                        fontSize: 15),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
