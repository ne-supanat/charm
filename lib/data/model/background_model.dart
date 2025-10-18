class BackgroundModel {
  final int id;
  final String imageUrl;

  BackgroundModel({required this.id, required this.imageUrl});

  factory BackgroundModel.from(Map<String, dynamic> json) {
    return BackgroundModel(id: json['id'], imageUrl: json['image_url']);
  }
}
