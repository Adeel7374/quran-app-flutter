import 'package:al_quran/Screens/audio_surahScreen.dart';
import 'package:al_quran/consts/Colors.dart';
import 'package:al_quran/models/api_Services.dart';
import 'package:al_quran/models/qari.dart';
import 'package:al_quran/widgets/qari_customtile.dart';
import 'package:flutter/material.dart';

class QariListScreen extends StatefulWidget {
  const QariListScreen({super.key});

  @override
  State<QariListScreen> createState() => _QariListScreenState();
}

class _QariListScreenState extends State<QariListScreen> {
  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Qaris'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 1,
                          spreadRadius: 0.0,
                          offset: Offset(0, 1))
                    ]),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [Text('Search'), Spacer(), Icon(Icons.search)],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: FutureBuilder(
                      future: apiServices.getQariList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Qari>> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Qaris data not found'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: white,
                            ),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return QariCustomTile(
                                qari: snapshot.data![index],
                                ontap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AudioSurahScreen(
                                                qari: snapshot.data![index],
                                                index: index + 1,
                                                list: const [],
                                              )));
                                },
                              );
                            });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
