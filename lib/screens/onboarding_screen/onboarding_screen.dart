import 'package:flutter/material.dart';
import 'package:law_bot/auth/auth.dart';
import 'package:law_bot/screens/init_screen/init_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/dot_indicator.dart';
import '../../widgets/onboarding_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnBoardingScreen> {
  late PageController _pageController;

  int _pageIndex = 0;
  Future<void> setOnboard() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool("onboard", true);
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(mediaQueryData.size.height * 0.02),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: onboardingData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                    image: onboardingData[index].image,
                    title: onboardingData[index].title,
                    description: onboardingData[index].description,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                      onboardingData.length,
                      (index) => Padding(
                            padding: EdgeInsets.all(
                                mediaQueryData.size.height * 0.01),
                            child: DotIndicator(isActive: index == _pageIndex),
                          )),
                  const Spacer(),
                  SizedBox(
                      height: mediaQueryData.size.height * 0.08,
                      width: mediaQueryData.size.width * 0.17,
                      child: ElevatedButton(
                        onPressed: () async {
                          await setOnboard();
                          await BotService.instance.checkOnboard();
                          // ignore: use_build_context_synchronously
                          Navigator.popAndPushNamed(context, "/");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFC221),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: const Text('Skip'),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Onboard {
  final String image, title, description;
  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Onboard> onboardingData = [
  Onboard(
    image: 'assets/onboard.gif',
    title: 'Hello, I am LawBot!',
    description:
        'I am revolutionizing the justice system. I can help fight against criminals and assist people in making fair decisions.',
  ),
  Onboard(
    image: 'assets/onboard2.gif',
    title: 'How does LawBot work?',
    description:
        'LawBot uses machine learning and natural language processing technologies to assist in the decision-making process. By considering various parameters such as defendant and witness statements, I provide lawyers and judges with predicted outcomes, speeding up the decision-making process and reducing time wastage.',
  ),
  Onboard(
    image: 'assets/onboard3.gif',
    title: 'Universal solutions with LawBot!',
    description:
        'LawBot offers a universal solution by learning the laws of different countries and making accurate predictions for various crimes. As a legal assistant and decision support system, LawBot helps lawyers and judges develop new strategies and minimizes the margin of error.',
  ),
];
