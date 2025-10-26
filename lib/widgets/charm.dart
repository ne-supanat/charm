import 'package:charm/global/colors.dart';
import 'package:charm/widgets/floating_widget.dart';
import 'package:flutter/material.dart';

class Charm extends StatelessWidget {
  const Charm({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: width * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: Color(0xFFE4D5BD)),
              ),
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorWhite,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withAlpha((255 * 0.25).toInt()),
                      blurRadius: 25,
                      spreadRadius: 25,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset("images/object_sakura.png", fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: FloatingWidget(distance: 5, child: Image.asset("images/star_top.png")),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: FloatingWidget(distance: -5, child: Image.asset("images/star_bottom.png")),
          ),
        ],
      ),
    );
  }
}
