import 'dart:io';

import 'package:charm/data/client.dart';
import 'package:charm/data/model/user_model.dart';
import 'package:charm/global/sharedpref.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class AuthRepository {
  final Client client = GetIt.I<Client>();

  Future<UserModel> signup(String email, String password) async {
    Response response = await client.dio.post(
      "/auth/signup",
      data: {"email": email, "password": password},
    );

    if (response.statusCode == 201) {
      await GetIt.I<Sharedpref>().saveAuthToken(response.data['token']);
      return UserModel.from(response.data['user']);
    } else {
      throw HttpException(response.data['error']);
    }
  }

  Future<UserModel> signin(String email, String password) async {
    Response response = await client.dio.post(
      "/auth/signin",
      data: {"email": email, "password": password},
    );

    if (response.statusCode == 200) {
      await GetIt.I<Sharedpref>().saveAuthToken(response.data['token']);
      return UserModel.from(response.data['user']);
    } else {
      throw HttpException(response.data['error']);
    }
  }
}
