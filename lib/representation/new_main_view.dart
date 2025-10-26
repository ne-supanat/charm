import 'package:charm/global/colors.dart';
import 'package:charm/representation/select_background_bottomsheet.dart';
import 'package:charm/representation/select_item_bottomsheet.dart';
import 'package:charm/widgets/charm.dart';
import 'package:charm/widgets/orbiting_widget.dart';
import 'package:flutter/material.dart';

class NewMainView extends StatelessWidget {
  const NewMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg_night_mobile.png"),
            fit: BoxFit.fitHeight,
            repeat: ImageRepeat.repeatX,
          ),
        ),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Padding(padding: const EdgeInsets.all(48.0), child: Charm()),
            Padding(padding: const EdgeInsets.all(16.0), child: OrbitingWidget()),
            Positioned(
              bottom: 16,
              left: 16,
              child: buildButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    builder: (context) {
                      return SelectBackgroundBottomsheet(selectedId: null, onChanged: (index) {});
                    },
                  );
                },
                imagePath: 'icons/image.png',
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: buildButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return SelectItemBottomsheet(selectedId: null, onChanged: (index) {});
                    },
                  );
                },
                imagePath: 'icons/star.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton({required void Function() onPressed, required String imagePath}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromRGBO(234, 223, 204, 1),
        border: Border.all(color: colorSecondary, width: 2),
        boxShadow: [BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(0, 0))],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: ImageIcon(AssetImage(imagePath), color: colorSecondary),
      ),
    );
  }
}
