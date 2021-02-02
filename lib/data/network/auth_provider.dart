import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_sancle/data/model/token_response.dart';
import 'package:flutter_sancle/data/network/dio_client.dart';

/// 인증 관련 (로그인, 회원가입, 토큰 갱신 등) API 관리 */
class AuthProvider {
  static final AuthProvider _authProvider = AuthProvider._internal();

  static AuthProvider get instance => _authProvider;

  AuthProvider._internal();

  /// 회원가입 요청 */
  Future<int> postAuthRegister(
      String loginType, String nickName, String socialId) async {
    try {
      var params = {
        "loginType": loginType,
        "nickName": nickName,
        "socialId": socialId
      };
      final dio = await DioClient.instance.getDefaultClient();
      Response response =
          await dio.post(BASE_URL + "/auth/register", data: jsonEncode(params));
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response?.statusCode == 409) {
        return e.response.statusCode;
      } else {
        throw e;
      }
    }
  }

  /// 로그인 요청 */
  Future<TokenResponse> postAuthLogin(String socialId) async {
    try {
      final _dio = await DioClient.instance.getDefaultClient();
      Response response = await _dio.post(BASE_URL + "/auth/login",
          data: jsonEncode({"socialId": socialId}));
      return TokenResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw e;
    }
  }
}
