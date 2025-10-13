import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/background_model.dart';
import '../models/item_model.dart';
import '../models/shape_model.dart';

class ResourceState {
  bool loaded;
  Map<String, ShapeModel> shapes;
  Map<String, BackgroundModel> backgrounds;
  Map<String, ItemModel> items;

  ResourceState({
    this.loaded = false,
    this.shapes = const {},
    this.backgrounds = const {},
    this.items = const {},
  });

  copyWith({
    bool? loaded,
    Map<String, ShapeModel>? shapes,
    Map<String, BackgroundModel>? backgrounds,
    Map<String, ItemModel>? items,
  }) {
    return ResourceState(
      loaded: loaded ?? this.loaded,
      shapes: shapes ?? this.shapes,
      backgrounds: backgrounds ?? this.backgrounds,
      items: items ?? this.items,
    );
  }
}

class ResourceBloc extends Cubit<ResourceState> {
  ResourceBloc() : super(ResourceState());

  Future<void> loadData() async {
    if (!state.loaded) {
      await loadShapes();
      await loadBackgrounds();
      await loadItems();

      emit(state.copyWith(loaded: true));
    }
  }

  Future<void> loadShapes() async {
    await Future.delayed(Duration(milliseconds: 300));
    emit(
      state.copyWith(
        shapes: {
          "0": ShapeModel(id: "0", imagePath: ""),
          "1": ShapeModel(id: "1", imagePath: ""),
          "2": ShapeModel(id: "2", imagePath: ""),
        },
      ),
    );
  }

  Future<void> loadBackgrounds() async {
    await Future.delayed(Duration(milliseconds: 300));
    emit(
      state.copyWith(
        backgrounds: {
          "0": BackgroundModel(id: "0", imagePath: ""),
          "1": BackgroundModel(id: "1", imagePath: ""),
          "2": BackgroundModel(id: "2", imagePath: ""),
          "3": BackgroundModel(id: "3", imagePath: ""),
        },
      ),
    );
  }

  Future<void> loadItems() async {
    await Future.delayed(Duration(milliseconds: 300));
    emit(
      state.copyWith(
        items: {
          "0": ItemModel(id: "0", imagePath: "", name: "Tulip", description: "", tags: []),
          "1": ItemModel(id: "1", imagePath: "", name: "Rose", description: "", tags: []),
          "2": ItemModel(id: "2", imagePath: "", name: "Sun Flower", description: "", tags: []),
          "4": ItemModel(id: "4", imagePath: "", name: "Star", description: "", tags: []),
          "5": ItemModel(id: "5", imagePath: "", name: "Moon", description: "", tags: []),
        },
      ),
    );
  }

  ItemModel? getItemById(String id) {
    return state.items[id];
  }
}
