import 'location.dart';

class Geometry {
  Location location;// into gemoty has lection

  Geometry.fromJson(Map<String, dynamic> json) {
    this.location = Location.fromJson(
      json['location'],// the name must be the same in json
    );
  }
}
//just parser