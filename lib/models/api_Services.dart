import 'dart:convert';
import 'dart:math';
import 'package:al_quran/models/Juz.dart';
import 'package:al_quran/models/ayat_of_the_day.dart';
import 'package:al_quran/models/qari.dart';
import 'package:al_quran/models/sajda.dart';
import 'package:al_quran/models/surah.dart';
import 'package:al_quran/models/translation.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final endPointUrl = "http://api.alquran.cloud/v1/surah";
  List<Surah> list = [];

  Future<AyatOftheDay> getAyatOfTheDay() async {
    String url =
        "http://api.alquran.cloud/v1/ayah/${random(1, 6237)}/editions/quran-uthmani,en.asad,en.pickthall";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return AyatOftheDay.fromJSON(json.decode(response.body));
    } else {
      print("failed to load");
      throw Exception("failed to load page");
    }
  }

  random(min, max) {
    var rn = Random();
    return min + rn.nextInt(max - min);
  }

  Future<List<Surah>> getSurah() async {
    http.Response res = await http.get(Uri.parse(endPointUrl));
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      json['data'].forEach((element) {
        if (list.length < 114) {
          list.add(Surah.fromJson(element));
        }
      });
      print('ol ${list.length}');
      return list;
    } else {
      throw ("Can't get the Surah");
    }
  }

  Future<JuzModel> getJuz(index) async {
    if (index < 1 || index > 30) {
      throw Exception("Invalid Juz number. It should be between 1 and 30.");
    }

    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Juz API Response: ${response.body}');

      try {
        return JuzModel.fromJSON(jsonDecode(response.body));
      } catch (e) {
        print('Error decoding JSON: $e');
        throw Exception("Failed to parse Juz data");
      }
    } else {
      print("Failed to Load. Status Code: ${response.statusCode}");
      throw Exception("Failed to load Juz");
    }
  }

  Future<SajdaList> getSajda() async {
    String url = "http://api.alquran.cloud/v1/sajda/en.asad";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return SajdaList.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  Future<SurahTranslationList> getTranslation(
      int index, int translationIndex) async {
    String lan = "";
    if (translationIndex == 0) {
      lan = "urdu_junagarhi";
    } else if (translationIndex == 1) {
      lan = "hindi omari";
    } else if (translationIndex == 2) {
      lan = "english_shaheeh";
    } else if (translationIndex == 3) {
      lan = "spanish_garcia";
    }

    final url = "http://quranenc.com/api/translation/sura/$lan/$index";
    var res = await http.get(Uri.parse(url));
    return SurahTranslationList.fromJson(jsonDecode(res.body));
  }

  List<Qari> qarilist = [];

  Future<List<Qari>> getQariList() async {
    const url = "https://quranicaudio.com/api/qaris";
    final res = await http.get(Uri.parse(url));

    jsonDecode(res.body).forEach((element) {
      if (qarilist.length < 157) {
        qarilist.add(Qari.fromjson(element));
      }
    });
    qarilist.sort((a, b) => a.name!.compareTo(b.name!));
    return qarilist;
  }
}
