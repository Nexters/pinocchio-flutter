/// authToken : "2fc85855-0480-472e-9d68-8f3cb8affd78"
/// refreshToken : "4d214b30-469b-448c-8c92-4d37290e3333"
/// expireDateTime : "2021-01-30T10:26:28.890Z"

class TokenResponse {
  String _authToken;
  String _expireDateTime;
  String _refreshToken;

  String get authToken => _authToken;

  String get expireDateTime => _expireDateTime;

  String get refreshToken => _refreshToken;

  TokenResponse(
      {String authToken, String expireDateTime, String refreshToken}) {
    _authToken = authToken;
    _expireDateTime = expireDateTime;
    _refreshToken = refreshToken;
  }

  TokenResponse.fromJson(dynamic json) {
    _authToken = json["authToken"];
    _expireDateTime = json["expireDateTime"];
    _refreshToken = json["refreshToken"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["authToken"] = _authToken;
    map["expireDateTime"] = _expireDateTime;
    map["refreshToken"] = _refreshToken;
    return map;
  }
}
