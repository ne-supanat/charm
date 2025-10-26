import 'package:charm/global/colors.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({super.key, this.onPressed, required this.icon});

  final Function()? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: colorSecondary,
      onPressed: onPressed,
      icon: icon,
      padding: EdgeInsets.all(4),
      constraints: BoxConstraints(),
      style: IconButton.styleFrom(
        side: BorderSide(color: colorSecondary),
        backgroundColor: colorWhite,
      ),
    );
  }
}
