import 'package:al_quran/Screens/Juz_Screen.dart';
import 'package:al_quran/Screens/splash/splash.dart';
import 'package:al_quran/Screens/surah_details.dart';
import 'package:al_quran/consts/Colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al Quran',
      theme: ThemeData(
        fontFamily: 'poppins',
        scaffoldBackgroundColor: mainColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent, elevation: 0.0),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        JuzScreen.id: (context) => JuzScreen(),
        SurahDetails.id: (context) => const SurahDetails()
      },
    );
  }
}
