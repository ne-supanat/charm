class MusicsModel {
  final int id;
  final String name;
  final String audioUrl;

  MusicsModel({required this.id, required this.name, required this.audioUrl});

  factory MusicsModel.from(Map<String, dynamic> json) {
    print(json);
    return MusicsModel(id: json['id'], name: json['name'], audioUrl: json['audio_url']);
  }
}
