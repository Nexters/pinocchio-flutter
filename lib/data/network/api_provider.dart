import 'package:dio/dio.dart';
import 'package:flutter_sancle/data/network/dio_client.dart';

/// 산클 메인 서비스에서 사용하는 API 관리 */
class ApiProvider {
  static final ApiProvider _apiProvider = new ApiProvider._internal();

  static ApiProvider get instance => _apiProvider;

  ApiProvider._internal();

  Future<String> getCaptureEvent(String eventId, String userId) async {
    try {
      final dio = await DioClient.instance.getAuthApiClient();
      Response response =
          await dio.get(BASE_URL + "/api/user/$userId/capture/event/$eventId");
      return response.data["status"];
    } on DioError catch (e) {
      throw e;
    }
  }
}
