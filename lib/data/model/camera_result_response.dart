/// eventId : "f44b4c48-38b6-4240-b3b4-f495ed864ccb"
/// imageId : "b9e06089-24a4-4a72-884c-203c0ae8e5a9"

class CameraResultResponse {
  String _eventId;
  String _imageId;

  String get eventId => _eventId;
  String get imageId => _imageId;

  CameraResultResponse({String eventId, String imageId}) {
    _eventId = eventId;
    _imageId = imageId;
  }

  CameraResultResponse.fromJson(dynamic json) {
    _eventId = json["eventId"];
    _imageId = json["imageId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["eventId"] = _eventId;
    map["imageId"] = _imageId;
    return map;
  }
}
