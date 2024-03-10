class SurahTranslationList {
  final List<SurahTranslation> translationlist;
  SurahTranslationList({required this.translationlist});

  factory SurahTranslationList.fromJson(Map<String, dynamic> map) {
    Iterable translation = map['result'];
    List<SurahTranslation> list =
        translation.map((e) => SurahTranslation.fromJson(e)).toList();
    print(list.length);

    return SurahTranslationList(translationlist: list);
  }
}

class SurahTranslation {
  String? surah;
  String? aya;
  String? arabic_text;
  String? translation;

  SurahTranslation(
      {required this.surah,
      required this.arabic_text,
      required this.aya,
      required this.translation});

  factory SurahTranslation.fromJson(Map<String, dynamic> json) {
    return SurahTranslation(
        surah: json['surah'],
        arabic_text: json['arabic_text'],
        aya: json['aya'],
        translation: json['translation']);
  }
}
