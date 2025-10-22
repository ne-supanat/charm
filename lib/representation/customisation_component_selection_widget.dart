import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/background_model.dart';
import '../data/model/customisation_constant.dart';
import '../data/model/item_model.dart';
import '../data/model/pattern_model.dart';
import '../global/colors.dart';
import '../widgets/tag_filter_button.dart';
import 'component_detail_view.dart';
import 'customisation_bloc.dart';
import 'resource_bloc.dart';
import 'util.dart';

class CustomisationComponentSelectionWidget extends StatelessWidget {
  const CustomisationComponentSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomisationBloc, CustomisationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: Divider()),
            buildHeader(context, state),
            buildSelectionSection(context, state),
          ],
        );
      },
    );
  }

  Widget buildHeader(BuildContext context, CustomisationState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            state.focusedCustomisationComponent.displayName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
          ),
          if (isSelectingItem(state))
            TagFilterButton(
              initTag: state.selectedTag,
              onChanged: (tag) {
                context.read<CustomisationBloc>().updateTag(tag);
              },
            ),
        ],
      ),
    );
  }

  bool isSelectingItem(CustomisationState state) {
    return [
      ComponentConstant.item1,
      ComponentConstant.item2,
      ComponentConstant.item3,
    ].contains(state.focusedCustomisationComponent);
  }

  Widget buildSelectionSection(BuildContext context, CustomisationState state) {
    final focusedComponent = state.focusedCustomisationComponent;
    final int? selectedItemId = {
      ComponentConstant.background: state.selectedBackgroundId,
      ComponentConstant.pattern: state.selectedPatternId,
      ComponentConstant.item1: state.selectedItem1Id,
      ComponentConstant.item2: state.selectedItem2Id,
      ComponentConstant.item3: state.selectedItem3Id,
    }[focusedComponent];

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final columnSize = (constraints.maxWidth / 80).floor();

                return {
                      ComponentConstant.background: buildBackgroundSelection(
                        context,
                        state,
                        columnSize,
                      ),
                      ComponentConstant.pattern: buildPatternSelection(context, state, columnSize),
                      ComponentConstant.item1: buildItem1Selection(context, state, columnSize),
                      ComponentConstant.item2: buildItem2Selection(context, state, columnSize),
                      ComponentConstant.item3: buildItem3Selection(context, state, columnSize),
                    }[state.focusedCustomisationComponent]
                    as Widget;
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colorGrey)),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isSelectingItem(state))
                  OutlinedButton(
                    onPressed: () {
                      pushView(
                        context,
                        ComponentDetailView(
                          itemModel: context.read<ResourceBloc>().state.items[selectedItemId]!,
                        ),
                      );
                    },
                    child: Text("Detail"),
                  ),
                FilledButton(
                  onPressed: () {
                    switch (focusedComponent) {
                      case ComponentConstant.background:
                        context.read<CustomisationBloc>().updateBackground(selectedItemId);
                        break;
                      case ComponentConstant.pattern:
                        context.read<CustomisationBloc>().updatePattern(selectedItemId);
                        break;
                      case ComponentConstant.item1:
                        context.read<CustomisationBloc>().updateItem1(selectedItemId!);
                        break;
                      case ComponentConstant.item2:
                        context.read<CustomisationBloc>().updateItem2(selectedItemId!);
                        break;
                      case ComponentConstant.item3:
                        context.read<CustomisationBloc>().updateItem3(selectedItemId!);
                        break;
                    }
                  },
                  child: Text("Use"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBackgroundSelection(BuildContext context, CustomisationState state, int columnCount) {
    return buildBoxSelection<BackgroundModel>(
      // context.read<ResourceBloc>().state.backgrounds.toList(),
      [
        BackgroundModel(id: 1, imageUrl: "imageUrl"),
        BackgroundModel(id: 2, imageUrl: "imageUrl"),
        BackgroundModel(id: 3, imageUrl: "imageUrl"),
        BackgroundModel(id: 4, imageUrl: "imageUrl"),
        BackgroundModel(id: 5, imageUrl: "imageUrl"),
        BackgroundModel(id: 6, imageUrl: "imageUrl"),
      ],
      (e) => _buildBox(
        onTap: () {
          context.read<CustomisationBloc>().selectBackground(e.id);
        },
        isUsed: state.omamoriModel.backgroundId == e.id,
        isSelected: state.selectedBackgroundId == e.id,
        child: Text(e.id.toString()),
      ),
      columnCount,
    );
  }

  Widget buildPatternSelection(BuildContext context, CustomisationState state, int columnCount) {
    return buildBoxSelection<PatternModel>(
      // context.read<ResourceBloc>().state.patterns.values.toList(),
      [
        PatternModel(id: 1, imageUrl: "imageUrl"),
        PatternModel(id: 2, imageUrl: "imageUrl"),
        PatternModel(id: 3, imageUrl: "imageUrl"),
        PatternModel(id: 4, imageUrl: "imageUrl"),
        PatternModel(id: 5, imageUrl: "imageUrl"),
        PatternModel(id: 6, imageUrl: "imageUrl"),
      ],
      (e) => _buildBox(
        onTap: () {
          context.read<CustomisationBloc>().selectPattern(e.id);
        },
        isUsed: state.omamoriModel.patternId == e.id,
        isSelected: state.selectedPatternId == e.id,
        child: Text(e.id.toString()),
      ),
      columnCount,
    );
  }

  Widget buildBoxSelection<T>(List<T> items, Widget Function(T item) buildChild, int columnCount) {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shrinkWrap: true,
      crossAxisCount: columnCount,
      childAspectRatio: 1,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: items.map((e) => buildChild(e)).toList(),
    );
  }

  Widget buildItem1Selection(BuildContext context, CustomisationState state, int columnCount) {
    return buildItemSelection(
      context: context,
      onTap: (e) {
        context.read<CustomisationBloc>().selectItem1(e.id);
      },
      isUsed: (e) => state.omamoriModel.item1Id == e.id,
      isSelected: (e) => state.selectedItem1Id == e.id,
      columnCount: columnCount,
    );
  }

  Widget buildItem2Selection(BuildContext context, CustomisationState state, int columnCount) {
    return buildItemSelection(
      context: context,
      onTap: (e) {
        context.read<CustomisationBloc>().selectItem2(e.id);
      },
      isUsed: (e) => state.omamoriModel.item2Id == e.id,
      isSelected: (e) => state.selectedItem2Id == e.id,
      columnCount: columnCount,
    );
  }

  Widget buildItem3Selection(BuildContext context, CustomisationState state, int columnCount) {
    return buildItemSelection(
      context: context,
      onTap: (e) {
        context.read<CustomisationBloc>().selectItem3(e.id);
      },
      isUsed: (e) => state.omamoriModel.item3Id == e.id,
      isSelected: (e) => state.selectedItem3Id == e.id,
      columnCount: columnCount,
    );
  }

  Widget buildItemSelection({
    required BuildContext context,
    required Function(ItemModel e) onTap,
    required bool Function(ItemModel e) isUsed,
    required bool Function(ItemModel e) isSelected,
    required int columnCount,
  }) {
    final items =
        // context.read<ResourceBloc>().state.items.values.toList(),;
        [
          ItemModel(
            id: 1,
            name: "name1",
            imageUrl: "imageUrl",
            tags: [],
            description: 'description',
          ),
          ItemModel(
            id: 2,
            name: "name2",
            imageUrl: "imageUrl",
            tags: [],
            description: 'description',
          ),
          ItemModel(
            id: 3,
            name: "name3",
            imageUrl: "imageUrl",
            tags: [],
            description: 'description',
          ),
          ItemModel(
            id: 4,
            name: "name4",
            imageUrl: "imageUrl",
            tags: [],
            description: 'description',
          ),
          ItemModel(
            id: 5,
            name: "name5",
            imageUrl: "imageUrl",
            tags: [],
            description: 'description',
          ),
        ];

    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shrinkWrap: true,
      crossAxisCount: columnCount,
      childAspectRatio: 75 / 100,
      mainAxisSpacing: 4,
      crossAxisSpacing: 16,
      children: items
          .map(
            (e) => _buildBox(
              onTap: () {
                onTap(e);
              },
              isUsed: isUsed(e),
              isSelected: isSelected(e),
              label: e.name,
              child: Text(e.id.toString()),
            ),
          )
          .toList(),
    );
  }

  Widget _buildBox({
    required Function() onTap,
    required bool isUsed,
    required bool isSelected,
    required Widget child,
    String? label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentGeometry.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(16),
                    border: BoxBorder.all(color: Colors.blueGrey, width: isSelected ? 2 : 1),
                  ),
                  child: Center(child: child),
                ),
              ),
              if (isUsed) Icon(Icons.check_circle_rounded, color: colorPrimary),
            ],
          ),
          if (label != null)
            Text(
              label,
              style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
