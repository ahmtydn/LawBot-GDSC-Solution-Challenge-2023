import 'package:flutter/material.dart';
import 'package:law_bot/screens/home/home_screen.dart';

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
                  itemCount: demo_data.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                    image: demo_data[index].image,
                    title: demo_data[index].title,
                    description: demo_data[index].description,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                      demo_data.length,
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFC221),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: Text('Skip'),
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

final List<Onboard> demo_data = [
  Onboard(
    image: 'assets/onboard.gif',
    title: 'Merhaba, ben LawBot!',
    description:
        'Adalet sistemi için yeni bir çığır açıyorum. Benimle suçlulara karşı savaşabilir ve insanların daha adil kararlar almasına yardımcı olabilirim.',
  ),
  Onboard(
    image: 'assets/onboard2.gif',
    title: 'LawBot nasıl çalışır?',
    description:
        'LawBot, makine öğrenmesi ve doğal dil işleme teknolojilerini kullanarak karar verme sürecinde yardımcı olur. Sanık ve tanık ifadeleri gibi pek çok parametreyi göz önünde bulundurarak, avukat ve hakimlere tahmin edilen sonucu sunar. Bu sayede karar verme sürecini hızlandırır ve vakit kaybını azaltır.',
  ),
  Onboard(
    image: 'assets/onboard3.gif',
    title: 'LawBot ile evrensel çözümler!',
    description:
        'LawBot, farklı ülkelerin kanunlarını öğrenerek çeşitli suçlara doğru tahminlemelerde bulunabilen evrensel bir çözüm sunuyor. Hukuk alanında yardımcı ve karar destek sistemleri şeklinde kullanılan LawBot, avukat ve hakimlere yeni stratejiler geliştirmelerine yardımcı olur ve hata oranını en aza indirir.',
  ),
];
