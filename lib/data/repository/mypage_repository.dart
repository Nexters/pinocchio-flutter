import 'package:flutter_sancle/data/model/mypage_response.dart';
import 'package:flutter_sancle/data/network/mypage_provider.dart';

class MyPageRepository{
  Future<MyPageResponse> getMyClothInfo() async {
    return await MyPageProvider.instance.getMyClothInfo();
  }
}