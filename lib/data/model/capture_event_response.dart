/// eventId : "2682fed3-4137-4e1b-bbe1-3299e5117cc0"
/// imageId : "62c889bd-f62d-49e2-a7fc-7ac20da491cf"
/// status : "DONE"
/// result : "{"ingredientList":[{"name":"아크릴","percentage":35}, {"name":"폴리에스테르","percentage":25}, {"name":"캐시미어","percentage":20}, {"name":"면","percentage":10}, {"name":"실크","percentage":10}],"waterType":"WASHER_30_NEUTRAL_KR","bleachType":"ALL_KR","ironingType":"IRONING_140_160_FABRIC_KR","dryType":"DRY_SUNNY_HANGER_KR","dryCleaning":"DRY_CLEANING_OIL_KR","clothesColor":"BEIGE"}"

class CaptureEventResponse {
  String _eventId;
  String _imageId;
  String _status;
  String _result;

  String get eventId => _eventId;
  String get imageId => _imageId;
  String get status => _status;
  String get result => _result;

  CaptureEventResponse(
      {String eventId, String imageId, String status, String result}) {
    _eventId = eventId;
    _imageId = imageId;
    _status = status;
    _result = result;
  }

  CaptureEventResponse.fromJson(dynamic json) {
    _eventId = json["eventId"];
    _imageId = json["imageId"];
    _status = json["status"];
    _result = json["result"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["eventId"] = _eventId;
    map["imageId"] = _imageId;
    map["status"] = _status;
    map["result"] = _result;
    return map;
  }
}
