import 'dart:developer';

import 'package:charm/data/repository/preset_repository.dart';
import 'package:charm/global/sharedpref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/model/charm_model.dart';

class CatalogState {
  final Map<int, CharmModel> catalog;
  final int selectedPreset;

  CatalogState({this.catalog = const {}, this.selectedPreset = -1});

  copyWith({Map<int, CharmModel>? catalog, int? selectedPreset}) {
    return CatalogState(
      catalog: catalog ?? this.catalog,
      selectedPreset: selectedPreset ?? this.selectedPreset,
    );
  }
}

class CatalogBloc extends Cubit<CatalogState> {
  CatalogBloc() : super(CatalogState());

  final PresetRepository presetRepository = GetIt.I<PresetRepository>();

  Future<void> loadCatalog() async {
    try {
      final List<CharmModel> result = await presetRepository.getPresets();
      emit(
        state.copyWith(
          catalog: Map<int, CharmModel>.fromIterable(result, key: (element) => element.id),
        ),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  void select(int presetId) {
    emit(state.copyWith(selectedPreset: presetId));
  }

  Future<void> addNewCharm() async {
    try {
      await presetRepository.createNewPreset();
      await loadCatalog();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> deleteSelectedCharm() async {
    try {
      await presetRepository.deletePreset(state.selectedPreset);
      await loadCatalog();
      emit(state.copyWith(selectedPreset: -1));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  void logout() {
    GetIt.I<Sharedpref>().removeAuthToken();
  }
}
