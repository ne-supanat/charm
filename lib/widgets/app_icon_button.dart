import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({super.key, this.onPressed, required this.icon});

  final Function()? onPressed;
  final Widget icon;

  // use theme color

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      padding: EdgeInsets.all(4),
      constraints: BoxConstraints(),
      style: IconButton.styleFrom(
        side: BorderSide(color: Colors.blueGrey),
        backgroundColor: Color(0xFFEBEBEB),
      ),
    );
  }
}
