import 'ingredient.dart';

/// title : "폴리는 물세탁이 가장 좋은 섬유입니다."
/// description : "폴리 특성상 마찰에 의한 보풀이 잘 일어날 수 있는 섬유이기 때문에 손세탁으로 세탁하시면 좋습니다. 세제는 가능하면 중성세제나 약산성 전용세제를 사용하시고, 세탁은 무조건 실온물을 사용하시면 안전합니다."
/// ingredients : [{"name":"아크릴","percentage":40},{"name":"폴리에스테르","percentage":25},{"name":"캐시미어","percentage":15},{"name":"면","percentage":10},{"name":"실크","percentage":10}]
/// waterType : "WASHER_30_NEUTRAL_KR"
/// bleachType : "ALL_KR"
/// dryType : "DRY_SUNNY_HANGER_KR"
/// ironingType : "IRONING_140_160_FABRIC_KR"
/// dryCleaning : "DRY_CLEANING_OIL_KR"

class ResultViewResponse {
  String _title;
  String _description;
  List<Ingredient> _ingredients;
  String _waterType;
  String _bleachType;
  String _dryType;
  String _ironingType;
  String _dryCleaning;

  String get title => _title;
  String get description => _description;
  List<Ingredient> get ingredients => _ingredients;
  String get waterType => _waterType;
  String get bleachType => _bleachType;
  String get dryType => _dryType;
  String get ironingType => _ironingType;
  String get dryCleaning => _dryCleaning;

  ResultViewResponse(
      {String title,
      String description,
      List<Ingredient> ingredients,
      String waterType,
      String bleachType,
      String dryType,
      String ironingType,
      String dryCleaning}) {
    _title = title;
    _description = description;
    _ingredients = ingredients;
    _waterType = waterType;
    _bleachType = bleachType;
    _dryType = dryType;
    _ironingType = ironingType;
    _dryCleaning = dryCleaning;
  }

  ResultViewResponse.fromJson(dynamic json) {
    _title = json["title"];
    _description = json["description"];
    if (json["ingredients"] != null) {
      _ingredients = [];
      json["ingredients"].forEach((v) {
        _ingredients.add(Ingredient.fromJson(v));
      });
    }
    _waterType = json["waterType"];
    _bleachType = json["bleachType"];
    _dryType = json["dryType"];
    _ironingType = json["ironingType"];
    _dryCleaning = json["dryCleaning"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    map["description"] = _description;
    if (_ingredients != null) {
      map["ingredients"] = _ingredients.map((v) => v.toJson()).toList();
    }
    map["waterType"] = _waterType;
    map["bleachType"] = _bleachType;
    map["dryType"] = _dryType;
    map["ironingType"] = _ironingType;
    map["dryCleaning"] = _dryCleaning;
    return map;
  }
}
