import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../client.dart';
import '../model/background_model.dart';
import '../model/item_model.dart';
import '../model/pattern_model.dart';

class ResourceRepository {
  final Client client = GetIt.I<Client>();

  Future<List<BackgroundModel>> getBackgrounds() async {
    Response response = await client.dio.get("/resource/patterns");
    if (response.statusCode == 200) {
      return (response.data['data'] as List).map((e) => BackgroundModel.from(e)).toList();
    } else {
      throw HttpException(response.data['error']);
    }
  }

  Future<List<PatternModel>> getPatterns() async {
    Response response = await client.dio.get("/resource/patterns");
    if (response.statusCode == 200) {
      return (response.data['data'] as List).map((e) => PatternModel.from(e)).toList();
    } else {
      throw HttpException(response.data['error']);
    }
  }

  Future<List<ItemModel>> getItems() async {
    Response response = await client.dio.get("/resource/items");
    if (response.statusCode == 200) {
      return (response.data['data'] as List).map((e) => ItemModel.from(e)).toList();
    } else {
      throw HttpException(response.data['error']);
    }
  }
}
