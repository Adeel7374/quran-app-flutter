import 'package:al_quran/consts/Colors.dart';
import 'package:al_quran/models/Juz.dart';
import 'package:flutter/material.dart';

class JuzCustomTile extends StatelessWidget {
  final List<JuzAyats> list;
  final int index;
  const JuzCustomTile({super.key, required this.index, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          color: white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3.0)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(list[index].ayatNumber.toString()),
          Text(
            list[index].ayatsText,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
            textAlign: TextAlign.end,
          ),
          Text(
            list[index].surahName,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
