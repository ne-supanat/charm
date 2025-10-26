import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../client.dart';
import '../model/background_model.dart';
import '../model/item_model.dart';

class ResourceRepository {
  final Client client = GetIt.I<Client>();

  Future<List<BackgroundModel>> getBackgrounds() async {
    // // Data from assets
    String data = await rootBundle.loadString('assets/jsons/backgrounds.json');
    final json = jsonDecode(data);
    return (json as List).map((e) => BackgroundModel.from(e)).toList();

    // // Data from network
    // Response response = await client.dio.get("/resource/patterns");
    // if (response.statusCode == 200) {
    //   return (response.data['data'] as List).map((e) => BackgroundModel.from(e)).toList();
    // } else {
    //   throw HttpException(response.data['error']);
    // }
  }

  Future<List<ItemModel>> getItems() async {
    // // Data from assets
    String data = await rootBundle.loadString('assets/jsons/items.json');
    final json = jsonDecode(data);
    return (json as List).map((e) => ItemModel.from(e)).toList();

    // // Data from network
    // Response response = await client.dio.get("/resource/items");
    // if (response.statusCode == 200) {
    //   return (response.data['data'] as List).map((e) => ItemModel.from(e)).toList();
    // } else {
    //   throw HttpException(response.data['error']);
    // }
  }
}
