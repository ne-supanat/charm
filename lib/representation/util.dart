import 'package:flutter/material.dart';

pushView(BuildContext context, Widget view, {bool fullscreenDialog = false}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => view, fullscreenDialog: fullscreenDialog),
  );
}

replaceView(BuildContext context, Widget view) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => view));
}

bool useWebLayout(BuildContext context) {
  return MediaQuery.of(context).size.width > 900 ? true : false;
}
