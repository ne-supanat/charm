import 'package:charm/data/model/background_model.dart';
import 'package:charm/global/colors.dart';
import 'package:charm/representation/resource_bloc.dart';
import 'package:charm/representation/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectBackgroundBottomsheet extends StatefulWidget {
  const SelectBackgroundBottomsheet({super.key, this.selectedId, required this.onChanged});

  final int? selectedId;
  final Function(int id) onChanged;

  @override
  State<SelectBackgroundBottomsheet> createState() => _SelectBackgroundBottomsheetState();
}

class _SelectBackgroundBottomsheetState extends State<SelectBackgroundBottomsheet> {
  late Map<int, BackgroundModel> backgroundMap;
  late int selectedId;

  @override
  void initState() {
    super.initState();
    backgroundMap = context.read<ResourceBloc>().state.backgrounds;
    selectedId = widget.selectedId ?? backgroundMap.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        border: Border.all(color: colorPrimary),
        color: colorWhite,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                backgroundMap[selectedId]?.name ?? "",
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            constraints: BoxConstraints(maxHeight: 52),
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final background = backgroundMap.values.toList()[index];
                final isSelected = selectedId == background.id;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedId = background.id;
                    });

                    widget.onChanged(background.id);
                  },
                  child: Container(
                    width: 52,
                    height: 52,
                    padding: EdgeInsets.all(2),
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
                        'images/${useWebLayout(context) ? background.imageUrlWeb : background.imageUrlMobile}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => SizedBox(),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 10);
              },
              itemCount: backgroundMap.length,
            ),
          ),
        ],
      ),
    );
  }
}
