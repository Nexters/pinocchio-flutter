import 'package:flutter_sancle/data/model/photo_analysis_inspection_response.dart';
import 'package:flutter_sancle/data/network/api_provider.dart';
import 'package:flutter_sancle/data/prefs/user_token_manager.dart';

class PhotoAnalysisRepository {
  Future<PhotoAnalysisInspectionResponse> getCaptureEvent(
      String eventId) async {
    final tokenResponse = await UserTokenManger.instance.getUserToken();
    return ApiProvider.instance.getCaptureEvent(eventId, tokenResponse.userId);
  }
}
