import 'package:flutterapp2/data/models/photo.dart';
import 'geometry.dart';

class Results {
  String name;
  String vicinity; //harzel 22
  Geometry geometry;
  List<Photo> photos;

  Results.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.vicinity = json['vicinity'];
    this.geometry = Geometry.fromJson(
      json['geometry'],
    );
    this.photos = json.containsKey("photos")
        ? List<Photo>.from(
            json['photos']
                .map<Photo>(
                  (i) => Photo.fromJson(i),
                )
                .toList(),
          ) //beacuse []
        : []; // if i dont have phote return emty list
  }
}
