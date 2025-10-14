import 'package:blur/blur.dart';
import 'package:charm/features/inspect_view.dart';
import 'package:charm/widgets/app_icon_button.dart';
import 'package:charm/widgets/main_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/customisation_constant.dart';
import '../models/item_model.dart';
import '../models/omamori_model.dart';
import '../widgets/app_text_button.dart';
import '../widgets/base_scaffold.dart';
import '../widgets/omamori_static.dart';
import '../widgets/parse_preset_button.dart';
import '../widgets/tag_filter_button.dart';
import 'component_detail_view.dart';
import 'customisation_bloc.dart';
import 'resource_bloc.dart';
import 'util.dart';

class CustomisationView extends StatefulWidget {
  const CustomisationView({super.key, this.omamoriModel});

  final OmamoriModel? omamoriModel;

  @override
  State<CustomisationView> createState() => _CustomisationViewState();
}

class _CustomisationViewState extends State<CustomisationView> {
  late TextEditingController textEditingControllerTitle;
  late TextEditingController textEditingControllerDesc;

  @override
  void initState() {
    super.initState();
    textEditingControllerTitle = TextEditingController(text: widget.omamoriModel?.title);
    textEditingControllerDesc = TextEditingController(text: widget.omamoriModel?.description);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomisationBloc(
        CustomisationState(omamoriModel: widget.omamoriModel ?? OmamoriModel.init()),
      ),
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
      leading: MainBackButton(askConfirm: true),
      actions: [
        AppTextButton(
          onPressed: () {
            // TODO: save to db
          },
          text: "Save",
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
                  spacing: 8,
                  children: [
                    AppTextButton(
                      onPressed: () {
                        context.read<CustomisationBloc>().updateFocusedEditing(
                          CustomisationConstant.description,
                        );
                      },
                      isFocused: state.focusedEditing == CustomisationConstant.description,
                      text: 'Information',
                    ),
                    AppTextButton(
                      onPressed: () {
                        context.read<CustomisationBloc>().updateFocusedEditing(
                          CustomisationConstant.components,
                        );
                      },
                      isFocused: state.focusedEditing == CustomisationConstant.components,
                      text: 'Components',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: state.focusedEditing == CustomisationConstant.description
                    ? buildDescriptionView(context)
                    : buildComponentView(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildDescriptionView(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          TextField(
            controller: textEditingControllerTitle,
            decoration: InputDecoration(
              hintText: "Preset Name",
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          TextField(
            controller: textEditingControllerDesc,
            decoration: InputDecoration(
              hintText: "Description",
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(),
            ),
            minLines: 3,
            maxLines: null,
          ),
          SizedBox(height: 16),
          Center(
            child: ParsePresetButton(
              onConfirm: (BuildContext btsContext) {
                final bloc = context.read<CustomisationBloc>();
                bloc.parseFromCode("");

                textEditingControllerTitle.text = bloc.state.omamoriModel?.title ?? "";
                textEditingControllerDesc.text = bloc.state.omamoriModel?.description ?? "";

                Navigator.of(btsContext).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildComponentView(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Blur(
                            blur: 5,
                            child: SizedBox(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              child: Image.network("https://picsum.photos/200", fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: OmamoriStatic(
                            omamoriModel: context.read<CustomisationBloc>().state.omamoriModel!,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: AppIconButton(
                    onPressed: () {
                      pushView(
                        context,
                        InspectView(
                          omamoriModel: context.read<CustomisationBloc>().state.omamoriModel!,
                        ),
                      );
                    },
                    icon: Icon(Icons.zoom_in),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: BlocBuilder<CustomisationBloc, CustomisationState>(
            buildWhen: (previous, current) =>
                previous.focusedCustomisationComponent != current.focusedCustomisationComponent,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 8,
                      children: [
                        buildComponentTopic(
                          context: context,
                          componentName: ComponentConstant.background,
                          text: 'Background',
                          isFocused:
                              state.focusedCustomisationComponent == ComponentConstant.background,
                        ),
                        buildComponentTopic(
                          context: context,
                          componentName: ComponentConstant.shape,
                          text: 'Shape',
                          isFocused: state.focusedCustomisationComponent == ComponentConstant.shape,
                        ),
                        buildComponentTopic(
                          context: context,
                          componentName: ComponentConstant.itemPrimary,
                          text: 'Component I',
                          isFocused:
                              state.focusedCustomisationComponent == ComponentConstant.itemPrimary,
                        ),
                        buildComponentTopic(
                          context: context,
                          componentName: ComponentConstant.itemSecondary1,
                          text: 'Component II',
                          isFocused:
                              state.focusedCustomisationComponent ==
                              ComponentConstant.itemSecondary1,
                        ),
                        buildComponentTopic(
                          context: context,
                          componentName: ComponentConstant.itemSecondary2,
                          text: 'Component III',
                          isFocused:
                              state.focusedCustomisationComponent ==
                              ComponentConstant.itemSecondary2,
                        ),
                      ],
                    ),
                  ),
                  Divider(indent: 16, endIndent: 16, color: Color(0xFFD9D9D9)),
                  if ([
                    ComponentConstant.itemPrimary,
                    ComponentConstant.itemSecondary1,
                    ComponentConstant.itemSecondary2,
                  ].contains(state.focusedCustomisationComponent))
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TagFilterButton(
                            initTag: state.selectedTag,
                            onChanged: (tag) {
                              context.read<CustomisationBloc>().updateTag(tag);
                            },
                          ),
                        ),
                      ],
                    ),
                  Expanded(
                    child:
                        {
                              ComponentConstant.background: buildComponentBackground(
                                context: context,
                              ),
                              ComponentConstant.shape: buildComponentShape(context: context),
                              ComponentConstant.itemPrimary: buildComponentItem1(context: context),
                              ComponentConstant.itemSecondary1: buildComponentItem2(
                                context: context,
                              ),
                              ComponentConstant.itemSecondary2: buildComponentItem3(
                                context: context,
                              ),
                            }[state.focusedCustomisationComponent]
                            as Widget,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildComponentTopic({
    required BuildContext context,
    required ComponentConstant componentName,
    required String text,
    required bool isFocused,
  }) {
    return AppTextButton(
      onPressed: () {
        context.read<CustomisationBloc>().updateFocusedComponent(componentName);
      },
      isFocused: isFocused,
      text: text,
    );
  }

  Widget buildComponentSelectSection({
    required BuildContext context,
    required List items,
    required bool Function(CustomisationState previous, CustomisationState current)? buildWhen,
    required Widget Function(CustomisationState state, dynamic item) buildChild,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: BlocBuilder<CustomisationBloc, CustomisationState>(
        buildWhen: buildWhen,
        builder: (context, state) {
          return Wrap(
            runSpacing: 16,
            alignment: WrapAlignment.spaceBetween,
            children: items.map((e) => buildChild(state, e)).toList(),
          );
        },
      ),
    );
  }

  Widget buildComponentBackground<S>({required BuildContext context}) {
    // TODO: select color
    return buildComponentSelectSection(
      context: context,
      items: context.read<ResourceBloc>().state.backgrounds.values.toList(),
      buildWhen: (previous, current) =>
          previous.omamoriModel?.backgroundId != current.omamoriModel?.backgroundId,
      buildChild: (state, item) => _buildBox(
        onTap: () {
          context.read<CustomisationBloc>().updateBackground(item.id);
        },
        isSelected: state.omamoriModel?.backgroundId == item.id,
        child: Center(child: Text(item.id)),
      ),
    );
  }

  Widget buildComponentShape<S>({required BuildContext context}) {
    return buildComponentSelectSection(
      context: context,
      items: context.read<ResourceBloc>().state.shapes.values.toList(),
      buildWhen: (previous, current) =>
          previous.omamoriModel?.shapeId != current.omamoriModel?.shapeId,
      buildChild: (state, item) => _buildBox(
        onTap: () {
          context.read<CustomisationBloc>().updateShape(item.id);
        },
        isSelected: state.omamoriModel?.shapeId == item.id,
        child: Center(child: Text(item.id)),
      ),
    );
  }

  Widget buildComponentItem1<S>({required BuildContext context}) {
    return buildComponentSelectSection(
      context: context,
      items: context.read<ResourceBloc>().state.items.values.toList(),
      buildWhen: (previous, current) =>
          previous.omamoriModel?.itemPrimaryId != current.omamoriModel?.itemPrimaryId,
      buildChild: (state, item) => _buildBox(
        onTap: () {
          context.read<CustomisationBloc>().updateItemPrimary(item.id);
        },
        isSelected: state.omamoriModel?.itemPrimaryId == item.id,
        child: _buildItemBox(context, item, state.omamoriModel?.itemPrimaryId == item.id),
        label: item.name,
      ),
    );
  }

  Widget buildComponentItem2<S>({required BuildContext context}) {
    return buildComponentSelectSection(
      context: context,
      items: context.read<ResourceBloc>().state.items.values.toList(),
      buildWhen: (previous, current) =>
          previous.omamoriModel?.itemSecondaryId1 != current.omamoriModel?.itemSecondaryId1,
      buildChild: (state, item) => _buildBox(
        onTap: () {
          context.read<CustomisationBloc>().updateItemSecondary1(item.id);
        },
        isSelected: state.omamoriModel?.itemSecondaryId1 == item.id,
        child: _buildItemBox(context, item, state.omamoriModel?.itemSecondaryId1 == item.id),
        label: item.name,
      ),
    );
  }

  Widget buildComponentItem3<S>({required BuildContext context}) {
    return buildComponentSelectSection(
      context: context,
      items: context.read<ResourceBloc>().state.items.values.toList(),
      buildWhen: (previous, current) =>
          previous.omamoriModel?.itemSecondaryId2 != current.omamoriModel?.itemSecondaryId2,
      buildChild: (state, item) => _buildBox(
        onTap: () {
          context.read<CustomisationBloc>().updateItemSecondary2(item.id);
        },
        isSelected: state.omamoriModel?.itemSecondaryId2 == item.id,
        child: _buildItemBox(context, item, state.omamoriModel?.itemSecondaryId2 == item.id),
        label: item.name,
      ),
    );
  }

  Widget _buildBox({
    required Function() onTap,
    required bool isSelected,
    required Widget child,
    String? label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(maxWidth: 75),
        child: Column(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: BoxBorder.all(color: Colors.blueGrey, width: isSelected ? 2 : 1),
              ),
              child: Center(child: child),
            ),
            if (label != null)
              Text(
                label,
                style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }

  _buildItemBox(BuildContext context, ItemModel item, bool isSelected) {
    return Stack(
      children: [
        Center(child: Text(item.id)),
        if (isSelected)
          Positioned(
            top: 4,
            right: 4,
            child: AppIconButton(
              onPressed: () {
                pushView(context, ComponentDetailView(itemModel: item));
              },
              icon: Icon(Icons.zoom_in),
            ),
          ),
      ],
    );
  }
}
