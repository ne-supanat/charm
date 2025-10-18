class OmamoriModel {
  final int id;
  final String title;
  final String? description;
  final int? patternId;
  final int? backgroundId;
  final int? itemPrimaryId;
  final int? itemSecondaryId1;
  final int? itemSecondaryId2;

  OmamoriModel({
    required this.id,
    required this.title,
    required this.description,
    required this.patternId,
    required this.backgroundId,
    required this.itemPrimaryId,
    required this.itemSecondaryId1,
    required this.itemSecondaryId2,
  });

  factory OmamoriModel.init() {
    return OmamoriModel(
      id: -1,
      title: "Preset",
      description: "",
      patternId: -1,
      backgroundId: -1,
      itemPrimaryId: -1,
      itemSecondaryId1: -1,
      itemSecondaryId2: -1,
    );
  }

  OmamoriModel copyWith({
    String? title,
    String? description,
    int? patternId,
    int? backgroundId,
    int? itemPrimaryId,
    int? itemSecondaryId1,
    int? itemSecondaryId2,
  }) {
    return OmamoriModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      patternId: patternId ?? this.patternId,
      backgroundId: backgroundId ?? this.backgroundId,
      itemPrimaryId: itemPrimaryId ?? this.itemPrimaryId,
      itemSecondaryId1: itemSecondaryId1 ?? this.itemSecondaryId1,
      itemSecondaryId2: itemSecondaryId2 ?? this.itemSecondaryId2,
    );
  }

  factory OmamoriModel.from(Map<String, dynamic> json) {
    return OmamoriModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      patternId: json['pattern_id'],
      backgroundId: json['background_id'],
      itemPrimaryId: json['item_1_id'],
      itemSecondaryId1: json['item_2_id'],
      itemSecondaryId2: json['item_3_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      // 'pattern_id': patternId,
      // 'background_id': backgroundId,
      'item_1_id': itemPrimaryId,
      'item_2_id': itemSecondaryId1,
      'item_3_id': itemSecondaryId2,
    };
  }
}
