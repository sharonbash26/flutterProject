import 'package:flutter/material.dart';
import 'presentation/pages/splash.dart';
import 'package:provider/provider.dart';
import 'core/services/location_service.dart';
import 'data/models/user_location.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserLocation>(
          create: (context) => LocationService().locationStream,
        ),
      ],
      child: MaterialApp(
        home: Splash(),
      ),
    );
  }
}
