import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/customisation_constant.dart';
import '../global/colors.dart';
import '../widgets/omamori_static.dart';
import '../widgets/parse_preset_button.dart';
import 'customisation_bloc.dart';
import 'customisation_component_selection_widget.dart';
import 'inspect_view.dart';
import 'util.dart';

class CustomisationComponentWidget extends StatelessWidget {
  const CustomisationComponentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8,
            children: [
              SizedBox(width: 32),
              FilledButton(
                onPressed: () {
                  pushView(
                    context,
                    InspectView(omamoriModel: context.read<CustomisationBloc>().state.omamoriModel),
                  );
                },
                child: Text('Preview'),
              ),
              ParsePresetButton(
                onConfirm: (BuildContext btsContext) {
                  final bloc = context.read<CustomisationBloc>();
                  bloc.parseFromCode("");

                  Navigator.of(btsContext).pop();
                },
              ),
            ],
          ),
        ),
        BlocBuilder<CustomisationBloc, CustomisationState>(
          buildWhen: (previous, current) =>
              previous.focusedCustomisationComponent != current.focusedCustomisationComponent,
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      buildComponentTopicBox(
                        context: context,
                        state: state,
                        componentName: ComponentConstant.background,
                      ),
                      buildComponentTopicBox(
                        context: context,
                        state: state,
                        componentName: ComponentConstant.pattern,
                      ),
                    ],
                  ),
                  Container(
                    width: 150,
                    height: 150,
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
                          child: Center(
                            child: OmamoriStatic(
                              omamoriModel: context.read<CustomisationBloc>().state.omamoriModel,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      buildComponentTopicBox(
                        context: context,
                        state: state,
                        componentName: ComponentConstant.item1,
                      ),
                      buildComponentTopicBox(
                        context: context,
                        state: state,
                        componentName: ComponentConstant.item2,
                      ),
                      buildComponentTopicBox(
                        context: context,
                        state: state,
                        componentName: ComponentConstant.item3,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        Expanded(child: CustomisationComponentSelectionWidget()),
      ],
    );
  }

  Widget buildComponentTopicBox({
    required BuildContext context,
    required ComponentConstant componentName,
    required CustomisationState state,
  }) {
    return InkWell(
      onTap: () {
        context.read<CustomisationBloc>().updateFocusedComponent(componentName);
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colorPrimary,
            width: state.focusedCustomisationComponent == componentName ? 2 : 1,
          ),
        ),
      ),
    );
  }
}
