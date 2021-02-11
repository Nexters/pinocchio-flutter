import 'dart:io';

import 'package:flutter_sancle/data/model/camera_result_response.dart';
import 'package:flutter_sancle/data/network/file_provider.dart';
import 'package:flutter_sancle/data/prefs/user_token_manager.dart';

class CameraResultRepository {
  Future<CameraResultResponse> postUserImage(
      String category, String filePath) async {
    final tokenResponse = await UserTokenManger.instance.getUserToken();
    return FileProvider.instance
        .postUserImage(category, File(filePath), tokenResponse.userId);
  }
}
