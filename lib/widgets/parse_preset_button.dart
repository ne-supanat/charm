import 'package:charm/widgets/app_icon_button.dart';
import 'package:charm/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class ParsePresetButton extends StatelessWidget {
  const ParsePresetButton({super.key, required this.onConfirm});

  final Function(BuildContext btsContext) onConfirm;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext btsContext) {
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFFD9D9D9)),
                color: Colors.white,
              ),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Enter Code', textAlign: TextAlign.center),
                  AppTextFormField(hintText: "Code", onChanged: (value) {}),
                  FilledButton(
                    onPressed: () {
                      onConfirm(btsContext);
                    },
                    child: Text("Confirm"),
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: Icon(Icons.code_rounded),
    );
  }
}
