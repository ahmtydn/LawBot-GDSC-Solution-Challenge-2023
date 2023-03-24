import 'package:flutter/material.dart';
import 'package:law_bot/auth/auth.dart';
import 'package:law_bot/screens/init_screen/init_screen.dart';
import 'package:law_bot/screens/login/login_screen.dart';
import 'package:law_bot/screens/splash/splash.dart';
import 'package:law_bot/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:law_bot/utils/listener_widget.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BotAuth.instance;
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LawBot",
      theme: ThemeManagement.instance.currentTheme,
      initialRoute: "/",
      onGenerateRoute: (settings) {
        Widget page = ListenerWidget(
          notifier: BotAuth.instance,
          builder: (ctx, BotAuth userValue) {
            if (!userValue.signed) {
              return const LoginScreen();
            }
            if (settings.name == "/home") {
              return const InitScreen();
            }
            return const SplashScreen();
          },
        );

        settings = RouteSettings(name: settings.name);

        return MaterialPageRoute(builder: (context) => page);
      },
    );
  }
}
