enum TagCategory { all, animal, nature, object, entity }

enum TagPower { all, luck, love, travel, protection, work, money, longivity, wisdom }

extension TagCategoryExtension on TagCategory {
  String get displayName {
    switch (this) {
      case TagCategory.all:
        return 'All';
      case TagCategory.animal:
        return "Animal";
      case TagCategory.nature:
        return "Nature";
      case TagCategory.object:
        return "Object";
      case TagCategory.entity:
        return "Entity";
    }
  }
}

extension TagPowerExtension on TagPower {
  String get displayName {
    switch (this) {
      case TagPower.all:
        return 'All';
      case TagPower.luck:
        return "Luck";
      case TagPower.love:
        return "Love";
      case TagPower.travel:
        return "Travel";
      case TagPower.protection:
        return "Protection";
      case TagPower.work:
        return "Work";
      case TagPower.money:
        return "Money";
      case TagPower.longivity:
        return "Longivity";
      case TagPower.wisdom:
        return "Wisdom";
    }
  }
}
