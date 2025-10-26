import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/customisation_constant.dart';
import '../../data/model/charm_model.dart';
import '../../global/colors.dart';
import '../../widgets/base_scaffold.dart';
import '../../widgets/main_back_button.dart';
import '../catalog/catalog_bloc.dart';
import 'customisation_bloc.dart';
import 'customisation_component_widget.dart';
import 'customisation_description_widget.dart';

class CustomisationView extends StatefulWidget {
  const CustomisationView({super.key, required this.charmModel});

  final CharmModel charmModel;

  @override
  State<CustomisationView> createState() => _CustomisationViewState();
}

class _CustomisationViewState extends State<CustomisationView> {
  late TextEditingController textEditingControllerTitle;
  late TextEditingController textEditingControllerDesc;

  @override
  void initState() {
    super.initState();
    textEditingControllerTitle = TextEditingController(text: widget.charmModel.title);
    textEditingControllerDesc = TextEditingController(text: widget.charmModel.description);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CustomisationBloc(CustomisationState(charmModel: widget.charmModel))..init(),
      child: Builder(
        builder: (context) {
          return buildContent(context);
        },
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return BaseScaffold(
      title: "Customisation",
      leading: MainBackButton(
        onPressed: () async {
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
                      Navigator.of(dialogContext).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text("Confirm"),
                  ),
                ],
              );
            },
          );
        },
      ),
      actions: [
        OutlinedButton(
          onPressed: () async {
            try {
              await context.read<CustomisationBloc>().save();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved')));

              await context.read<CatalogBloc>().loadCatalog();
            } on HttpException catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
            }
          },
          child: Text("Save"),
        ),
      ],
      body: BlocBuilder<CustomisationBloc, CustomisationState>(
        buildWhen: (previous, current) => previous.focusedEditing != current.focusedEditing,
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  spacing: 8,
                  children: [
                    Expanded(
                      child: buildEditingTopic(
                        text: "Information",
                        isSelected: state.focusedEditing == CustomisationConstant.description,
                        onTap: () {
                          context.read<CustomisationBloc>().updateFocusedEditing(
                            CustomisationConstant.description,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: buildEditingTopic(
                        text: "Components",
                        isSelected: state.focusedEditing == CustomisationConstant.components,
                        onTap: () {
                          context.read<CustomisationBloc>().updateFocusedEditing(
                            CustomisationConstant.components,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 0),
              SizedBox(height: 16),
              Expanded(
                child: state.focusedEditing == CustomisationConstant.description
                    ? CustomisationDescriptionWidget(
                        textEditingControllerTitle: textEditingControllerTitle,
                        textEditingControllerDesc: textEditingControllerDesc,
                      )
                    : CustomisationComponentWidget(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildEditingTopic({
    required String text,
    required bool isSelected,
    required Function() onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicWidth(
            child: Column(
              children: [
                Text(text, style: Theme.of(context).textTheme.titleMedium),
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: isSelected ? colorPrimary : Colors.transparent,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
