import 'package:flutter/material.dart';
import 'package:law_bot/screens/home/home_screen.dart';
import 'package:law_bot/screens/new_case_screen/new_case_screen.dart';
import 'package:law_bot/screens/profile_screen/profile_screen.dart';
import 'package:law_bot/theme/theme.dart';
import 'package:law_bot/utils/rive_utils.dart';
import 'package:law_bot/widgets/animated_bar.dart';
import 'package:law_bot/widgets/rive_asset.dart';
import 'package:rive/rive.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int selectedIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    NewCaseScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          decoration: BoxDecoration(
              color: ThemeManagement.instance.currentTheme.cardColor,
              borderRadius: const BorderRadius.all(Radius.circular(24))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                  bottomNavs[0].input?.change(true);
                  Future.delayed(const Duration(seconds: 1), () {
                    bottomNavs[0].input?.change(false);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity: selectedIndex == 0 ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            bottomNavs[0].src,
                            artboard: bottomNavs[0].artboard,
                            onInit: (artboard) {
                              StateMachineController controller =
                                  RiveUtils.getRiveController(artboard,
                                      stateMachineName:
                                          bottomNavs[0].stateMachineName);

                              bottomNavs[0].input =
                                  controller.findSMI("active") as SMIBool;
                            },
                          ),
                        )),
                    AnimatedBar(isActive: selectedIndex == 0),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Opacity(
                      opacity: selectedIndex == 1 ? 1 : 0.5,
                      child: const SizedBox(
                          height: 36, width: 36, child: Icon(Icons.add)),
                    ),
                    AnimatedBar(isActive: selectedIndex == 1),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                  bottomNavs[1].input?.change(true);
                  Future.delayed(const Duration(seconds: 1), () {
                    bottomNavs[1].input?.change(false);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity: selectedIndex == 2 ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            bottomNavs[1].src,
                            artboard: bottomNavs[1].artboard,
                            onInit: (artboard) {
                              StateMachineController controller =
                                  RiveUtils.getRiveController(artboard,
                                      stateMachineName:
                                          bottomNavs[1].stateMachineName);

                              bottomNavs[1].input =
                                  controller.findSMI("active") as SMIBool;
                            },
                          ),
                        )),
                    AnimatedBar(isActive: selectedIndex == 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
