import 'package:al_quran/Screens/homescreen.dart';
import 'package:al_quran/Screens/prayer_Screen.dart';
import 'package:al_quran/Screens/qari_screen.dart';
import 'package:al_quran/Screens/quran_screen.dart';
import 'package:al_quran/consts/Colors.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void updateIndex(index) {
      setState(() {
        selectedIndex = index;
      });
    }

    List<Widget> widgetList = [
      const HomeScreen(),
      const QuranScreen(),
      const QariListScreen(),
      const PrayerScreen()
    ];

    return SafeArea(
        child: Scaffold(
            body: widgetList[selectedIndex],
            bottomNavigationBar: ConvexAppBar(
              items: const [
                TabItem(
                  icon: Icons.home,
                  title: 'Home',
                ),
                TabItem(icon: Icons.book, title: 'Quran'),
                TabItem(icon: Icons.audio_file, title: 'Audio'),
                TabItem(icon: Icons.message, title: 'Prayer'),
              ],
              initialActiveIndex: 0,
              onTap: updateIndex,
              backgroundColor: mainColor,
              activeColor: white,
            )));
  }
}
