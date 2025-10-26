import 'package:charm/data/model/item_model.dart';
import 'package:charm/global/colors.dart';
import 'package:charm/representation/component_detail_view.dart';
import 'package:charm/representation/resource_bloc.dart';
import 'package:charm/representation/util.dart';
import 'package:charm/widgets/app_icon_button.dart';
import 'package:charm/widgets/tag_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectItemBottomsheet extends StatefulWidget {
  const SelectItemBottomsheet({super.key, this.selectedId, required this.onChanged});

  final int? selectedId;
  final Function(int index) onChanged;

  @override
  State<SelectItemBottomsheet> createState() => _SelectItemBottomsheetState();
}

class _SelectItemBottomsheetState extends State<SelectItemBottomsheet> {
  late Map<int, ItemModel> itemMap;
  late int selectedId = 0;

  @override
  void initState() {
    super.initState();
    itemMap = context.read<ResourceBloc>().state.items;
    selectedId = widget.selectedId ?? itemMap.keys.first;
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [TagFilterButton(onChanged: (value) {})],
            ),
          ),
          Divider(height: 0),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              itemBuilder: (context, index) {
                final item = itemMap.values.toList()[index];
                final isSelected = selectedId == item.id;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedId = item.id;
                    });

                    widget.onChanged(index);
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
                        child: Image.asset(
                          item.imageUrl,
                          errorBuilder: (context, error, stackTrace) => SizedBox(),
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
                          pushView(context, ComponentDetailView(itemModel: item));
                        },
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: itemMap.length,
            ),
          ),
        ],
      ),
    );
  }
}
