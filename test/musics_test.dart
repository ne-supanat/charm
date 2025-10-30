import 'dart:io';

import 'package:charm/resources/resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('musics assets test', () {
    expect(File(Musics.moonlightMagicAsherFulero).existsSync(), isTrue);
    expect(File(Musics.onTheFlipTheGreyRoomDensityTime).existsSync(), isTrue);
    expect(File(Musics.thePalaceGardensAsherFulero).existsSync(), isTrue);
    expect(File(Musics.underwaterExplorationGodmode).existsSync(), isTrue);
    expect(File(Musics.makeTheVisibleInvisibleAlge).existsSync(), isTrue);
  });
}
