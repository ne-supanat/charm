import 'package:charm/features/component_detail_view.dart';
import 'package:charm/features/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/omamori_model.dart';
import '../widgets/app_icon_button.dart';
import '../widgets/app_text_button.dart';
import '../widgets/base_scaffold.dart';
import 'resource_bloc.dart';

class InspectDetailView extends StatelessWidget {
  const InspectDetailView({super.key, required this.omamoriModel});

  final OmamoriModel omamoriModel;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: omamoriModel.title,
      actions: [AppIconButton(onPressed: Navigator.of(context).pop, icon: Icon(Icons.close))],
      showBack: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (omamoriModel.description.isNotEmpty) Text(omamoriModel.description),
            if (omamoriModel.description.isNotEmpty) SizedBox(height: 16),
            Text('Material', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            buildComponentsText(context),
            SizedBox(height: 16),
            Text('Code', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('code'),
                AppTextButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: "code"));
                  },
                  text: 'Copy',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildComponentsText(BuildContext context) {
    // Expecteced output:
    // component1 • component2 • component3

    final ids = [
      omamoriModel.itemPrimaryId,
      omamoriModel.itemSecondaryId1,
      omamoriModel.itemSecondaryId2,
    ];

    final textSpans = <InlineSpan>[];

    for (int i = 0; i < ids.length; i++) {
      final item = context.read<ResourceBloc>().getItemById(ids[i]);

      if (item != null) {
        textSpans.add(
          TextSpan(
            text: item.name,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                pushView(context, ComponentDetailView(itemModel: item));
              },
          ),
        );

        if (i < ids.length - 1) {
          textSpans.add(TextSpan(text: " • "));
        }
      }
    }
    return Text.rich(TextSpan(children: textSpans));
  }
}
