import 'package:charm/models/omamori_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
  return "";
}

OmamoriModel convertCodeToOmamori(String code) {
  // TODO: convert code
  return OmamoriModel(
    id: Uuid().v1(),
    title: "title",
    description: "description",
    backgroundId: "0",
    shapeId: "1",
    itemPrimaryId: "2",
    itemSecondaryId1: "4",
    itemSecondaryId2: "5",
  );
}
