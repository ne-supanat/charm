import 'package:charm/models/omamori_model.dart';
import 'package:flutter/material.dart';

class OmamoriStatic extends StatelessWidget {
  const OmamoriStatic({super.key, required this.omamoriModel});

  final OmamoriModel omamoriModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Container(
          width: 200.0,
          height: 200.0,
          color: Colors.lightBlue.withAlpha((0.9 * 255).toInt()),
        ),
        Positioned(child: Center(child: Text(omamoriModel.title))),
      ],
    );
  }
}
