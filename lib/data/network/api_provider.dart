import 'package:dio/dio.dart';
import 'package:flutter_sancle/data/model/capture_event_response.dart';
import 'package:flutter_sancle/data/model/capture_event_update_request.dart';
import 'package:flutter_sancle/data/model/result_view_response.dart';
import 'package:flutter_sancle/data/network/dio_client.dart';

/// 산클 메인 서비스에서 사용하는 API 관리 */
class ApiProvider {
  static final ApiProvider _apiProvider = new ApiProvider._internal();

  static ApiProvider get instance => _apiProvider;

  ApiProvider._internal();

  Future<CaptureEventResponse> getCaptureEvent(
      String eventId, String userId) async {
    try {
      final dio = await DioClient.instance.getAuthApiClient();
      Response response =
          await dio.get(BASE_URL + "/api/user/$userId/capture/event/$eventId");
      return CaptureEventResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<int> putCaptureEvent(
      String eventId, String userId, CaptureEventUpdateRequest request) async {
    try {
      final dio = await DioClient.instance.getAuthApiClient();
      Response response = await dio.put(
          BASE_URL + "/api/user/$userId/capture/event/$eventId",
          data: request);
      return response.statusCode;
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<ResultViewResponse> getViewResult(String eventId) async {
    try {
      final dio = await DioClient.instance.getAuthApiClient();
      Response response = await dio.get(BASE_URL + "/view/result/$eventId");
      return ResultViewResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw e;
    }
  }
}
