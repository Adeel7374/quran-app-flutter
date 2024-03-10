import 'package:al_quran/Screens/audio_screen.dart';
import 'package:al_quran/consts/Colors.dart';
import 'package:al_quran/models/api_Services.dart';
import 'package:al_quran/models/qari.dart';
import 'package:al_quran/models/surah.dart';
import 'package:flutter/material.dart';

class AudioSurahScreen extends StatefulWidget {
  final Qari qari;
  final int index;
  final List<Surah> list;
  const AudioSurahScreen(
      {super.key, required this.qari, required this.index, required this.list});

  @override
  State<AudioSurahScreen> createState() => _AudioSurahScreenState();
}

class _AudioSurahScreenState extends State<AudioSurahScreen> {
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          title: const Text(
            'Surah List',
            style: TextStyle(
                color: blackColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
            future: apiServices.getSurah(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Surah>> snapshot) {
              if (snapshot.hasData) {
                List<Surah>? surah = snapshot.data;
                return ListView.builder(
                    itemCount: surah!.length,
                    itemBuilder: (context, index) => audioCustomTile(
                        surahName: snapshot.data![index].englishName,
                        totalaya: snapshot.data![index].numberOfAyahs,
                        number: snapshot.data![index].number,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AudioScreen(
                                      qari: widget.qari,
                                      index: index + 1,
                                      list: surah)));
                        }));
              }
              return const Center(
                child: CircularProgressIndicator(color: white),
              );
            }),
      ),
    );
  }
}

Widget audioCustomTile(
    {required String? surahName,
    required totalaya,
    required number,
    required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 0,
                  color: Colors.black12,
                  offset: Offset(0, 3))
            ]),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: blackColor),
              child: Text(
                (number).toString(),
                style: const TextStyle(
                    color: white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                Text(
                  surahName!,
                  style: const TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.end,
                ),
                const SizedBox(height: 3),
                Text(
                  "Total Ayats: $totalaya",
                  style: const TextStyle(color: Colors.black54, fontSize: 16),
                )
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.play_circle_fill,
              color: blackColor,
            )
          ],
        ),
      ),
    ),
  );
}
