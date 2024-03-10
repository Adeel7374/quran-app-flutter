import 'dart:async';
import 'package:al_quran/Screens/bottom_navbar.dart';
import 'package:al_quran/Screens/onBoarding_screen/OnBoarding.dart';
import 'package:al_quran/consts/Colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool alreadyUsed = false;

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    alreadyUsed = prefs.getBool("alreadyUsed") ?? false;
  }

  @override
  void initState() {
    super.initState();
    getData();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return alreadyUsed ? const MainPage() : const OnBoardingScreen();
            })));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            'assets/images/logo.png',
            height: 200,
          )
              // Text(
              //   'Al Quran',
              //   style: TextStyle(
              //       color: blackColor, fontSize: 30, fontWeight: FontWeight.bold),
              // ),
              ),
          // Positioned(
          //     bottom: 20,
          //     left: 0,
          //     right: 0,
          //     child:

          //     )
        ],
      ),
    ));
  }
}
