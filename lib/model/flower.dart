class Flower {
  String name;
  int date;

  Flower.fromJson(Map<String, dynamic> map) {
    this.name = map['name'];
    this.date = map['date'];
  }
}
