// ignore_for_file: empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rev_rider/cubit/login_state.dart';
import 'package:rev_rider/main.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth;
  LoginCubit(this._auth) : super(LoginInitial());

  void login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccessful());
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}
