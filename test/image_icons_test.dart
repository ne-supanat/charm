import 'dart:io';

import 'package:charm/resources/resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('image_icons assets test', () {
    expect(File(ImageIcons.hidden).existsSync(), isTrue);
    expect(File(ImageIcons.image).existsSync(), isTrue);
    expect(File(ImageIcons.star).existsSync(), isTrue);
  });
}
