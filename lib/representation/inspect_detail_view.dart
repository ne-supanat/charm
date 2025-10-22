import 'package:charm/global/colors.dart';
import 'package:charm/representation/component_detail_view.dart';
import 'package:charm/representation/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/omamori_model.dart';
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
            if (omamoriModel.description?.isNotEmpty ?? false)
              Text(omamoriModel.description!, style: Theme.of(context).textTheme.bodyMedium),
            if (omamoriModel.description?.isNotEmpty ?? false) SizedBox(height: 16),
            Text('Material', style: Theme.of(context).textTheme.titleMedium),
            buildComponentsText(context),
            SizedBox(height: 16),
            Text('Code', style: Theme.of(context).textTheme.titleMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  convertOmamoriToCode(omamoriModel),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                AppTextButton(
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: convertOmamoriToCode(omamoriModel)),
                    );
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

    final ids = [];
    if (omamoriModel.item1Id != null) {
      ids.add(omamoriModel.item1Id);
    }
    if (omamoriModel.item2Id != null) {
      ids.add(omamoriModel.item2Id);
    }
    if (omamoriModel.item3Id != null) {
      ids.add(omamoriModel.item3Id);
    }

    final textSpans = <InlineSpan>[];

    for (int i = 0; i < ids.length; i++) {
      final item = context.read<ResourceBloc>().getItemById(ids[i]!);

      if (item != null) {
        textSpans.add(
          TextSpan(
            text: item.name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorSecondary),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                pushView(context, ComponentDetailView(itemModel: item));
              },
          ),
        );

        if (i < ids.length - 1) {
          textSpans.add(TextSpan(text: " • ", style: Theme.of(context).textTheme.bodyMedium));
        }
      }
    }
    return Text.rich(TextSpan(children: textSpans));
  }
}
