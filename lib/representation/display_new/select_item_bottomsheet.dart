import 'package:charm/widgets/tag_filter_button_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/item_model.dart';
import '../../data/model/tags_constant.dart';
import '../../global/colors.dart';
import '../../widgets/app_icon_button.dart';
import '../../widgets/tag_filter_button_power.dart';
import '../item_detail/item_detail_view.dart';
import '../resource_bloc.dart';
import '../util.dart';

class SelectItemBottomsheet extends StatefulWidget {
  const SelectItemBottomsheet({
    super.key,
    this.selectedId,
    this.selectedTagCategory = TagCategory.all,
    this.selectedTagPower = TagPower.all,
    required this.onChanged,
    required this.onUpdateFilterCategory,
    required this.onUpdateFilterPower,
  });

  final int? selectedId;
  final TagCategory selectedTagCategory;
  final TagPower selectedTagPower;
  final Function(int id) onChanged;
  final Function(TagCategory) onUpdateFilterCategory;
  final Function(TagPower) onUpdateFilterPower;

  @override
  State<SelectItemBottomsheet> createState() => _SelectItemBottomsheetState();
}

class _SelectItemBottomsheetState extends State<SelectItemBottomsheet> {
  late List<ItemModel> items;
  late List<ItemModel> displayedItems;
  late int selectedId;

  late TagCategory selectedTagCategory;
  late TagPower selectedTagPower;

  @override
  void initState() {
    super.initState();
    items = context.read<ResourceBloc>().state.items.values.toList();
    selectedId = widget.selectedId ?? items.first.id;

    selectedTagCategory = widget.selectedTagCategory;
    selectedTagPower = widget.selectedTagPower;
    updateDisplayItems();
  }

  void updateDisplayItems() {
    displayedItems = List<ItemModel>.from(items)
        .where(
          (element) =>
              (selectedTagCategory == TagCategory.all
                  ? true
                  : element.tags.contains(selectedTagCategory.displayName)) &&
              (selectedTagPower == TagPower.all
                  ? true
                  : element.tags.contains(selectedTagPower.displayName)),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        border: Border.all(color: colorPrimary),
        color: colorWhite,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TagFilterCategoryButton(
                  initValue: widget.selectedTagCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedTagCategory = value;
                      updateDisplayItems();
                    });
                    widget.onUpdateFilterCategory(value);
                  },
                ),
                TagFilterPowerButton(
                  initValue: widget.selectedTagPower,
                  onChanged: (value) {
                    setState(() {
                      selectedTagPower = value;
                      updateDisplayItems();
                    });
                    widget.onUpdateFilterPower(value);
                  },
                ),
              ],
            ),
          ),
          Divider(height: 0),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              itemBuilder: (context, index) {
                final item = displayedItems[index];
                final isSelected = selectedId == item.id;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedId = item.id;
                    });

                    widget.onChanged(item.id);
                  },
                  child: Row(
                    spacing: 16,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorPrimary,
                          border: Border.all(
                            color: isSelected ? colorSecondary : colorPrimary,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'images/${item.imageUrl}',
                            errorBuilder: (context, error, stackTrace) => SizedBox(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            Text(
                              item.tags.join(" • "),
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(color: colorSecondary),
                            ),
                          ],
                        ),
                      ),
                      AppIconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          pushView(context, ItemDetailView(itemModel: item));
                        },
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: displayedItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
