import 'dart:async';
import 'package:location/location.dart';
import 'package:flutterapp2/data/models/user_location.dart';

class LocationService {
  Location _location = Location(); // save lon and lat .function from library
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    _location.requestPermission().then(
      (granted) {
        if (granted != null) {
          _location.onLocationChanged.listen(
            (locationData) {
              if (locationData != null) {
                _locationController.add(
                  UserLocation(
                    latitude: locationData.latitude,
                    longitude: locationData.longitude,
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  Stream<UserLocation> get locationStream => _locationController.stream;
}
