class TokenResponse {
  int _userIdx;
  String _accessToken;
  String _refreshToken;
  int _expiredDate;

  int get userIdx => _userIdx;

  String get accessToken => _accessToken;

  String get refreshToken => _refreshToken;

  int get expiredDate => _expiredDate;

  TokenResponse(
      {int userIdx, String accessToken, String refreshToken, int expiredDate}) {
    _userIdx = userIdx;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _expiredDate = expiredDate;
  }

  TokenResponse.fromJson(dynamic json) {
    _userIdx = json["userIdx"];
    _accessToken = json["accessToken"];
    _refreshToken = json["refreshToken"];
    _expiredDate = json["expiredDate"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["userIdx"] = _userIdx;
    map["accessToken"] = _accessToken;
    map["refreshToken"] = _refreshToken;
    map["expiredDate"] = _expiredDate;
    return map;
  }
}
