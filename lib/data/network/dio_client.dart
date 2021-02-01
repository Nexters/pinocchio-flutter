import 'package:dio/dio.dart';
import 'package:flutter_sancle/data/model/token_response.dart';
import 'package:flutter_sancle/data/prefs/user_token_manager.dart';

const BASE_URL =
    "http://ec2-3-139-60-119.us-east-2.compute.amazonaws.com:8082/";

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
          options.headers["Authorization"] = "Bearer " + token.authToken;
          return options;
        },
        onResponse: (Response response) {
          return response;
        },
        onError: (DioError error) async {
          if (error.response?.statusCode == 401) {
            RequestOptions options = error.response.request;

            _dio.lock();
            _dio.interceptors.requestLock.lock();
            _dio.interceptors.responseLock.lock();
            _dio.interceptors.errorLock.lock();

            TokenResponse token = await UserTokenManger.instance.getUserToken();
            if (token == null) {
              return error;
            }

            return Dio().put(BASE_URL + "/auth/authToken", queryParameters: {
              "refreshToken": token.refreshToken
            }).then((response) async {
              TokenResponse tokenResponse =
                  TokenResponse.fromJson(response.data);
              if (tokenResponse == null) {
                return error;
              }
              await UserTokenManger.instance.setUserToken(tokenResponse);
              options.headers["Authorization"] = "Bearer " + token.authToken;
            }).whenComplete(() {
              _dio.unlock();
              _dio.interceptors.requestLock.unlock();
              _dio.interceptors.responseLock.unlock();
              _dio.interceptors.errorLock.unlock();
            }).then((value) {
              return _dio.request(options.path, options: options);
            });
          }
          return error;
        },
      ),
    );
    return _dio;
  }
}
