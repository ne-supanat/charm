import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

import '../models/omamori_model.dart';
import '../widgets/app_icon_button.dart';
import '../widgets/main_back_button.dart';
import '../widgets/omamori_play.dart';
import 'inspect_detail_view.dart';
import 'util.dart';

class InspectView extends StatelessWidget {
  const InspectView({super.key, required this.omamoriModel});

  final OmamoriModel omamoriModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Positioned.fill(
            child: Blur(
              blur: 5,
              child: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Image.network("https://picsum.photos/200", fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            child: Center(
              child: SizedBox(
                width: 500,
                height: 500,
                child: OmamoriPlay(omamoriModel: omamoriModel),
              ),
            ),
          ),
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
}
