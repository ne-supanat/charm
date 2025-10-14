import 'package:charm/widgets/app_icon_button.dart';
import 'package:flutter/material.dart';

class MainBackButton extends StatelessWidget {
  const MainBackButton({super.key, this.askConfirm = false});

  final bool askConfirm;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onPressed: () async {
        if (askConfirm) {
          await showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                title: Text("Warning"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Unsaved changes will be loss, do you wish to continue?")],
                ),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text("Cancel"),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Confirm"),
                  ),
                ],
              );
            },
          );
        }
      },
      icon: Icon(Icons.arrow_back),
    );
  }
}
