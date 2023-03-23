import 'package:flutter/material.dart';
import 'package:law_bot/theme/theme.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
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
              height: isOpen ? 200 : 111,
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
                                  "Contact Us",
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
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          left: 45,
                                          right: 15,
                                          bottom: 10),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.mail_outline),
                                          const SizedBox(width: 15),
                                          Text(
                                            "ahmet@ahmetaydin.dev",
                                            style: TextStyle(
                                                color: ThemeManagement.instance
                                                    .currentTheme.primaryColor,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          left: 45,
                                          right: 15,
                                          bottom: 10),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.web_sharp),
                                          const SizedBox(width: 15),
                                          Text(
                                            "ahmetaydin.dev",
                                            style: TextStyle(
                                                color: ThemeManagement.instance
                                                    .currentTheme.primaryColor,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
