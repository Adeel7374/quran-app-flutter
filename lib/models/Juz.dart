class JuzModel {
  final int juzNumber;
  final List<JuzAyats> juzayats;

  JuzModel({required this.juzNumber, required this.juzayats});

  factory JuzModel.fromJSON(Map<String, dynamic> json) {
    // Check if the 'ayahs' field is not null
    if (json['data']['ayahs'] != null) {
      Iterable ayahs = json['data']['ayahs'];
      List<JuzAyats> juzAyatsList =
          ayahs.map((e) => JuzAyats.fromJSON(e)).toList();
      return JuzModel(
          juzNumber: json['data']['number'], juzayats: juzAyatsList);
    } else {
      // Handle the case where 'ayahs' is null
      print('Error: Ayahs field is null');
      return JuzModel(juzNumber: json['data']['number'], juzayats: []);
    }
  }
}

class JuzAyats {
  final String ayatsText;
  final int ayatNumber;
  final String surahName;

  JuzAyats({
    required this.ayatsText,
    required this.ayatNumber,
    required this.surahName,
  });

  factory JuzAyats.fromJSON(Map<String, dynamic> json) {
    return JuzAyats(
      ayatNumber: json['number'],
      ayatsText: json['text'],
      surahName: json['surah']['name'],
    );
  }
}
