class Flower {
  String name;
  int date;

  Flower(this.name, this.date);

  Flower.fromJson(Map<String, dynamic> map) {
    this.name = map['name'];
    this.date = map['date'];
  }
}
