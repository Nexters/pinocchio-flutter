import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_sancle/data/model/camera_result_response.dart';
import 'package:flutter_sancle/data/network/dio_client.dart';

/// 이미지 파일 관련 API 관리 */
class FileProvider {
  static final FileProvider _fileProvider = new FileProvider._internal();

  static FileProvider get instance => _fileProvider;

  FileProvider._internal();

  Future<CameraResultResponse> postUserImage(
      String category, File imageFile, String userId) async {
    try {
      final _dio = await DioClient.instance.getAuthApiClient();
      FormData formData = FormData.fromMap({
        "uploadFile": await MultipartFile.fromFile(imageFile.path,
            filename: imageFile.path.split('/').last),
        "category": category
      });
      final response = await _dio.post(FILE_BASE_URL + '/user/$userId/image',
          data: formData);
      return CameraResultResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw e;
    }
  }
}
