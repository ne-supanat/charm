import 'package:charm/data/model/tags_constant.dart';
import 'package:charm/global/colors.dart';
import 'package:charm/representation/display_new/display_new_bloc.dart';
import 'package:charm/representation/display_new/select_background_bottomsheet.dart';
import 'package:charm/representation/display_new/select_item_bottomsheet.dart';
import 'package:charm/representation/resource_bloc.dart';
import 'package:charm/widgets/charm.dart';
import 'package:charm/widgets/orbiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayNewView extends StatelessWidget {
  const DisplayNewView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DisplayNewBloc(DisplayNewState.init(context)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: colorBlack,
            body: BlocBuilder<DisplayNewBloc, DisplayNewState>(
              buildWhen: (previous, current) =>
                  previous.selectedBackgroundId != current.selectedBackgroundId,
              builder: (context, state) {
                return Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Image.asset(
                        context
                            .read<ResourceBloc>()
                            .getBackgroundById(state.selectedBackgroundId)!
                            .imageUrl,
                        fit: BoxFit.fitHeight,
                        repeat: ImageRepeat.repeatX,
                        errorBuilder: (context, error, stackTrace) => SizedBox(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: BlocBuilder<DisplayNewBloc, DisplayNewState>(
                        buildWhen: (previous, current) =>
                            previous.selectedItemId != current.selectedItemId,
                        builder: (context, state) {
                          return Charm(
                            item: context.read<ResourceBloc>().getItemById(state.selectedItemId)!,
                          );
                        },
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(16.0), child: OrbitingWidget()),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: buildButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: false,
                            builder: (btContext) {
                              return SelectBackgroundBottomsheet(
                                selectedId: context
                                    .read<DisplayNewBloc>()
                                    .state
                                    .selectedBackgroundId,
                                onChanged: (id) {
                                  context.read<DisplayNewBloc>().updateSelectedBackground(id);
                                },
                              );
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
                            builder: (btContext) {
                              final state = context.read<DisplayNewBloc>().state;
                              return SelectItemBottomsheet(
                                selectedId: state.selectedItemId,
                                onChanged: (id) {
                                  context.read<DisplayNewBloc>().updateSelectedItem(id);
                                },
                                onUpdateFilterCategory: (TagCategory value) {
                                  context.read<DisplayNewBloc>().updateSelectedTagCategory(value);
                                },
                                onUpdateFilterPower: (TagPower value) {
                                  context.read<DisplayNewBloc>().updateSelectedTagPower(value);
                                },
                              );
                            },
                          );
                        },
                        imagePath: 'icons/star.png',
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
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
