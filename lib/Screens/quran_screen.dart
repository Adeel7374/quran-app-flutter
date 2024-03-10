import 'package:al_quran/Screens/Juz_Screen.dart';
import 'package:al_quran/Screens/surah_details.dart';
import 'package:al_quran/consts/Colors.dart';
import 'package:al_quran/consts/constants.dart';
import 'package:al_quran/models/api_Services.dart';
import 'package:al_quran/models/sajda.dart';
import 'package:al_quran/models/surah.dart';
import 'package:al_quran/widgets/sajda_customTile.dart';
import 'package:al_quran/widgets/surah_customTile.dart';
import 'package:flutter/material.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Quran',
                style: TextStyle(color: white),
              ),
              centerTitle: true,
              bottom: const TabBar(tabs: [
                Text(
                  'Surah',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700, color: white),
                ),
                Text(
                  'Sajda',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700, color: white),
                ),
                Text(
                  'Juz',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700, color: white),
                ),
              ]),
            ),
            body: TabBarView(children: [
              FutureBuilder(
                  future: apiServices.getSurah(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Surah>> snapshot) {
                    if (snapshot.hasData) {
                      List<Surah>? surah = snapshot.data;
                      return ListView.builder(
                          itemCount: surah!.length,
                          itemBuilder: (context, index) => SurahCustomTiles(
                              surah: surah[index],
                              context: context,
                              ontap: () {
                                setState(() {
                                  Constants.surahIndex = (index + 1);
                                });
                                Navigator.pushNamed(context, SurahDetails.id);
                              }));
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: white,
                      ),
                    );
                  }),
              FutureBuilder(
                future: apiServices.getSajda(),
                builder: (context, AsyncSnapshot<SajdaList> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: white,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.sajdaAyahs.length,
                    itemBuilder: (context, index) => sajdaCustomTile(
                        snapshot.data!.sajdaAyahs[index], context),
                  );
                },
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              Constants.juzIndex = (index + 1);
                            });
                            Navigator.pushNamed(context, JuzScreen.id);
                          },
                          child: Card(
                            elevation: 4,
                            color: blue,
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style:
                                    const TextStyle(color: white, fontSize: 20),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ]),
          ),
        ));
  }
}
