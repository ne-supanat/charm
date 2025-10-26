import 'package:charm/data/model/charm_model.dart';
import 'package:flutter/material.dart';

class CharmStatic extends StatelessWidget {
  const CharmStatic({super.key, required this.charmModel});

  final CharmModel charmModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipPath(
          clipper: BeveledClipper(bevel: 30, radius: 8),
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Container(
                width: 144, // width:height 3:4
                height: 192,
                color: Colors.lightBlue,
              ),

              // Primary Item
              Positioned(child: Container(width: 100.0, height: 100.0, color: Colors.blue)),

              // Secondary Item 1
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(width: 25.0, height: 25.0, color: Colors.red),
              ),

              // Secondary Item 2
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(width: 25.0, height: 25.0, color: Colors.amber),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BeveledClipper extends CustomClipper<Path> {
  final double radius;
  final double bevel;

  BeveledClipper({required this.radius, required this.bevel});

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(bevel, 0)
      // Top Right
      ..lineTo(size.width - bevel, 0)
      ..lineTo(size.width, bevel)
      // Bottom
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height), radius: Radius.circular(radius))
      ..lineTo(0 + radius, size.height)
      ..arcToPoint(Offset(0, size.height - radius), radius: Radius.circular(radius))
      // Top Left
      ..lineTo(0, size.height - bevel)
      ..lineTo(0, bevel)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
