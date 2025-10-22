class OmamoriModel {
  final int id;
  final String title;
  final String? description;
  final int? patternId;
  final int? backgroundId;
  final int? item1Id;
  final int? item2Id;
  final int? item3Id;

  OmamoriModel({
    required this.id,
    required this.title,
    required this.description,
    required this.patternId,
    required this.backgroundId,
    required this.item1Id,
    required this.item2Id,
    required this.item3Id,
  });

  factory OmamoriModel.init() {
    return OmamoriModel(
      id: -1,
      title: "Preset",
      description: "",
      patternId: -1,
      backgroundId: -1,
      item1Id: -1,
      item2Id: -1,
      item3Id: -1,
    );
  }

  OmamoriModel copyWith({
    String? title,
    String? description,
    int? patternId,
    int? backgroundId,
    int? item1Id,
    int? item2Id,
    int? item3Id,
  }) {
    return OmamoriModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      patternId: patternId ?? this.patternId,
      backgroundId: backgroundId ?? this.backgroundId,
      item1Id: item1Id ?? this.item1Id,
      item2Id: item2Id ?? this.item2Id,
      item3Id: item3Id ?? this.item3Id,
    );
  }

  OmamoriModel updateComponents({required OmamoriModel omamoriModel}) {
    return OmamoriModel(
      id: id,
      title: title,
      description: description,
      patternId: omamoriModel.patternId,
      backgroundId: omamoriModel.backgroundId,
      item1Id: omamoriModel.item1Id,
      item2Id: omamoriModel.item2Id,
      item3Id: omamoriModel.item3Id,
    );
  }

  factory OmamoriModel.from(Map<String, dynamic> json) {
    return OmamoriModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      patternId: json['pattern_id'],
      backgroundId: json['background_id'],
      item1Id: json['item_1_id'],
      item2Id: json['item_2_id'],
      item3Id: json['item_3_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      // 'pattern_id': patternId,
      // 'background_id': backgroundId,
      'item_1_id': item1Id,
      'item_2_id': item2Id,
      'item_3_id': item3Id,
    };
  }
}
