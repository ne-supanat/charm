import 'package:charm/features/util.dart';
import 'package:charm/models/customisation_constant.dart';
import 'package:charm/models/omamori_model.dart';
import 'package:charm/models/tags_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomisationState {
  final OmamoriModel? omamoriModel;

  final CustomisationConstant focusedEditing;
  final ComponentConstant focusedCustomisationComponent;
  final Tag selectedTag;

  CustomisationState({
    this.omamoriModel,
    this.focusedEditing = CustomisationConstant.description,
    this.focusedCustomisationComponent = ComponentConstant.background,
    this.selectedTag = Tag.all,
  });

  copyWith({
    OmamoriModel? omamoriModel,
    CustomisationConstant? focusedEditing,
    ComponentConstant? focusedCustomisationComponent,
    Tag? selectedTag,
  }) {
    return CustomisationState(
      omamoriModel: omamoriModel ?? this.omamoriModel,
      focusedEditing: focusedEditing ?? this.focusedEditing,
      focusedCustomisationComponent:
          focusedCustomisationComponent ?? this.focusedCustomisationComponent,
      selectedTag: selectedTag ?? this.selectedTag,
    );
  }
}

class CustomisationBloc extends Cubit<CustomisationState> {
  CustomisationBloc(super.initialState);

  void updateFocusedEditing(CustomisationConstant selectedEditing) {
    emit(state.copyWith(focusedEditing: selectedEditing));
  }

  void updateFocusedComponent(ComponentConstant selectedComponent) {
    emit(state.copyWith(focusedCustomisationComponent: selectedComponent));
  }

  void updateShape(newShape) {
    emit(state.copyWith(omamoriModel: state.omamoriModel?.copyWith(shapeId: newShape)));
  }

  void updateBackground(newBackground) {
    emit(state.copyWith(omamoriModel: state.omamoriModel?.copyWith(backgroundId: newBackground)));
  }

  void updateTag(newTag) {
    emit(state.copyWith(selectedTag: newTag));
  }

  void updateItemPrimary(newItemPrimary) {
    emit(state.copyWith(omamoriModel: state.omamoriModel?.copyWith(itemPrimaryId: newItemPrimary)));
  }

  void updateItemSecondary1(newItemSecondary) {
    emit(
      state.copyWith(
        omamoriModel: state.omamoriModel?.copyWith(itemSecondaryId1: newItemSecondary),
      ),
    );
  }

  void updateItemSecondary2(newItemSecondary) {
    emit(
      state.copyWith(
        omamoriModel: state.omamoriModel?.copyWith(itemSecondaryId2: newItemSecondary),
      ),
    );
  }

  void parseFromCode(String code) {
    emit(state.copyWith(omamoriModel: convertCodeToOmamori(code)));
  }
}
