import 'package:flutter_sancle/data/model/result_view_response.dart';
import 'package:flutter_sancle/data/network/api_provider.dart';

class ResultViewRepository {
  Future<ResultViewResponse> getViewResult(String eventId) async {
    return ApiProvider.instance.getViewResult(eventId);
  }
}
