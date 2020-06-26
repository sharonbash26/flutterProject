import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp2/data/models/flower.dart';
import 'package:flutterapp2/presentation/pages/places_open_now.dart';
import 'package:flutterapp2/presentation/utils/responsive_screen.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';
import 'package:flutterapp2/data/models/user_location.dart';
import 'package:intl/intl.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  StreamSubscription<QuerySnapshot> _placeSub; //take always information from firebase
  List<Flower> _flowers = List();
  var _userLocation;
  String _city;
  int _pagination = 5;

  @override
  void initState() {
    super.initState();

//    _getLocationPermission();
  }

  @override
  void dispose() {
    super.dispose();

    _placeSub?.cancel();  //אם יוצאים מclass הזה מבטל משיכת מידע מהfirebase
  }

  @override
  Widget build(BuildContext context) {
    _userLocation = Provider.of<UserLocation>(context);
    _getCity().then(
      (String value) {
        setState(
          () {
            _city = value;
            _placeSub?.cancel();  //cancel  listen from firebase
            Stream<QuerySnapshot> _snapshots = Firestore.instance
                .collection(
                  _city.trim(),
                )
                .limit(_pagination)
                .snapshots();
            _placeSub = _snapshots.listen(
              (QuerySnapshot snapshot) {
                final List<Flower> flowers = snapshot.documents
                    .map(
                      (documentSnapshot) =>
                          Flower.fromJson(documentSnapshot.data),//פירוק
                    )
                    .toList();

                this._flowers = flowers;
              },
            );
          },
        );
      },
    );

    var now = DateTime.now();
    String formattedDate = DateFormat('MM').format(now);
    int myMonth = int.parse(formattedDate);

    String myCity = _city != null ? _city.trim() : "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "הצמחים שנמצאים ב$myCity",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/back2.png"), fit: BoxFit.fill),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ResponsiveScreen().heightMediaQuery(context, 20),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0), //בשביל שכפתור יהיה עגול
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlacesOpenNow(),
                    ),
                  ),
                },
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.blueGrey,
                        Colors.green,
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(80.0),
                    ),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth:
                          ResponsiveScreen().widthMediaQuery(context, 150),
                      minHeight:
                          ResponsiveScreen().heightMediaQuery(context, 45),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'מסעדות בקרבתך',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ResponsiveScreen().heightMediaQuery(context, 20),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _flowers.length,
                  itemBuilder: (context, i) {
                    return _flowers[i].count > 9 && myMonth == _flowers[i].date
                        ? Container( //design of all itembox
                            height: ResponsiveScreen()
                                .heightMediaQuery(context, 50),
                            margin: EdgeInsets.only(
                              left: ResponsiveScreen()
                                  .widthMediaQuery(context, 20),
                              right: ResponsiveScreen()
                                  .widthMediaQuery(context, 20),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFFDF2E9),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _flowers[i].count > 9
                                    ? myMonth == _flowers[i].date
                                        ? _flowers[i].name  //התחנה הסופית
                                        : ""
                                    : "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'ArialNarrow',
                                  color: Color(0xfa000000),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          )
                               : Container();
                  },
                  separatorBuilder: (context, i) {
                    return SizedBox(
                      height: ResponsiveScreen().heightMediaQuery(context, 10),
                    );
                  },
                ),
              ),
              SizedBox(
                height: ResponsiveScreen().heightMediaQuery(context, 20),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                ),
                onPressed: () => {
                  _add(),
                },
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.blueGrey,
                        Colors.green,
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(80.0),
                    ),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth:
                          ResponsiveScreen().widthMediaQuery(context, 150),
                      minHeight:
                          ResponsiveScreen().heightMediaQuery(context, 45),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'הבא',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//  _getLocationPermission() async {
//    var location = loc.Location();// אחראי לתת השראה לקבל מיקום
//    try {
//      location.requestPermission();
//    } on PlatformException catch (e) {
//      if (e.code == 'PERMISSION_DENIED') {
//        print('Permission denied');
//      }
//    }
//  }

  Future _add() {
    setState(
      () {
        _pagination += 5;
      },
    );
  }

//convert lon and lat to city
  Future<String> _getCity() async {
    final coordinates =
        new Coordinates(_userLocation.latitude, _userLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    List<String> arr = first.addressLine.split(',');
    return arr[1].toString();
  }
}
