import 'package:al_quran/consts/Colors.dart';
import 'package:al_quran/consts/constants.dart';
import 'package:al_quran/models/api_Services.dart';
import 'package:al_quran/models/translation.dart';
import 'package:al_quran/widgets/translation_custonTile.dart';
import 'package:flutter/material.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

enum Translation { urdu, hindi, english, spanish }

class SurahDetails extends StatefulWidget {
  const SurahDetails({super.key});

  static const String id = 'surahDetail_screen';

  @override
  State<SurahDetails> createState() => _SurahDetailsState();
}

class _SurahDetailsState extends State<SurahDetails> {
  ApiServices apiServices = ApiServices();
  SolidController solidController = SolidController();
  Translation? translation = Translation.urdu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: apiServices.getTranslation(
              Constants.surahIndex!, translation!.index),
          builder: (BuildContext context,
              AsyncSnapshot<SurahTranslationList> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: white,
                ),
              );
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ListView.builder(
                    itemCount: snapshot.data!.translationlist.length,
                    itemBuilder: (context, index) {
                      return TranslationTile(
                          index: index,
                          surahTranslation:
                              snapshot.data!.translationlist[index]);
                    }),
              );
            } else {
              return const Center(
                child: Text('Translation not found'),
              );
            }
          }),
      bottomSheet: SolidBottomSheet(
        headerBar: Container(
          color: lightblue,
          height: 50,
          child: const Center(
            child: Text("Swipe me!"),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: 30,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Urdu'),
                    leading: Radio<Translation>(
                      value: Translation.urdu,
                      groupValue: translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          translation = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('English'),
                    leading: Radio<Translation>(
                      value: Translation.english,
                      groupValue: translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          translation = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Hindi'),
                    leading: Radio<Translation>(
                      value: Translation.hindi,
                      groupValue: translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          translation = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Spanish'),
                    leading: Radio<Translation>(
                      value: Translation.spanish,
                      groupValue: translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          translation = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
