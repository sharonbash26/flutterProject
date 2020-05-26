class Flower {
  String name;
  int date, count;
  double latitude, longitude;

  Flower.fromJson(Map<String, dynamic> map) {
    this.name = map['name'];
    this.date = map['date'];
    this.count = map['count'];
    this.latitude = map['latitude'];
    this.longitude = map['longitude'];
  }
}
