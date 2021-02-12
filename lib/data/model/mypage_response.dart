class MyPageResponse {
  ClothesByClothesType clothesByClothesType;
  int myLabelCount;
  List<NoticeViewList> noticeViewList;

  MyPageResponse(
      {this.clothesByClothesType, this.myLabelCount, this.noticeViewList});

  MyPageResponse.fromJson(Map<String, dynamic> json) {
    clothesByClothesType = json['clothesByClothesType'] != null
        ? new ClothesByClothesType.fromJson(json['clothesByClothesType'])
        : null;
    myLabelCount = json['myLabelCount'];
    if (json['noticeViewList'] != null) {
      noticeViewList = new List<NoticeViewList>();
      json['noticeViewList'].forEach((v) {
        noticeViewList.add(new NoticeViewList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clothesByClothesType != null) {
      data['clothesByClothesType'] = this.clothesByClothesType.toJson();
    }
    data['myLabelCount'] = this.myLabelCount;
    if (this.noticeViewList != null) {
      data['noticeViewList'] =
          this.noticeViewList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClothesByClothesType {
  List<Top> top;
  List<Towel> towel;
  List<Socks> socks;
  List<Pants> pants;
  List<Underwear> underwear;

  ClothesByClothesType(
      {this.top, this.towel, this.socks, this.pants, this.underwear});

  ClothesByClothesType.fromJson(Map<String, dynamic> json) {
    if (json['TOP'] != null) {
      top = new List<Top>();
      json['TOP'].forEach((v) {
        top.add(new Top.fromJson(v));
      });
    }
    if (json['TOWEL'] != null) {
      towel = new List<Towel>();
      json['TOWEL'].forEach((v) {
        towel.add(new Towel.fromJson(v));
      });
    }
    if (json['SOCKS'] != null) {
      socks = new List<Socks>();
      json['SOCKS'].forEach((v) {
        socks.add(new Socks.fromJson(v));
      });
    }
    if (json['PANTS'] != null) {
      pants = new List<Pants>();
      json['PANTS'].forEach((v) {
        pants.add(new Pants.fromJson(v));
      });
    }
    if (json['UNDERWEAR'] != null) {
      underwear = new List<Underwear>();
      json['UNDERWEAR'].forEach((v) {
        underwear.add(new Underwear.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.top != null) {
      data['TOP'] =
          this.top.map((v) => v.toJson()).toList();
    }
    if (this.towel != null) {
      data['TOWEL'] =
          this.towel.map((v) => v.toJson()).toList();
    }
    if (this.socks != null) {
      data['SOCKS'] =
          this.socks.map((v) => v.toJson()).toList();
    }
    if (this.pants != null) {
      data['PANTS'] =
          this.pants.map((v) => v.toJson()).toList();
    }
    if (this.underwear != null) {
      data['UNDERWEAR'] =
          this.underwear.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cloth {
  String bleachType;
  String description;
  String dryCleaning;
  String dryType;
  List<Ingredients> ingredients;
  String ironingType;
  String title;
  String waterType;

  Cloth(
      {this.bleachType,
      this.description,
      this.dryCleaning,
      this.dryType,
      this.ingredients,
      this.ironingType,
      this.title,
      this.waterType});

  Cloth.fromJson(Map<String, dynamic> json) {
    bleachType = json['bleachType'];
    description = json['description'];
    dryCleaning = json['dryCleaning'];
    dryType = json['dryType'];
    if (json['ingredients'] != null) {
      ingredients = new List<Ingredients>();
      json['ingredients'].forEach((v) {
        ingredients.add(new Ingredients.fromJson(v));
      });
    }
    ironingType = json['ironingType'];
    title = json['title'];
    waterType = json['waterType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bleachType'] = this.bleachType;
    data['description'] = this.description;
    data['dryCleaning'] = this.dryCleaning;
    data['dryType'] = this.dryType;
    if (this.ingredients != null) {
      data['ingredients'] = this.ingredients.map((v) => v.toJson()).toList();
    }
    data['ironingType'] = this.ironingType;
    data['title'] = this.title;
    data['waterType'] = this.waterType;
    return data;
  }
}

class Top extends Cloth {
  Top.fromJson(v);
}

class Pants extends Cloth {
  Pants.fromJson(v);
}

class Towel extends Cloth {
  Towel.fromJson(v);
}

class Socks extends Cloth {
  Socks.fromJson(v);
}

class Underwear extends Cloth {
  Underwear.fromJson(v);
}

class Ingredients {
  String name;
  int percentage;

  Ingredients({this.name, this.percentage});

  Ingredients.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['percentage'] = this.percentage;
    return data;
  }
}

class NoticeViewList {
  String content;
  String description;
  String title;

  NoticeViewList({this.content, this.description, this.title});

  NoticeViewList.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['description'] = this.description;
    data['title'] = this.title;
    return data;
  }
}
