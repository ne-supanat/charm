import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/model/user_model.dart';
import '../../data/repository/auth_repository.dart';

class SigninState {
  String email;
  String password;

  SigninState({this.email = "", this.password = ""});

  copyWith({String? email, String? password}) {
    return SigninState(email: email ?? this.email, password: password ?? this.password);
  }
}

class SigninBloc extends Cubit<SigninState> {
  SigninBloc(super.initialState);

  final authRepository = GetIt.I<AuthRepository>();

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  Future<UserModel> signin() async {
    try {
      final result = await authRepository.signin(state.email, state.password);
      return result;
    } on HttpException catch (e) {
      log(e.message);
      rethrow;
    }
  }
}
