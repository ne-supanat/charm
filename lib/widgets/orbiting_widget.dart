import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class OrbitingWidget extends StatefulWidget {
  const OrbitingWidget({super.key});

  @override
  State<OrbitingWidget> createState() => _OrbitingWidgetState();
}

class _OrbitingWidgetState extends State<OrbitingWidget> with TickerProviderStateMixin {
  late AnimationController _controllerRotate;
  late Animation<double> _animationRotate;

  late AnimationController _controllerSkew;
  late Animation<double> _animationSkew;
  @override
  void initState() {
    super.initState();
    _controllerRotate = AnimationController(duration: Duration(seconds: 20), vsync: this)..repeat();
    _animationRotate = Tween<double>(begin: 0, end: 1).animate(_controllerRotate);

    _controllerSkew = AnimationController(duration: Duration(seconds: 20), vsync: this)
      ..repeat(reverse: true);
    _animationSkew = Tween<double>(
      begin: -15 / 360,
      end: 15 / 360,
    ).animate(_controllerSkew); // 30 degree rotate back and forth
  }

  @override
  void dispose() {
    _controllerRotate.dispose();
    _controllerSkew.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: RotationTransition(
        turns: _animationSkew,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return RadialGradient(
              center: Alignment.topCenter,
              radius: 1,
              colors: [Colors.black.withAlpha(0), Colors.black, Colors.black],
              stops: [0.5, 0.6, 1.0], // black parts will be visible
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Transform.scale(
            scaleY: 0.5,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return RotationTransition(
                  turns: _animationRotate,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: DottedBorder(
                          options: OvalDottedBorderOptions(
                            dashPattern: [200, 24],
                            strokeWidth: 3,
                            color: Color(0xFFE4D5BD),
                            strokeCap: StrokeCap.round,
                          ),
                          child: Container(
                            width: constraints.maxWidth * 0.8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // border: Border.all(width: 3, color: Color(0xFFE4D5BD), style: BorderStyle),
                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   top: -(ballSize / 2),
                      //   left: (constraints.maxWidth / 2) - (ballSize / 2),
                      //   child: buildBall(),
                      // ), // Top
                      // Positioned(
                      //   top: (constraints.maxWidth / 2) - (ballSize / 2),
                      //   right: -(ballSize / 2),
                      //   child: buildBall(),
                      // ), // Right
                      // Positioned(
                      //   bottom: -(ballSize / 2),
                      //   left: (constraints.maxWidth / 2) - (ballSize / 2),
                      //   child: buildBall(),
                      // ), // Bottom
                      // Positioned(
                      //   top: constraints.maxWidth / 2,
                      //   left: -(ballSize / 2),
                      //   child: buildBall(),
                      // ), // Left
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
