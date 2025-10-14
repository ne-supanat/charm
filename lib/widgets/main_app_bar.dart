import 'package:charm/widgets/main_back_button.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key, this.title, this.leading, this.actions, this.showBack = true});

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        spacing: 8,
        children: [
          leading ?? ((showBack & Navigator.of(context).canPop()) ? MainBackButton() : SizedBox()),
          Expanded(
            child: Text(
              title ?? "",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF6A6A6A)),
            ),
          ),
          if (actions != null) Row(children: actions!),
        ],
      ),
    );
  }
}
