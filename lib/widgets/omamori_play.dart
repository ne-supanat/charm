import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

import '../models/omamori_model.dart';

class OmamoriPlay extends StatefulWidget {
  const OmamoriPlay({super.key, required this.omamoriModel});

  final OmamoriModel omamoriModel;

  @override
  State<OmamoriPlay> createState() => _OmamoriPlayState();
}

class _OmamoriPlayState extends State<OmamoriPlay> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Tilt(
      childLayout: ChildLayout(
        outer: [
          Positioned(
            child: TiltParallax(
              size: Offset(10, 10),
              child: Center(child: Text(widget.omamoriModel.title)),
            ),
          ),
          Positioned(
            child: TiltParallax(
              size: Offset(20, 20),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.white.withAlpha((0.4 * 255).toInt()),
              ),
            ),
          ),
        ],
      ),
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.lightBlue.withAlpha((0.9 * 255).toInt()),
      ),
    );
  }
}
