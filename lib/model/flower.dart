class Flower {
  String name;
  int date, count;

  Flower.fromJson(Map<String, dynamic> map) {
    this.name = map['name'];
    this.date = map['date'];
    this.count = map['count'];
  }
}
