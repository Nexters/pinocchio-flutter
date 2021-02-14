/// imageId : "string"
/// result : {"bleachType":"ALL_JP","clothesColor":"BEIGE","dryCleaning":"DRY_CLEANING_FORBIDDEN_JP","dryType":"DRY_BLOWER_FORBIDDEN_KR","ingredientList":[{"name":"string","percentage":0}],"ironingType":"FORBIDDEN_JP","waterType":"FORBIDDEN_BLOWER_JP"}
/// status : "DONE"

class CaptureEventUpdateRequest {
  String _imageId;
  Result _result;
  String status;

  String get imageId => _imageId;

  Result get result => _result;

  CaptureEventUpdateRequest({String imageId, Result result, String status}) {
    _imageId = imageId;
    _result = result;
    status = status;
  }

  CaptureEventUpdateRequest.fromJson(dynamic json) {
    _imageId = json["imageId"];
    _result = json["result"] != null ? Result.fromJson(json["result"]) : null;
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["imageId"] = _imageId;
    if (_result != null) {
      map["result"] = _result.toJson();
    }
    map["status"] = status;
    return map;
  }
}

/// bleachType : "ALL_JP"
/// clothesColor : "BEIGE"
/// dryCleaning : "DRY_CLEANING_FORBIDDEN_JP"
/// dryType : "DRY_BLOWER_FORBIDDEN_KR"
/// ingredientList : [{"name":"string","percentage":0}]
/// ironingType : "FORBIDDEN_JP"
/// waterType : "FORBIDDEN_BLOWER_JP"

class Result {
  String _bleachType;
  String clothesColor;
  String _dryCleaning;
  String _dryType;
  List<IngredientList> _ingredientList;
  String _ironingType;
  String _waterType;

  String get bleachType => _bleachType;

  String get dryCleaning => _dryCleaning;

  String get dryType => _dryType;

  List<IngredientList> get ingredientList => _ingredientList;

  String get ironingType => _ironingType;

  String get waterType => _waterType;

  Result(
      {String bleachType,
      String clothesColor,
      String dryCleaning,
      String dryType,
      List<IngredientList> ingredientList,
      String ironingType,
      String waterType}) {
    _bleachType = bleachType;
    clothesColor = clothesColor;
    _dryCleaning = dryCleaning;
    _dryType = dryType;
    _ingredientList = ingredientList;
    _ironingType = ironingType;
    _waterType = waterType;
  }

  Result.fromJson(dynamic json) {
    _bleachType = json["bleachType"];
    clothesColor = json["clothesColor"];
    _dryCleaning = json["dryCleaning"];
    _dryType = json["dryType"];
    if (json["ingredientList"] != null) {
      _ingredientList = [];
      json["ingredientList"].forEach((v) {
        _ingredientList.add(IngredientList.fromJson(v));
      });
    }
    _ironingType = json["ironingType"];
    _waterType = json["waterType"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["bleachType"] = _bleachType;
    map["clothesColor"] = clothesColor;
    map["dryCleaning"] = _dryCleaning;
    map["dryType"] = _dryType;
    if (_ingredientList != null) {
      map["ingredientList"] = _ingredientList.map((v) => v.toJson()).toList();
    }
    map["ironingType"] = _ironingType;
    map["waterType"] = _waterType;
    return map;
  }
}

/// name : "string"
/// percentage : 0

class IngredientList {
  String _name;
  int _percentage;

  String get name => _name;

  int get percentage => _percentage;

  IngredientList({String name, int percentage}) {
    _name = name;
    _percentage = percentage;
  }

  IngredientList.fromJson(dynamic json) {
    _name = json["name"];
    _percentage = json["percentage"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["percentage"] = _percentage;
    return map;
  }
}
