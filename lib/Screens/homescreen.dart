import 'package:al_quran/consts/Colors.dart';
import 'package:al_quran/models/api_Services.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices apiServices = ApiServices();

  void setData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("alreadyUsed", true);
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    var hijri = HijriCalendar.now();
    HijriCalendar.setLocal('ar');
    var day = DateTime.now();
    var format = DateFormat('EEE , d MMM yyyy');
    var formatted = format.format(day);

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/images/logo.png',
              ),
            )),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatted,
                  style: const TextStyle(color: white, fontSize: 22.0),
                ),
                RichText(
                    text: TextSpan(children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(hijri.hDay.toString(),
                          style: const TextStyle(fontSize: 20.0, color: white)),
                    ),
                  ),
                  WidgetSpan(
                      child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(hijri.longMonthName,
                        style: const TextStyle(
                            fontSize: 20.0,
                            color: white,
                            fontWeight: FontWeight.bold)),
                  )),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('${hijri.hYear} AH',
                          style: const TextStyle(fontSize: 20.0, color: white)),
                    ),
                  ),
                ])),
              ]),
          Expanded(
              child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.only(top: 10, bottom: 20),
            child: Column(
              children: [
                FutureBuilder(
                    future: apiServices.getAyatOfTheDay(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Icon(Icons.sync_problem);
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          return const CircularProgressIndicator(
                            color: mainColor,
                          );
                        case ConnectionState.done:
                          return Container(
                            margin: const EdgeInsetsDirectional.all(16),
                            padding: const EdgeInsetsDirectional.all(20),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 3,
                                      spreadRadius: 1,
                                      offset: Offset(0, 1))
                                ]),
                            child: Column(
                              children: [
                                const Text(
                                  'Quran ayat of the day',
                                  style: TextStyle(
                                      color: blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  color: blackColor,
                                ),
                                Text(
                                  snapshot.data!.arText!,
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  snapshot.data!.enTran!,
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data!.surNumber!.toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  )),
                                  WidgetSpan(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data!.surEnName!,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ))
                                ]))
                              ],
                            ),
                          );
                      }
                    })
              ],
            ),
          )),
        ],
      ),
    ));
  }
}
