import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/app_text_form_field.dart';
import 'customisation_bloc.dart';

class CustomisationDescriptionWidget extends StatelessWidget {
  const CustomisationDescriptionWidget({
    super.key,
    required this.textEditingControllerTitle,
    required this.textEditingControllerDesc,
  });

  final TextEditingController textEditingControllerTitle;
  final TextEditingController textEditingControllerDesc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name", style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 8),
          AppTextFormField(
            hintText: "Preset Name",
            controller: textEditingControllerTitle,
            onChanged: (value) {
              context.read<CustomisationBloc>().updateTitle(value);
            },
          ),

          SizedBox(height: 16),
          Text("Description", style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 8),
          AppTextFormField(
            hintText: "Description",
            controller: textEditingControllerDesc,
            onChanged: (value) {
              context.read<CustomisationBloc>().updateDescription(value);
            },
          ),
        ],
      ),
    );
  }
}
