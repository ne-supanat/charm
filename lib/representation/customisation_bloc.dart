import 'dart:developer';

import '../data/repository/preset_repository.dart';
import 'util.dart';
import '../data/model/customisation_constant.dart';
import '../data/model/omamori_model.dart';
import '../data/model/tags_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CustomisationState {
  final OmamoriModel omamoriModel;

  final CustomisationConstant focusedEditing;
  final ComponentConstant focusedCustomisationComponent;
  final Tag selectedTag;
  int? selectedBackgroundId;
  int? selectedPatternId;
  int? selectedItem1Id;
  int? selectedItem2Id;
  int? selectedItem3Id;

  CustomisationState({
    required this.omamoriModel,
    this.focusedEditing = CustomisationConstant.description,
    this.focusedCustomisationComponent = ComponentConstant.background,
    this.selectedTag = Tag.all,
    this.selectedBackgroundId = -1,
    this.selectedPatternId = -1,
    this.selectedItem1Id = -1,
    this.selectedItem2Id = -1,
    this.selectedItem3Id = -1,
  });

  copyWith({
    OmamoriModel? omamoriModel,
    CustomisationConstant? focusedEditing,
    ComponentConstant? focusedCustomisationComponent,
    Tag? selectedTag,
    int? selectedBackgroundId,
    int? selectedPatternId,
    int? selectedItem1Id,
    int? selectedItem2Id,
    int? selectedItem3Id,
  }) {
    return CustomisationState(
      omamoriModel: omamoriModel ?? this.omamoriModel,
      focusedEditing: focusedEditing ?? this.focusedEditing,
      focusedCustomisationComponent:
          focusedCustomisationComponent ?? this.focusedCustomisationComponent,
      selectedTag: selectedTag ?? this.selectedTag,
      selectedBackgroundId: selectedBackgroundId ?? this.selectedBackgroundId,
      selectedPatternId: selectedPatternId ?? this.selectedPatternId,
      selectedItem1Id: selectedItem1Id ?? this.selectedItem1Id,
      selectedItem2Id: selectedItem2Id ?? this.selectedItem2Id,
      selectedItem3Id: selectedItem3Id ?? this.selectedItem3Id,
    );
  }
}

class CustomisationBloc extends Cubit<CustomisationState> {
  CustomisationBloc(super.initialState);

  final PresetRepository presetRepository = GetIt.I<PresetRepository>();

  void init() {
    emit(
      state.copyWith(
        selectedBackgroundId: state.omamoriModel.backgroundId,
        selectedPatternId: state.omamoriModel.patternId,
        selectedItem1Id: state.omamoriModel.item1Id,
        selectedItem2Id: state.omamoriModel.item2Id,
        selectedItem3Id: state.omamoriModel.item3Id,
      ),
    );
  }

  void updateFocusedEditing(CustomisationConstant selectedEditing) {
    emit(state.copyWith(focusedEditing: selectedEditing));
  }

  void updateFocusedComponent(ComponentConstant selectedComponent) {
    emit(state.copyWith(focusedCustomisationComponent: selectedComponent));
  }

  void updateTitle(String newTitle) {
    emit(state.copyWith(omamoriModel: state.omamoriModel.copyWith(title: newTitle)));
  }

  void updateDescription(String newDescription) {
    emit(state.copyWith(omamoriModel: state.omamoriModel.copyWith(description: newDescription)));
  }

  void updatePattern(newShape) {
    emit(state.copyWith(omamoriModel: state.omamoriModel.copyWith(patternId: newShape)));
  }

  void updateBackground(newBackground) {
    emit(state.copyWith(omamoriModel: state.omamoriModel.copyWith(backgroundId: newBackground)));
  }

  void updateTag(newTag) {
    emit(state.copyWith(selectedTag: newTag));
  }

  void selectBackground(int itemId) {
    emit(state.copyWith(selectedBackgroundId: itemId));
  }

  void selectPattern(int itemId) {
    emit(state.copyWith(selectedPatternId: itemId));
  }

  void selectItem1(int itemId) {
    emit(state.copyWith(selectedItem1Id: itemId));
  }

  void selectItem2(int itemId) {
    emit(state.copyWith(selectedItem2Id: itemId));
  }

  void selectItem3(int itemId) {
    emit(state.copyWith(selectedItem3Id: itemId));
  }

  void updateItem1(int itemId) {
    emit(state.copyWith(omamoriModel: state.omamoriModel.copyWith(item1Id: itemId)));
  }

  void updateItem2(int itemId) {
    emit(state.copyWith(omamoriModel: state.omamoriModel.copyWith(item2Id: itemId)));
  }

  void updateItem3(int itemId) {
    emit(state.copyWith(omamoriModel: state.omamoriModel.copyWith(item3Id: itemId)));
  }

  void parseFromCode(String code) {
    final newOmamori = convertCodeToOmamori(code);
    emit(
      state.copyWith(
        omamoriModel: state.omamoriModel.updateComponents(omamoriModel: newOmamori),
        selectedBackgroundId: newOmamori.backgroundId,
        selectedPatternId: newOmamori.patternId,
        selectedItem1Id: newOmamori.item1Id,
        selectedItem2Id: newOmamori.item2Id,
        selectedItem3Id: newOmamori.item3Id,
      ),
    );
  }

  Future<void> save() async {
    try {
      await presetRepository.updatePreset(state.omamoriModel);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
