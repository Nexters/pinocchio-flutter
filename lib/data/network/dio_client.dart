import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_sancle/data/model/token_response.dart';
import 'package:flutter_sancle/data/prefs/user_token_manager.dart';

const BASE_URL =
    "http://ec2-13-209-47-146.ap-northeast-2.compute.amazonaws.com:8082/";

const FILE_BASE_URL =
    "http://ec2-3-139-60-119.us-east-2.compute.amazonaws.com:8081/";

class DioClient {
  Dio _dio;

  static final DioClient _dioClient = new DioClient._internal();

  static DioClient get instance => _dioClient;

  DioClient._internal() {
    _dio = Dio();
    _dio.options
      ..connectTimeout = 60 * 1000
      ..receiveTimeout = 30 * 1000
      ..sendTimeout = 30 * 1000;
  }

  /// 헤더에 토큰을 담지 않는 API 사용 시 해당 메소드 사용 */
  Future<Dio> getDefaultClient() async {
    _dio.interceptors.clear();
    return _dio;
  }

  /// 헤더에 토큰을 담는 API 사용 시 해당 메소드 사용 */
  Future<Dio> getAuthApiClient() async {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          TokenResponse token = await UserTokenManger.instance.getUserToken();
          if (token == null) {
            return options;
          }
          options.headers["Authorization"] = "Bearer " + token.accessToken;
          return options;
        },
        onResponse: (Response response) {
          return response;
        },
        onError: (DioError error) async {
          final token = await UserTokenManger.instance.getUserToken();
          _dio.interceptors.errorLock.lock();
          if (token == null) {
            _dio.interceptors.errorLock.unlock();
            return error;
          } else if (error.response?.statusCode == 401) {
            try {
              _dio.interceptors.requestLock.lock();
              RequestOptions options = error.response.request;
              final response = await Dio().put(BASE_URL + "/auth/accessToken",
                  data: jsonEncode({"refreshToken": token.refreshToken}));
              final newTokenResponse = TokenResponse.fromJson(response.data);
              if (newTokenResponse == null) {
                return error;
              }
              await UserTokenManger.instance.setUserToken(newTokenResponse);
              options.headers["Authorization"] =
                  "Bearer " + newTokenResponse.accessToken;
              return _dio.request(options.path, options: options);
            } catch (e) {
              return error;
            } finally {
              _dio.interceptors.requestLock.unlock();
              _dio.interceptors.errorLock.unlock();
            }
          }
          return error;
        },
      ),
    );
    return _dio;
  }
}
