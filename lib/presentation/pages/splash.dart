import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home_page.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
            seconds: 4,
            image: Image.asset(
              'assets/splash1.png',
              fit: BoxFit.fill,
            ),
            navigateAfterSeconds: HomePage(),
            loaderColor: Colors.transparent),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/splash1.png"), fit: BoxFit.fill),
          ),
        ),
      ],
    );
  }
}
