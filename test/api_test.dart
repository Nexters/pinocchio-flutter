import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_sancle/data/model/token_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String _baseUrl;
  Dio _dio;

  setUp(() {
    _baseUrl = "http://ec2-3-139-60-119.us-east-2.compute.amazonaws.com:8082/";
    _dio = Dio();
  });

  test('accessToken 만료 시 refreshToken 사용해 토큰 갱신 테스트', () async {
    var params = {
      "accessToken": "15",
      "createdAt": "2021-01-20T13:34:54.343Z",
      "expiredAt": "2021-01-25T13:34:54.343Z",
      "refreshToken": "15",
      "userId": "15"
    };
    /**
     * 테스트 토큰값 생성
     * 주의 사항 : 테스트 할 때마다 accessToken, refreshToken, userId 새로운 값을 넣어줘야함 (숫자 + 1 씩 증가 시키기)
     * createdAt : 토큰 자체 생성 시점
     * expiredAt : access token 만료 시간 값
     */
    final response = await _dio.post(_baseUrl + "/test/userAuth", data: params);
    final tokenResponse = TokenResponse.fromJson(response.data);

    try {
      BaseOptions baseOptions = new BaseOptions(
          connectTimeout: 1000, receiveTimeout: 1000, sendTimeout: 1000);
      Dio dio = Dio(baseOptions)
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (RequestOptions options) async {
              // TODO 1 = 유저 토큰 가져오기 from prefs
              if (tokenResponse == null) {
                return options; // 토큰(accessToken) 없이 request 보낼 경우 401 Error 발생
              }
              options.headers["Authorization"] =
                  "Bearer " + tokenResponse.accessToken;
              return options; // 토큰(accessToken)이 만료 됐을 경우 401 Error 발생
            },
            onError: (DioError error) async {
              // TODO 2 = 유저 토큰 가져오기 from prefs
              final token = tokenResponse;
              _dio.interceptors.errorLock.lock();
              if (token == null) {
                _dio.interceptors.errorLock.unlock();
                return error;
              } else if (error.response?.statusCode == 401) {
                try {
                  _dio.interceptors.requestLock.lock();
                  RequestOptions options = error.response.request;
                  final response = await Dio().put(
                      _baseUrl + "/auth/accessToken",
                      data: jsonEncode({"refreshToken": token.refreshToken}));
                  final newTokenResponse =
                      TokenResponse.fromJson(response.data);
                  if (newTokenResponse == null) {
                    return error;
                  }
                  // TODO 3 = 유저 저장하기 to prefs
                  options.headers["Authorization"] =
                      "Bearer " + newTokenResponse.accessToken;
                  return _dio.request(options.path, options: options);
                } catch (e) {
                  return error;
                } finally {
                  _dio.interceptors.requestLock.unlock();
                  _dio.interceptors.errorLock.unlock();
                }
              }
              return error;
            },
          ),
        );

      Response response = await dio.get(_baseUrl + "/api/capture/event",
          queryParameters: {"status": "START"});
      expect(response.statusCode, 200);
      print(response);
    } on DioError catch (e) {
      print(e);
    }
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

  test('원하는 값이 올때 까지 반복적으로 api 호출 테스트', () async {
    print('테스트 시작');
    int index = 0;
    await Future.doWhile(() async {
      index++;
      await Future.delayed(Duration(seconds: 1)); // 네트워크 통신이 가정
      if (index == 10) {
        print('원하는 값이 도착했어요');
        return false; // doWhile 탈출
      } else {
        print('대기중');
        return true; // doWhile 반복
      }
    }).then((_) {
      print('doWhile 정상적인 종료');
    }).timeout(Duration(minutes: 2), onTimeout: () {
      throw TimeoutException('Timeout'); // 2분안에 doWhile 문을 탈출 못할 경우 타임아웃 발생
    }).catchError((e) {
      print(e);
    });
    print('테스트 종료');
  });
}
