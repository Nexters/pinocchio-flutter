import 'package:flutter_sancle/data/network/api_provider.dart';

class LoginRepository {
  Future<int> postAuthRegister(
      String loginType, String nickName, String socialId) {
    return ApiProvider.instance.postAuthRegister(loginType, nickName, socialId);
  }
}
