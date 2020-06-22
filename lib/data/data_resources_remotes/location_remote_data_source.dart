import 'dart:convert';
import 'package:flutterapp2/core/services/constants.dart';
import 'package:flutterapp2/data/models/error.dart';
import 'package:flutterapp2/data/models/results.dart';
import 'package:http/http.dart' as http;

// TAKE THE DATA FRON GOOGLE SERVER-this all his roll of this class
class LocationRemoteDataSource {
  //singletone
  static final LocationRemoteDataSource singleton =
      LocationRemoteDataSource.internal();

  factory LocationRemoteDataSource() => singleton;

  LocationRemoteDataSource.internal();
///////////////////until here just singtone
  Error _error;
  List<Results> _places = List();//define new list in order to display  places into list
  String _baseUrl = Constants.baseUrl;
  String _API_KEY = Constants.API_KEY;

  // MY LON AND LAT OF MY LOCATION
  Future responseJsonLocation(double latitude, double longitude) async {
    // create the request to server which you want
    String url =
        '$_baseUrl?key=$_API_KEY&location=$latitude,$longitude&opennow=true&types=restaurant&radius=5000';
    final response = await http.get(url);//await because take time and because this is asynce
    if (response.statusCode == 200) {
      final data = json.decode(response.body);// NOW RECEIVE JSON
      _handleResponse(data);// check information
    } else {
      throw Exception('An error occurred getting places nearby');
    }
    return _places;// list of resluts
  }

  void _handleResponse(data) {
    if (data['status'] == "REQUEST_DENIED") {
      _error = Error.fromJson(data);//internal modal .recvie from json
      print(_error.errorMessage);//console
    } else if (data['status'] == "OK") {
      //if all o.k i inter to list
      _places = List<Results>.from(
        // here i just start to parser the informetion from jsoyn
        data['results']
            .map(
              (i) => Results.fromJson(i),// here the enter of information from json
            )
            .toList(),
      );
    }
  }
}
