import 'package:charm/data/model/tags_constant.dart';
import 'package:charm/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';

class TagFilterButton extends StatefulWidget {
  const TagFilterButton({super.key, this.initTag = Tag.all, required this.onChanged});

  final Tag initTag;
  final Function(Tag selectedTag) onChanged;

  @override
  State<TagFilterButton> createState() => _TagFilterButtonState();
}

class _TagFilterButtonState extends State<TagFilterButton> {
  final popupKey = GlobalKey<CustomPopupState>();
  late Tag selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initTag;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPopup(
      key: popupKey,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: Tag.values.map((element) => _buildOptionItem(element)).toList(),
      ),
      barrierColor: Colors.transparent,
      position: PopupPosition.bottom,
      child: AppTextButton(
        onPressed: () {
          popupKey.currentState?.show();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            children: [
              Text('Display: ${selectedValue.displayName}'),
              SizedBox(width: 4),
              Icon(Icons.filter_alt_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem(Tag value) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedValue = value;
        });

        widget.onChanged(value);

        Navigator.of(context).pop();
      },
      child: Container(
        width: 120,
        color: selectedValue == value ? Colors.grey.shade300 : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value.displayName, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
