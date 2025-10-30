import 'package:charm/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.title,
    this.leading,
    this.actions,
    required this.body,
    this.showBack = true,
  });

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget body;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            if (title != null ||
                leading != null ||
                actions != null ||
                (showBack && Navigator.canPop(context)))
              MainAppBar(title: title, leading: leading, actions: actions, showBack: showBack),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
