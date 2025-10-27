import 'dart:io';

import 'package:charm/resources/resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('jsons assets test', () {
    expect(File(Jsons.backgrounds).existsSync(), isTrue);
    expect(File(Jsons.items).existsSync(), isTrue);
  });
}
