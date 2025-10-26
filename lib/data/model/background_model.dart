class BackgroundModel {
  final int id;
  final String name;
  final String imageUrl;

  BackgroundModel({required this.id, required this.name, required this.imageUrl});

  factory BackgroundModel.from(Map<String, dynamic> json) {
    return BackgroundModel(
      id: json['id'],
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}
