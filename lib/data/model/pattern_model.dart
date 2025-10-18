class PatternModel {
  final int id;
  final String imageUrl;

  PatternModel({required this.id, required this.imageUrl});

  factory PatternModel.from(Map<String, dynamic> json) {
    return PatternModel(id: json['id'], imageUrl: json['image_url']);
  }
}
