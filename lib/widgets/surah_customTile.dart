import 'package:al_quran/consts/Colors.dart';
import 'package:al_quran/models/surah.dart';
import 'package:flutter/material.dart';

Widget SurahCustomTiles(
    {required Surah surah,
    required BuildContext context,
    required VoidCallback ontap}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3.0)]),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: blackColor),
                child: Text(
                  (surah.number).toString(),
                  style: const TextStyle(
                      color: red, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.englishName!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(surah.englishNameTranslation!)
                ],
              ),
              const Spacer(),
              Text(
                surah.name!,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    ),
  );
}
