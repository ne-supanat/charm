enum Tag { all, luck, success, love, travel, work, money }

extension TagExtension on Tag {
  String get displayName {
    switch (this) {
      case Tag.all:
        return 'All';
      case Tag.luck:
        return 'Luck';
      case Tag.success:
        return 'Success';
      case Tag.love:
        return 'Love';
      case Tag.travel:
        return 'Travel';
      case Tag.work:
        return 'Work';
      case Tag.money:
        return 'Money';
    }
  }
}
