import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/omamori_model.dart';

class CatalogState {
  final Map<String, OmamoriModel> catalog;
  final String selectedPreset;

  CatalogState({this.catalog = const {}, this.selectedPreset = ""});

  copyWith({Map<String, OmamoriModel>? catalog, String? selectedPreset}) {
    return CatalogState(
      catalog: catalog ?? this.catalog,
      selectedPreset: selectedPreset ?? this.selectedPreset,
    );
  }
}

class CatalogBloc extends Cubit<CatalogState> {
  CatalogBloc(super.initialState);

  void loadCatalog() {
    // TODO: get items from db
    emit(
      state.copyWith(
        catalog: {
          "a": OmamoriModel(
            id: "a",
            title: "Star & Sun flower",
            description: "",
            shapeId: "0",
            backgroundId: "0",
            itemPrimaryId: "0",
            itemSecondaryId1: "0",
            itemSecondaryId2: "0",
          ),
          "b": OmamoriModel(
            id: "b",
            title: "Tulip & Rose",
            description: "",
            shapeId: "0",
            backgroundId: "0",
            itemPrimaryId: "0",
            itemSecondaryId1: "0",
            itemSecondaryId2: "0",
          ),
        },
      ),
    );
  }

  void select(String presetId) {
    emit(state.copyWith(selectedPreset: presetId));
  }

  void addNewOmamori() {
    final tempCatalog = Map<String, OmamoriModel>.from(state.catalog);
    final newOmamori = OmamoriModel.init();

    tempCatalog[newOmamori.id] = newOmamori;
    emit(state.copyWith(catalog: tempCatalog));
  }

  void deleteSelectedOmamori() {
    final tempCatalog = Map<String, OmamoriModel>.from(state.catalog);

    tempCatalog.remove(state.selectedPreset);
    emit(state.copyWith(catalog: tempCatalog, selectedPreset: ""));
  }
}
