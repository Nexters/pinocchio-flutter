import 'package:flutter_sancle/data/model/home_response.dart';
import 'package:flutter_sancle/data/network/home_provider.dart';

class HomeRepository {
  Future<HomeResponse> getHomeInfo() async {
    return HomeProvider.instance.getHomeInfo();
  }
}