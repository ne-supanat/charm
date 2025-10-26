import 'package:flutter/material.dart';

import '../data/model/charm_model.dart';

pushView(BuildContext context, Widget view, {bool fullscreenDialog = false}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => view, fullscreenDialog: fullscreenDialog),
  );
}

replaceView(BuildContext context, Widget view) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => view));
}

String convertCharmToCode(CharmModel charm) {
  // TODO: convert code
  return "converted code";
}

CharmModel convertCodeToCharm(String code) {
  // TODO: convert code
  return CharmModel(
    id: -1,
    title: "title",
    description: "description",
    backgroundId: 1,
    patternId: 1,
    item1Id: 2,
    item2Id: 4,
    item3Id: 5,
  );
}
