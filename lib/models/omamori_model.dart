import 'package:uuid/uuid.dart';

class OmamoriModel {
  final String id;
  final String title;
  final String description;
  final String shapeId;
  final String backgroundId;
  final String itemPrimaryId;
  final String itemSecondaryId1;
  final String itemSecondaryId2;

  OmamoriModel({
    required this.id,
    required this.title,
    required this.description,
    required this.shapeId,
    required this.backgroundId,
    required this.itemPrimaryId,
    required this.itemSecondaryId1,
    required this.itemSecondaryId2,
  });

  factory OmamoriModel.init() {
    return OmamoriModel(
      id: Uuid().v1(),
      title: "Preset",
      description: "",
      shapeId: "0",
      backgroundId: "0",
      itemPrimaryId: "0",
      itemSecondaryId1: "0",
      itemSecondaryId2: "0",
    );
  }

  OmamoriModel copyWith({
    String? title,
    String? description,
    String? shapeId,
    String? backgroundId,
    String? itemPrimaryId,
    String? itemSecondaryId1,
    String? itemSecondaryId2,
  }) {
    return OmamoriModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      shapeId: shapeId ?? this.shapeId,
      backgroundId: backgroundId ?? this.backgroundId,
      itemPrimaryId: itemPrimaryId ?? this.itemPrimaryId,
      itemSecondaryId1: itemSecondaryId1 ?? this.itemSecondaryId1,
      itemSecondaryId2: itemSecondaryId2 ?? this.itemSecondaryId2,
    );
  }
}
