/// ingredientList : [{"name":"string","percentage":0}]
/// waterType : "FORBIDDEN_BLOWER_JP"
/// bleachType : "ALL_JP"
/// ironingType : "FORBIDDEN_JP"
/// dryType : "DRY_BLOWER_FORBIDDEN_KR"
/// dryCleaning : "DRY_CLEANING_FORBIDDEN_JP"
/// clothesColor : "BEIGE"

class CaptureEventResultResponse {
  List<IngredientList> _ingredientList;
  String _waterType;
  String _bleachType;
  String _ironingType;
  String _dryType;
  String _dryCleaning;
  String _clothesColor;

  List<IngredientList> get ingredientList => _ingredientList;
  String get waterType => _waterType;
  String get bleachType => _bleachType;
  String get ironingType => _ironingType;
  String get dryType => _dryType;
  String get dryCleaning => _dryCleaning;
  String get clothesColor => _clothesColor;

  CaptureEventResultResponse(
      {List<IngredientList> ingredientList,
      String waterType,
      String bleachType,
      String ironingType,
      String dryType,
      String dryCleaning,
      String clothesColor}) {
    _ingredientList = ingredientList;
    _waterType = waterType;
    _bleachType = bleachType;
    _ironingType = ironingType;
    _dryType = dryType;
    _dryCleaning = dryCleaning;
    _clothesColor = clothesColor;
  }

  CaptureEventResultResponse.fromJson(dynamic json) {
    if (json["ingredientList"] != null) {
      _ingredientList = [];
      json["ingredientList"].forEach((v) {
        _ingredientList.add(IngredientList.fromJson(v));
      });
    }
    _waterType = json["waterType"];
    _bleachType = json["bleachType"];
    _ironingType = json["ironingType"];
    _dryType = json["dryType"];
    _dryCleaning = json["dryCleaning"];
    _clothesColor = json["clothesColor"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_ingredientList != null) {
      map["ingredientList"] = _ingredientList.map((v) => v.toJson()).toList();
    }
    map["waterType"] = _waterType;
    map["bleachType"] = _bleachType;
    map["ironingType"] = _ironingType;
    map["dryType"] = _dryType;
    map["dryCleaning"] = _dryCleaning;
    map["clothesColor"] = _clothesColor;
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
