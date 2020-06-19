class Photo {
  String photoReference;
//parser
  Photo.fromJson(Map<String, dynamic> json) {
    this.photoReference = json['photo_reference'];
  }
}
