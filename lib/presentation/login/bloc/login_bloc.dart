import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/login/bloc/login_event.dart';
import 'package:flutter_sancle/presentation/login/bloc/login_state.dart';
import 'package:kakao_flutter_sdk/all.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) {}
}
