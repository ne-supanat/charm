class ItemModel {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> tags;
  final String description;

  ItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.tags,
    required this.description,
  });

  factory ItemModel.from(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      tags: (json['tags'] as List).map((e) => e.toString()).toList(),
      description: json['description'],
    );
  }
}
