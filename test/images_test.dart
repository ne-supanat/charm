import 'dart:io';

import 'package:charm/resources/resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.bgBeachMobile).existsSync(), isTrue);
    expect(File(Images.bgBeachWeb).existsSync(), isTrue);
    expect(File(Images.bgBeachWeb2).existsSync(), isTrue);
    expect(File(Images.bgCityMobile).existsSync(), isTrue);
    expect(File(Images.bgCityWeb).existsSync(), isTrue);
    expect(File(Images.bgForestMobile).existsSync(), isTrue);
    expect(File(Images.bgForestWeb).existsSync(), isTrue);
    expect(File(Images.bgNightMobile).existsSync(), isTrue);
    expect(File(Images.bgNightWeb).existsSync(), isTrue);
    expect(File(Images.darkNoise).existsSync(), isTrue);
    expect(File(Images.objectSakura).existsSync(), isTrue);
    expect(File(Images.starBottom).existsSync(), isTrue);
    expect(File(Images.starTop).existsSync(), isTrue);
  });
}
