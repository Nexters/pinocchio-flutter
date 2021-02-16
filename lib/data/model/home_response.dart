class HomeResponse {
  int globalCount;
  String nickName;
  List<Notices> notices;

  HomeResponse({this.globalCount, this.nickName, this.notices});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    globalCount = json['globalCount'];
    nickName = json['nickName'];
    if (json['notices'] != null) {
      notices = new List<Notices>();
      json['notices'].forEach((v) {
        notices.add(new Notices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['globalCount'] = this.globalCount;
    data['nickName'] = this.nickName;
    if (this.notices != null) {
      data['notices'] = this.notices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notices {
  String content;
  String description;
  String title;

  Notices({this.content, this.description, this.title});

  Notices.fromJson(Map<String, dynamic> json) {
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