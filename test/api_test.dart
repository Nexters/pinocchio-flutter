// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String _baseUrl;
  Dio _dio;

  setUp(() {
    _baseUrl = "http://ec2-3-139-60-119.us-east-2.compute.amazonaws.com:8082/";
    _dio = Dio();
  });

  test('회원가입 테스트', () async {
    try {
      String loginType = "KAKAO";
      String nickName = "테스트 계정1";
      String socialId = "123123";
      Response response = await _dio.post(_baseUrl + "/auth/register",
          queryParameters: {
            "loginType": loginType,
            "nickName": nickName,
            "socialId": socialId
          });
      expect(response.statusCode, 201);
      print('사용자 신규 가입 완료');
    } on DioError catch (e) {
      if (e.response.statusCode == 409) {
        print('이미 가입된 사용자');
      }
      print(e);
    }
  });

  test('로그인 테스트', () async {
    try {
      String socialId = "123123";
      Response response = await _dio.post(_baseUrl + "/auth/login",
          queryParameters: {"socialId": socialId});
      expect(response.statusCode, 200);
    } on DioError catch (e) {
      print(e);
    }
  });
}
