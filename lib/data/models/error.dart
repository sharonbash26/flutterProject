class Error {
  String errorMessage;
//parser from json
  Error.fromJson(Map<String, dynamic> json) {
    this.errorMessage = json['error_message'];
  }
}
