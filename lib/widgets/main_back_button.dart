import 'package:charm/widgets/app_icon_button.dart';
import 'package:flutter/material.dart';

class MainBackButton extends StatelessWidget {
  const MainBackButton({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onPressed:
          onPressed ??
          () {
            Navigator.of(context).pop();
          },
      icon: Icon(Icons.arrow_back_rounded),
    );
  }
}
