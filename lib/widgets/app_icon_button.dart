import 'package:charm/global/colors.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({super.key, required this.onPressed, required this.icon});

  final void Function() onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorPrimary,
        border: Border.all(color: colorSecondary, width: 2),
        boxShadow: [BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(0, 0))],
      ),
      child: IconButton(onPressed: onPressed, icon: icon, color: colorSecondary),
    );
  }
}
