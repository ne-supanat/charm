import 'package:flutter/material.dart';

import '../data/model/omamori_model.dart';

pushView(BuildContext context, Widget view, {bool fullscreenDialog = false}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => view, fullscreenDialog: fullscreenDialog),
  );
}

replaceView(BuildContext context, Widget view) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => view));
}

String convertOmamoriToCode(OmamoriModel omamoriModel) {
  // TODO: convert code
  return "converted code";
}

OmamoriModel convertCodeToOmamori(String code) {
  // TODO: convert code
  return OmamoriModel(
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
