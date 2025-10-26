import 'dart:developer';

import 'package:charm/data/repository/resource_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/model/background_model.dart';
import '../data/model/item_model.dart';
import '../data/model/pattern_model.dart';

class ResourceState {
  bool loaded;
  Map<int, PatternModel> patterns;
  Map<int, BackgroundModel> backgrounds;
  Map<int, ItemModel> items;

  ResourceState({
    this.loaded = false,
    this.patterns = const {},
    this.backgrounds = const {},
    this.items = const {},
  });

  copyWith({
    bool? loaded,
    Map<int, PatternModel>? patterns,
    Map<int, BackgroundModel>? backgrounds,
    Map<int, ItemModel>? items,
  }) {
    return ResourceState(
      loaded: loaded ?? this.loaded,
      patterns: patterns ?? this.patterns,
      backgrounds: backgrounds ?? this.backgrounds,
      items: items ?? this.items,
    );
  }
}

class ResourceBloc extends Cubit<ResourceState> {
  ResourceBloc() : super(ResourceState());

  final ResourceRepository resourceRepository = GetIt.I<ResourceRepository>();

  Future<void> loadData() async {
    if (!state.loaded) {
      await loadBackgrounds();
      await loadItems();

      emit(state.copyWith(loaded: true));
    }
  }

  Future<void> loadBackgrounds() async {
    try {
      final List<BackgroundModel> resultBackgrounds = await resourceRepository.getBackgrounds();

      emit(
        state.copyWith(
          backgrounds: Map.fromIterable(resultBackgrounds, key: (element) => element.id),
        ),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> loadItems() async {
    try {
      final List<ItemModel> resultItems = await resourceRepository.getItems();

      emit(state.copyWith(items: Map.fromIterable(resultItems, key: (element) => element.id)));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  ItemModel? getItemById(int id) {
    return state.items[id];
  }
}
