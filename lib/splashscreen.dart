import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:testscreenflutter/main.dart';

main() async {
  runApp(Splashscreen());
}

class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Testing',
        home: AnimatedSplashScreen(
            duration: 9000,
            splash: 'assets/Borcelle.gif',
            splashIconSize: double.infinity,
            nextScreen: MyApp(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.rightToLeftWithFade,
            backgroundColor: Colors.black));
  }
}