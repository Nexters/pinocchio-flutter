import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/login/bloc/login_event.dart';
import 'package:flutter_sancle/presentation/login/bloc/login_state.dart';
import 'package:kakao_flutter_sdk/all.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool _isKakaoTalkInstalled = false;

  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is KakaoTalkInstalled) {
      _isKakaoTalkInstalled = await isKakaoTalkInstalled();
    } else if (event is KakaoTalkLoginRequested) {
      try {
        _isKakaoTalkInstalled
            ? await _loginWithTalk()
            : await _loginWithKakao();
        final user = await UserApi.instance.me();
        final userId = user.id;
        final userNickname = user.kakaoAccount.profile.nickname;
        final userImageUrl =
            user.kakaoAccount.profile.profileImageUrl.toString();
        /**
         * TODO -1 카카오에서 가져온 사용자 정보 서버로 보내는 작업
         * TODO -2 서버에서 받아온 토큰 정보 SharedPreferences 를 이용해 저장하기
         * */
        yield UserLoginSuccess();
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
}
