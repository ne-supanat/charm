import 'dart:io';

import 'package:charm/resources/resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('image_icons assets test', () {
    expect(File(ImageIcons.app).existsSync(), isTrue);
    expect(File(ImageIcons.hidden).existsSync(), isTrue);
    expect(File(ImageIcons.image).existsSync(), isTrue);
    expect(File(ImageIcons.info).existsSync(), isTrue);
    expect(File(ImageIcons.kofi).existsSync(), isTrue);
    expect(File(ImageIcons.music).existsSync(), isTrue);
    expect(File(ImageIcons.play).existsSync(), isTrue);
    expect(File(ImageIcons.star).existsSync(), isTrue);
  });
}
