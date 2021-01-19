import 'package:flutter_sancle/data/model/token_response.dart';
import 'package:flutter_sancle/data/prefs/user_token_manager.dart';

class AuthRepository {
  Future<void> deleteUserToken() => UserTokenManger.instance.deleteUserToken();

  Future<TokenResponse> getUserToken() =>
      UserTokenManger.instance.getUserToken();

  Future<void> setUserToken(TokenResponse tokenResponse) =>
      UserTokenManger.instance.setUserToken(tokenResponse);
}
