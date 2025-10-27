class BackgroundModel {
  final int id;
  final String name;
  final String imageUrlWeb;
  final String imageUrlMobile;

  BackgroundModel({
    required this.id,
    required this.name,
    required this.imageUrlWeb,
    required this.imageUrlMobile,
  });

  factory BackgroundModel.from(Map<String, dynamic> json) {
    return BackgroundModel(
      id: json['id'],
      name: json['name'] ?? '',
      imageUrlWeb: json['image_url_web'] ?? '',
      imageUrlMobile: json['image_url_mobile'] ?? '',
    );
  }
}
