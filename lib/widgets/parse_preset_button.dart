import 'package:charm/widgets/app_text_button.dart';
import 'package:flutter/material.dart';

class ParsePresetButton extends StatelessWidget {
  const ParsePresetButton({super.key, required this.onConfirm});

  final Function(BuildContext btsContext) onConfirm;

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
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
                  const Text('Enter Preset Code', textAlign: TextAlign.center),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Code",
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
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
      text: 'Parse Preset Code',
    );
  }
}
