import 'package:charm/models/tags_constant.dart';

class ItemModel {
  final String id;
  final String name;
  final String imagePath;
  final List<Tag> tags;
  final String description;

  ItemModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.tags,
    required this.description,
  });
}
