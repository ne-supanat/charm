import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/model/user_model.dart';
import '../data/repository/auth_repository.dart';

class SignupState {
  String email;
  String password;
  String confirmPassword;

  SignupState({this.email = "", this.password = "", this.confirmPassword = ""});

  copyWith({String? email, String? password, String? confirmPassword}) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}

class SignupBloc extends Cubit<SignupState> {
  SignupBloc(super.initialState);

  final authRepository = GetIt.I<AuthRepository>();

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateConfirmPassword(String password) {
    emit(state.copyWith(confirmPassword: password));
  }

  Future<UserModel> signup() async {
    try {
      final result = await authRepository.signup(state.email, state.password);
      return result;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
