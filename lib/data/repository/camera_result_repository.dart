import 'dart:io';

import 'package:flutter_sancle/data/model/camera_result_response.dart';
import 'package:flutter_sancle/data/network/file_provider.dart';

class CameraResultRepository {
  Future<CameraResultResponse> postUserImage(String category, String filePath) {
    return FileProvider.instance.postUserImage(category, File(filePath));
  }
}
