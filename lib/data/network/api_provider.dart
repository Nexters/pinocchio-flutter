import 'package:dio/dio.dart';
import 'package:flutter_sancle/data/model/token_response.dart';

class ApiProvider {
  Dio _dio;

  final _baseUrl =
      "http://ec2-3-139-60-119.us-east-2.compute.amazonaws.com:8082/";

  static final ApiProvider _apiProvider = new ApiProvider._internal();

  static ApiProvider get instance => _apiProvider;

  ApiProvider._internal() {
    _dio = Dio();
  }

  /// Sample Code */
  Future<dynamic> getSampleData() async {
    try {
      Response response =
          await _dio.get(_baseUrl, queryParameters: {"results": 10, "page": 1});
      return TokenResponse.fromJson(response.data);
    } on DioError catch (e) {
      // 401 (unAuthorized) 체크를 위해 반드시 에러를 던져 주기.
      throw e;
    }
  }

  Future<int> postAuthRegister(
      String loginType, String nickName, String socialId) async {
    try {
      Response response = await _dio.post(_baseUrl + "/auth/register",
          queryParameters: {
            "loginType": loginType,
            "nickName": nickName,
            "socialId": socialId
          });
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response.statusCode == 409) {
        return e.response.statusCode;
      } else {
        throw e;
      }
    }
  }
}
