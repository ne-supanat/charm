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
    final leadingWidget =
        leading ?? ((showBack & Navigator.of(context).canPop()) ? MainBackButton() : null);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        spacing: 8,
        children: [
          if (leadingWidget != null) leadingWidget,
          Expanded(child: Text(title ?? "", style: Theme.of(context).textTheme.headlineLarge)),
          if (actions != null) Row(children: actions!),
        ],
      ),
    );
  }
}
