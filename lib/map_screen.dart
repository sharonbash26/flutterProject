import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp2/model/flower.dart';
import 'package:flutterapp2/responsive_screen.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';
import 'model/user_location.dart';
import 'package:intl/intl.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer(); //from google map
  StreamSubscription<QuerySnapshot> _placeSub;
  List<Flower> flowers = List();
  var _userLocation;
  String city;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.682899, 34.634510), // lat lon of israel
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    _getLocationPermission();
  }

  @override
  void dispose() {
    super.dispose();

    _placeSub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _userLocation = Provider.of<UserLocation>(context);
    _getCity().then((String value) {
      setState(() {
        city = value;
        _placeSub?.cancel();
        Stream<QuerySnapshot> _snapshots =
            Firestore.instance.collection(city.trim()).snapshots();
        _placeSub = _snapshots.listen((QuerySnapshot snapshot) {
          final List<Flower> flowers = snapshot.documents
              .map((documentSnapshot) => Flower.fromJson(documentSnapshot.data))
              .toList();

          this.flowers = flowers;
        });
      });
    });

    var now = DateTime.now();
    String formattedDate = DateFormat('MM').format(now);
    int myMonth = int.parse(formattedDate);

    String myCity = city != null ? city.trim() : "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "הצמחים שנמצאים ב$myCity",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: flowers.length,
                  itemBuilder: (context, i) {
                    return Center(
                        child: Text(flowers[i].count > 9
                            ? myMonth == flowers[i].date ? flowers[i].name : ""
                            : ""));
                  },
                ),
              ),
              SizedBox(
                height: ResponsiveScreen().heightMediaQuery(context, 20),
              ),
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getLocationPermission() async {
    var location = loc.Location();
    try {
      location.requestPermission();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }

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
