class Kata {
  String? name;
  String? kanji;
  String? description;
  bool? selected;
  Kata({this.name, this.kanji, this.description, this.selected});

  Kata.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    kanji = json['kanji'];
    description = json['description'];
    selected =  json['selected'] == 1 ? true : false;
  }
}