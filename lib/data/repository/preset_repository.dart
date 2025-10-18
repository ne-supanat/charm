import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../client.dart';
import '../model/omamori_model.dart';

class PresetRepository {
  final Client client = GetIt.I<Client>();

  Future<List<OmamoriModel>> getPresets() async {
    Response response = await client.dio.get("/preset");
    if (response.statusCode == 200) {
      return (response.data['data'] as List).map((e) => OmamoriModel.from(e)).toList();
    } else {
      throw HttpException(response.data['error']);
    }
  }

  Future<void> createNewPreset() async {
    Response response = await client.dio.post("/preset/create");
    if (response.statusCode != 201) {
      throw HttpException(response.data['error']);
    }
  }

  Future<void> updatePreset(OmamoriModel updatedOmamori) async {
    print(updatedOmamori.toJson());
    Response response = await client.dio.put(
      "/preset/${updatedOmamori.id}",
      data: updatedOmamori.toJson(),
    );
    if (response.statusCode != 200) {
      throw HttpException(response.data['error']);
    }
  }

  Future<void> deletePreset(int presetId) async {
    Response response = await client.dio.delete("/preset/$presetId");
    if (response.statusCode != 200) {
      throw HttpException(response.data['error']);
    }
  }
}
