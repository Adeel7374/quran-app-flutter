class Qari {
  String? name;
  String? path;
  String? format;

  Qari({required this.format, required this.name, required this.path});

  factory Qari.fromjson(Map<String, dynamic> json) {
    return Qari(
        format: json['file_formats'],
        name: json['name'],
        path: json['relative_path']);
  }
}
