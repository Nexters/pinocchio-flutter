import 'package:dio/dio.dart';

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
}
