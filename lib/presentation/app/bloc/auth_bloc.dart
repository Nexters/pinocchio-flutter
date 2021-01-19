import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/repository/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AppStarted());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LogoutRequested) {
      // TODO 카카오 로그인 정보 삭제 작업
      await _authRepository.deleteUserToken();
      // TODO 로그인 화면 전환 작업
    }
  }
}
