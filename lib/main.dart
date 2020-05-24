import 'package:flutter/material.dart';
import 'package:flutterapp2/home_page.dart';
import 'package:provider/provider.dart';
import 'location_service.dart';
import 'model/user_location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      StreamProvider<UserLocation>(
        create: (context) => LocationService().locationStream,
      ),
    ], child: MaterialApp(home: HomePage()));
  }
}
