import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/repository/auth_repository.dart';
import 'package:flutter_sancle/presentation/login/login_screen.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AppStarted());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LogoutRequested) {
      await UserApi.instance.logout();
      await AccessTokenStore.instance.clear();
      await _authRepository.deleteUserToken();
      Navigator.pushAndRemoveUntil(
          event.context, LoginScreen.route(), (route) => false);
    }
  }
}
