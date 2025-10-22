enum CustomisationConstant { description, components }

enum ComponentConstant { background, pattern, item1, item2, item3 }

extension ComponentConstantExtension on ComponentConstant {
  String get displayName {
    switch (this) {
      case ComponentConstant.background:
        return 'Background';
      case ComponentConstant.pattern:
        return 'Pattern';
      case ComponentConstant.item1:
        return 'Item I';
      case ComponentConstant.item2:
        return 'Item II';
      case ComponentConstant.item3:
        return 'Item III';
    }
  }
}
