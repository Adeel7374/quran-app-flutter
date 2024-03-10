// ignore_for_file: must_be_immutable

import 'package:al_quran/consts/Colors.dart';
import 'package:al_quran/consts/constants.dart';
import 'package:al_quran/models/Juz.dart';
import 'package:al_quran/models/api_Services.dart';
import 'package:al_quran/widgets/juz_customTile.dart';
import 'package:flutter/material.dart';

class JuzScreen extends StatelessWidget {
  static const String id = 'juz_screen';
  ApiServices apiServices = ApiServices();

  JuzScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<JuzModel>(
            future: apiServices.getJuz(Constants.juzIndex!),
            builder: (context, AsyncSnapshot<JuzModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: white,
                  ),
                );
              } else if (snapshot.hasData) {
                print('Data Length: ${snapshot.data!.juzayats.length}');
                print('Data: ${snapshot.data}');
                return ListView.builder(
                    itemCount: snapshot.data!.juzayats.length,
                    itemBuilder: (context, index) {
                      return JuzCustomTile(
                        list: snapshot.data!.juzayats,
                        index: index,
                      );
                    });
              } else {
                return const Center(
                  child: Text('Data not found'),
                );
              }
            }),
      ),
    );
  }
}
