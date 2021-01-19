import 'dart:convert';

import 'package:flutter_sancle/data/model/token_response.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTokenManger {
  static final UserTokenManger _userTokenManger =
      new UserTokenManger._internal();

  static UserTokenManger get instance => _userTokenManger;

  UserTokenManger._internal();

  Future<void> setUserToken(TokenResponse tokenResponse) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_USER_TOKEN, jsonEncode(tokenResponse));
  }

  Future<TokenResponse> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> tokenMap;
    final String data = prefs.getString(PREF_USER_TOKEN);
    if (data != null) {
      tokenMap = jsonDecode(data) as Map<String, dynamic>;
    }
    if (tokenMap != null) {
      return TokenResponse.fromJson(tokenMap);
    }
    return null;
  }

  Future<void> deleteUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PREF_USER_TOKEN);
  }
}
