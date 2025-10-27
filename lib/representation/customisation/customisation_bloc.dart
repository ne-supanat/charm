import 'dart:developer';

import '../../data/repository/preset_repository.dart';
import '../util.dart';
import '../../data/model/customisation_constant.dart';
import '../../data/model/charm_model.dart';
import '../../data/model/tags_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CustomisationState {
  final CharmModel charmModel;

  final CustomisationConstant focusedEditing;
  final ComponentConstant focusedCustomisationComponent;
  final TagCategory selectedTag;
  int? selectedBackgroundId;
  int? selectedPatternId;
  int? selectedItem1Id;
  int? selectedItem2Id;
  int? selectedItem3Id;

  CustomisationState({
    required this.charmModel,
    this.focusedEditing = CustomisationConstant.description,
    this.focusedCustomisationComponent = ComponentConstant.background,
    this.selectedTag = TagCategory.all,
    this.selectedBackgroundId = -1,
    this.selectedPatternId = -1,
    this.selectedItem1Id = -1,
    this.selectedItem2Id = -1,
    this.selectedItem3Id = -1,
  });

  copyWith({
    CharmModel? charmModel,
    CustomisationConstant? focusedEditing,
    ComponentConstant? focusedCustomisationComponent,
    TagCategory? selectedTag,
    int? selectedBackgroundId,
    int? selectedPatternId,
    int? selectedItem1Id,
    int? selectedItem2Id,
    int? selectedItem3Id,
  }) {
    return CustomisationState(
      charmModel: charmModel ?? this.charmModel,
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
        selectedBackgroundId: state.charmModel.backgroundId,
        selectedPatternId: state.charmModel.patternId,
        selectedItem1Id: state.charmModel.item1Id,
        selectedItem2Id: state.charmModel.item2Id,
        selectedItem3Id: state.charmModel.item3Id,
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
    emit(state.copyWith(charmModel: state.charmModel.copyWith(title: newTitle)));
  }

  void updateDescription(String newDescription) {
    emit(state.copyWith(charmModel: state.charmModel.copyWith(description: newDescription)));
  }

  void updatePattern(newShape) {
    emit(state.copyWith(charmModel: state.charmModel.copyWith(patternId: newShape)));
  }

  void updateBackground(newBackground) {
    emit(state.copyWith(charmModel: state.charmModel.copyWith(backgroundId: newBackground)));
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
    emit(state.copyWith(charmModel: state.charmModel.copyWith(item1Id: itemId)));
  }

  void updateItem2(int itemId) {
    emit(state.copyWith(charmModel: state.charmModel.copyWith(item2Id: itemId)));
  }

  void updateItem3(int itemId) {
    emit(state.copyWith(charmModel: state.charmModel.copyWith(item3Id: itemId)));
  }

  void parseFromCode(String code) {
    final newCharm = convertCodeToCharm(code);
    emit(
      state.copyWith(
        charmModel: state.charmModel.updateComponents(charmModel: newCharm),
        selectedBackgroundId: newCharm.backgroundId,
        selectedPatternId: newCharm.patternId,
        selectedItem1Id: newCharm.item1Id,
        selectedItem2Id: newCharm.item2Id,
        selectedItem3Id: newCharm.item3Id,
      ),
    );
  }

  Future<void> save() async {
    try {
      await presetRepository.updatePreset(state.charmModel);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
