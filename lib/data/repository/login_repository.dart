import 'package:dio/dio.dart';
import 'package:flutter_sancle/data/model/token_response.dart';
import 'package:flutter_sancle/data/network/api_provider.dart';
import 'package:flutter_sancle/data/prefs/user_token_manager.dart';

class LoginRepository {
  Future<int> postAuthRegister(
      String loginType, String nickName, String socialId) {
    return ApiProvider.instance.postAuthRegister(loginType, nickName, socialId);
  }

  Future<bool> postAuthLogin(String loginType, String socialId) async {
    try {
      TokenResponse tokenResponse =
          await ApiProvider.instance.postAuthLogin(loginType, socialId);
      return await UserTokenManger.instance.setUserToken(tokenResponse);
    } on DioError catch (e) {
      throw e;
    }
  }
}
