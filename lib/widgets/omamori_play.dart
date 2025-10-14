import 'dart:async';

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
  late StreamController<TiltStreamModel> tiltStreamController;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    tiltStreamController = StreamController.broadcast();
    playAnimation();
  }

  void playAnimation() {
    // from https://amoshuke.github.io/flutter_tilt_book/en/docs/examples/tilt-stream-controller-demo/
    animationController = AnimationController(
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    animationController.addListener(() {
      final x = curvedAnimation.value * 200;
      tiltStreamController.add(TiltStreamModel(position: Offset(x, 125)));
    });
    animationController.repeat(reverse: true);
  }

  void stopAnimation() {
    animationController.stop();
    tiltStreamController.add(const TiltStreamModel(position: Offset.zero, gestureUse: false));
  }

  @override
  void dispose() {
    tiltStreamController.close();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        await Future.delayed(Duration(milliseconds: 3000));
        stopAnimation();
      },
      child: Tilt(
        tiltStreamController: tiltStreamController,
        tiltConfig: const TiltConfig(enableGestureSensors: false),
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
      ),
    );
  }
}
