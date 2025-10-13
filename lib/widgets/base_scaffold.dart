import 'package:charm/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.title,
    this.actions,
    required this.body,
    this.showBack = true,
  });

  final String? title;
  final List<Widget>? actions;
  final Widget body;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEBEBEB),
        body: Column(
          children: [
            MainAppBar(title: title, actions: actions, showBack: showBack),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
