import 'package:charm/global/colors.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({super.key, this.onPressed, this.text, this.child, this.isFocused = false});

  final Function()? onPressed;
  final String? text;
  final Widget? child;
  final bool isFocused;

  // use theme color

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: colorPrimary, width: isFocused ? 2 : 1),
          ),
          child:
              child ??
              Text(
                text ?? "",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isFocused ? FontWeight.bold : FontWeight.normal,
                ),
              ),
        ),
      ),
    );
  }
}
