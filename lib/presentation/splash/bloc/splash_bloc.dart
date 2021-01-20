import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/repository/auth_repository.dart';
import 'package:flutter_sancle/presentation/splash/bloc/splash_event.dart';
import 'package:flutter_sancle/presentation/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository _authRepository;

  SplashBloc(this._authRepository) : super(SplashInitial());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is UserTokenChecked) {
      final tokenResponse = await _authRepository.getUserToken();
      await Future.delayed(Duration(seconds: 2));
      if (tokenResponse == null ||
          tokenResponse.expiredDate < DateTime.now().millisecondsSinceEpoch) {
        yield UserTokenCheckedFailure();
      } else {
        yield UserTokenCheckedSuccess();
      }
    }
  }
}
