import 'package:dio/dio.dart';
import 'package:flutter_sancle/data/model/mypage_response.dart';
import 'package:flutter_sancle/data/network/dio_client.dart';

class MyPageProvider {
  static final MyPageProvider _myPageProvider = new MyPageProvider._internal();

  static MyPageProvider get instance => _myPageProvider;

  MyPageProvider._internal();

  Future<MyPageResponse> getMyClothInfo() async {
    try{
      final _dio = await DioClient.instance.getAuthApiClient();
      Response response = await _dio.get(BASE_URL + '/view/myPage');
      return MyPageResponse.fromJson(response.data);
    } on DioError catch (e){
      throw e;
    }
  }
}