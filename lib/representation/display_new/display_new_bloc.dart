import 'package:charm/representation/resource_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/tags_constant.dart';

class DisplayNewState {
  final int selectedItemId;
  final int selectedBackgroundId;
  final int selectedMusicId;

  final TagCategory selectedTagCategory;
  final TagPower selectedTagPower;
  final bool displayedUI;

  DisplayNewState({
    required this.selectedItemId,
    required this.selectedBackgroundId,
    required this.selectedMusicId,
    required this.selectedTagCategory,
    required this.selectedTagPower,
    required this.displayedUI,
  });

  factory DisplayNewState.init(BuildContext context) {
    return DisplayNewState(
      selectedItemId: context.read<ResourceBloc>().state.items.values.first.id,
      selectedBackgroundId: context.read<ResourceBloc>().state.backgrounds.values.first.id,
      selectedMusicId: context.read<ResourceBloc>().state.musics.values.first.id,
      selectedTagCategory: TagCategory.all,
      selectedTagPower: TagPower.all,
      displayedUI: true,
    );
  }

  copyWith({
    int? selectedItemId,
    int? selectedBackgroundId,
    int? selectedMusicId,
    TagCategory? selectedTagCategory,
    TagPower? selectedTagPower,
    bool? displayedUI,
  }) {
    return DisplayNewState(
      selectedItemId: selectedItemId ?? this.selectedItemId,
      selectedBackgroundId: selectedBackgroundId ?? this.selectedBackgroundId,
      selectedMusicId: selectedMusicId ?? this.selectedMusicId,
      selectedTagCategory: selectedTagCategory ?? this.selectedTagCategory,
      selectedTagPower: selectedTagPower ?? this.selectedTagPower,
      displayedUI: displayedUI ?? this.displayedUI,
    );
  }
}

class DisplayNewBloc extends Cubit<DisplayNewState> {
  DisplayNewBloc(super.initialState);

  updateSelectedItem(int itemId) {
    emit(state.copyWith(selectedItemId: itemId));
  }

  updateSelectedMusic(int musicId) {
    emit(state.copyWith(selectedMusicId: musicId));
  }

  updateSelectedBackground(int backgroundId) {
    emit(state.copyWith(selectedBackgroundId: backgroundId));
  }

  updateSelectedTagCategory(TagCategory newTagCategory) {
    emit(state.copyWith(selectedTagCategory: newTagCategory));
  }

  updateSelectedTagPower(TagPower newTagPower) {
    emit(state.copyWith(selectedTagPower: newTagPower));
  }

  updateDisplayUI(bool value) {
    emit(state.copyWith(displayedUI: value));
  }
}
