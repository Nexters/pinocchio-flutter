/// name : "string"
/// percentage : 0

class Ingredient {
  String _name;
  int _percentage;

  String get name => _name;

  int get percentage => _percentage;

  Ingredient({String name, int percentage}) {
    _name = name;
    _percentage = percentage;
  }

  Ingredient.fromJson(dynamic json) {
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
