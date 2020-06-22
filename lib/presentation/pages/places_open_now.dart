import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp2/core/services/constants.dart';
import 'package:flutterapp2/data/models/results.dart';
import 'package:flutterapp2/data/models/user_location.dart';
import 'package:flutterapp2/data/repositories_impl/location_repo_impl.dart';
import 'package:flutterapp2/presentation/utils/responsive_screen.dart';
import 'package:provider/provider.dart';
import 'package:latlong/latlong.dart' as dis;

class PlacesOpenNow extends StatefulWidget {
  @override
  _PlacesOpenNowState createState() => _PlacesOpenNowState();
}

class _PlacesOpenNowState extends State<PlacesOpenNow> {
  var _userLocation;
  bool _searching = true; // sign to server in orrder if search or not
  List<Results> _places = List(); //new emty list
  String _API_KEY = Constants.API_KEY;
  LocationRepoImpl _locationRepoImpl =
      LocationRepoImpl(); //concat between method from server side to placeslist like mvvm conact between view to misha side server

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    _userLocation = Provider.of<UserLocation>(context); //take user locatin
    _searchNearbyTotal(_searching);// recive the place fromm the method down
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _searching // check if this true he search . if this false he display the list
                  ? CircularProgressIndicator()// the cryle
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _places.length,
                        //this for culcute the distance from the place to place . if you more near to place it will change
                        itemBuilder: (context, index) {
                          final dis.Distance _distance = dis.Distance();
                          final double _meter = _distance(
                            dis.LatLng(_userLocation.latitude,
                                _userLocation.longitude),
                            dis.LatLng(_places[index].geometry.location.lat,
                                _places[index].geometry.location.lng),
                          );
                          return Container(
                            color: Colors.grey,
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: ResponsiveScreen()
                                          .heightMediaQuery(context, 5),
                                      width: double.infinity,
                                      child: const DecoratedBox(
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                      ),
                                    ),
                                    CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      height: ResponsiveScreen()
                                          .heightMediaQuery(context, 150),// 150 height of image
                                      width: double.infinity,
                                      imageUrl: _places[index].photos.isNotEmpty// check if photo exist in json
                                          ? "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=" +
                                              _places[index]
                                                  .photos[0]
                                                  .photoReference +
                                              "&key=$_API_KEY"
                                          : "https://upload.wikimedia.org/wikipedia/commons/7/75/No_image_available.png",// photo if image dont avible
                                      placeholder: (context, url) =>    //Rotating circle.
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => //זה ממש למקרה שיש שגיאה והתמונה לא עולה
                                          const Icon(Icons.error),
                                    ),
                                    SizedBox(
                                      height: ResponsiveScreen()
                                          .heightMediaQuery(context, 5),
                                      width: double.infinity,
                                      child: const DecoratedBox(
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: ResponsiveScreen()
                                      .heightMediaQuery(context, 160),//phots design
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        const Color(0xAA000000),
                                        const Color(0x00000000),
                                        const Color(0x00000000),
                                        const Color(0xAA000000),  //עיצוב לתמנות בפינות
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),//rahok from kasvot
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      _textListView(_places[index].name, 17.0,///this size of name of place
                                          0xffE9FFFF),
                                      _textListView(_places[index].vicinity,// this size of vicinity
                                          15.0, 0xFFFFFFFF),
                                      _textListView(_calculateDistance(_meter),
                                          15.0, 0xFFFFFFFF),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
////here i call to him
//  Future<void> _getLocationPermission() async {
//    var location = loc.Location();
//    try {
//      location.requestPermission();
//    } on PlatformException catch (e) {
//      if (e.code == 'PERMISSION_DENIED') {
//        print('Permission denied');
//      }
//    }
//  }
//design for text
  Widget _textListView(String text, double fontSize, int color) {
    return Text(
      text,
      style: TextStyle(
        shadows: <Shadow>[
          Shadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 1.0,
            color: Color(0xAA000000),
          ),
        ],
        fontSize: fontSize,
        color: Color(color),
      ),
    );
  }
// choose how to display meter of km
  String _calculateDistance(double _meter) {
    String _myMeters;
    if (_meter < 1000.0) {
      _myMeters = 'Meters: ' + (_meter.round()).toString();
    } else {
      _myMeters =
          'KM: ' + (_meter.round() / 1000.0).toStringAsFixed(2).toString();
    }

    return _myMeters;
  }
// first of all search and then do sort
  void _searchNearbyTotal(bool isSearching) {
    _searchNearby(isSearching).then(
      (value) => _sortSearchNearby(value),
    );
  }

// reyrn the nearst 20 place the most nearby from json. recive my lon and lat
  Future _searchNearby(bool isSearching) async {
    if (isSearching) {
      _places = await _locationRepoImpl.getLocationJson(
          _userLocation.latitude, _userLocation.longitude);
      setState(() {
        _searching = false;
      });
    }
    return _places;
  }

// sort by nerby. a item first . b iem second comapre who the bearby
  void _sortSearchNearby(List<Results> _places) {
    _places.sort(
      (a, b) => sqrt(
        pow(a.geometry.location.lat - _userLocation.latitude, 2) +
            pow(a.geometry.location.lng - _userLocation.longitude, 2),
      ).compareTo(
        sqrt(
          pow(b.geometry.location.lat - _userLocation.latitude, 2) +
              pow(b.geometry.location.lng - _userLocation.longitude, 2),
        ),
      ),
    );
  }
}
