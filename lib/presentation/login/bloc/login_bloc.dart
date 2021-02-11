import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/home_response.dart';
import 'package:flutter_sancle/data/repository/home_repository.dart';
import 'package:flutter_sancle/data/repository/login_repository.dart';
import 'package:flutter_sancle/presentation/login/bloc/login_event.dart';
import 'package:flutter_sancle/presentation/login/bloc/login_state.dart';
import 'package:kakao_flutter_sdk/all.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool _isKakaoTalkInstalled = false;
  final LoginRepository _loginRepository;

  final HomeRepository _homeRepository;
  final StreamController _notiController = StreamController<HomeResponse>();
  Stream<HomeResponse> _notiStream;
  Stream<HomeResponse> get notiInfo => _notiStream;

  LoginBloc(this._loginRepository, this._homeRepository) : super(LoginInitial()){
    _notiStream = _notiController.stream;
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    HomeResponse _homeInfo = new HomeResponse();
    _homeInfo = await _homeRepository.getHomeInfo();
    _notiController.add(_homeInfo);

    if (event is KakaoTalkInstalled) {
      _isKakaoTalkInstalled = await isKakaoTalkInstalled();
    } else if (event is KakaoTalkLoginRequested) {
      try {
        _isKakaoTalkInstalled
            ? await _loginWithTalk()
            : await _loginWithKakao();
        final user = await UserApi.instance.me();
        final userId = user.id.toString();
        final userNickname = user.kakaoAccount.profile.nickname;
        yield* _requestLoginAfterSignUp("KAKAO", userNickname, userId);
      } catch (e) {
        yield UserLoginFailure();
      }
    }
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
    } catch (e) {
      throw e;
    }
  }

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      throw e;
    }
  }

  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      await _loginWithKakao();
    }
  }

  Stream<LoginState> _requestLoginAfterSignUp(
      String loginType, String nickName, String socialId) async* {
    try {
      yield LoginLoading();
      final code =
          await _loginRepository.postAuthRegister("KAKAO", nickName, socialId);

      if (code == 201 || code == 409) {
        bool isLoginSuccess = await _loginRepository.postAuthLogin(socialId);
        if (isLoginSuccess) {
          yield UserLoginSuccess();
        } else {
          yield UserLoginFailure();
        }
      } else {
        yield UserLoginFailure();
      }
    } catch (e) {
      yield UserLoginFailure();
    }
  }
}
