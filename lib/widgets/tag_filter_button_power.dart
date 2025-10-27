import 'package:charm/data/model/tags_constant.dart';
import 'package:charm/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';

class TagFilterPowerButton extends StatefulWidget {
  const TagFilterPowerButton({super.key, this.initValue = TagPower.all, required this.onChanged});

  final TagPower initValue;
  final Function(TagPower selectedTag) onChanged;

  @override
  State<TagFilterPowerButton> createState() => _TagFilterPowerButtonState();
}

class _TagFilterPowerButtonState extends State<TagFilterPowerButton> {
  final popupKey = GlobalKey<CustomPopupState>();
  late TagPower selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPopup(
      key: popupKey,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: TagPower.values.map((element) => _buildOptionItem(element)).toList(),
      ),
      barrierColor: Colors.transparent,
      position: PopupPosition.bottom,
      child: AppTextButton(
        onPressed: () {
          popupKey.currentState?.show();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Row(children: [Text('Aspect: ${selectedValue.displayName}')]),
        ),
      ),
    );
  }

  Widget _buildOptionItem(TagPower value) {
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
