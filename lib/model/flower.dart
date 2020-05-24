class Flower {
  String name;

  Flower(this.name);

  Flower.fromJson(Map<String, dynamic> map) {
    this.name = map['name'];
  }
}
