import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/home_response.dart';
import 'package:flutter_sancle/data/repository/auth_repository.dart';
import 'package:flutter_sancle/data/repository/home_repository.dart';
import 'package:flutter_sancle/data/repository/onboarding_repository.dart';
import 'package:flutter_sancle/presentation/splash/bloc/splash_event.dart';
import 'package:flutter_sancle/presentation/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository _authRepository;
  final OnboardingRepository _onboardingRepository;
  final HomeRepository _homeRepository;

  final StreamController _notiController = StreamController<HomeResponse>();
  Stream<HomeResponse> _notiStream;

  SplashBloc(this._authRepository, this._onboardingRepository, this._homeRepository)
      : super(SplashInitial()){
    _notiStream = _notiController.stream;
  }

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is UserTokenChecked) {
      final tokenResponse = await _authRepository.getUserToken();
      await Future.delayed(Duration(seconds: 2));
      if (tokenResponse == null ||
          DateTime.parse(tokenResponse.expireDateTime).millisecondsSinceEpoch <
              DateTime.now().millisecondsSinceEpoch) {
        bool isAlreadyShownGuide = await _onboardingRepository.getIsGuide();
        yield UserTokenCheckedFailure(isAlreadyShownGuide);
      } else {
        HomeResponse _homeInfo = new HomeResponse();
        _homeInfo = await _homeRepository.getHomeInfo();
        _notiController.add(_homeInfo);
        yield UserTokenCheckedSuccess();
      }
    }
  }

  Stream<HomeResponse> get notiInfo => _notiStream;
}
