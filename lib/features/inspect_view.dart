import 'inspect_detail_view.dart';
import 'util.dart';

import '../widgets/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

import '../models/omamori_model.dart';
import '../widgets/main_back_button.dart';

class InspectView extends StatelessWidget {
  const InspectView({super.key, required this.omamoriModel});

  final OmamoriModel omamoriModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: tiltItem()),
          Positioned(top: 16, left: 16, child: MainBackButton()),
          Positioned(
            top: 16,
            right: 16,
            child: AppIconButton(
              onPressed: () {
                pushView(
                  context,
                  InspectDetailView(omamoriModel: omamoriModel),
                  fullscreenDialog: true,
                );
              },
              icon: Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
    );
  }

  Widget tiltItem() {
    return Tilt(
      // onGestureMove: (tiltDataModel, gesturesType) {
      //   setState(() {
      //     scale = 1;
      //   });
      // },
      // onGestureLeave: (tiltDataModel, gesturesType) {
      //   setState(() {
      //     scale = 1;
      //   });
      // },
      // tiltStreamController: tiltStreamController,
      tiltConfig: TiltConfig(
        // enableRevert: false,
        // enableSensorRevert: false,
        enableGestureSensors: false,
      ),
      childLayout: ChildLayout(
        outer: [
          Positioned(
            child: TiltParallax(
              size: Offset(10, 10),
              child: Container(
                width: 150,
                height: 150,
                color: Colors.amber,
                child: Text(omamoriModel.title),
              ),
            ),
          ),
        ],
      ),
      child: Container(
        width: 150.0,
        height: 150.0,
        color: Colors.grey.withAlpha((0.9 * 255).toInt()),
      ),
    );
  }
}
