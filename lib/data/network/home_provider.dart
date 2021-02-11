import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_sancle/data/model/home_response.dart';
import 'package:flutter_sancle/data/network/dio_client.dart';

class HomeProvider {
  static final HomeProvider _homeProvider = new HomeProvider._internal();

  static HomeProvider get instance => _homeProvider;

  HomeProvider._internal();

  Future<HomeResponse> getHomeInfo() async {
    try {
      final _dio = await DioClient.instance.getAuthApiClient();
      Response response = await _dio.get(BASE_URL + '/view/main');
      return HomeResponse.fromJson(response.data);
    } on DioError catch (e){
      if(e.response?.statusCode == 401){
        print('401');
      }
      throw e;
    }
  }
}