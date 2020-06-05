import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/add_flower.dart';
import 'package:flutterapp2/responsive_screen.dart';
import 'package:flutterapp2/search_flower.dart';
import 'scan_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back1.png"), fit: BoxFit.fill),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: ResponsiveScreen().heightMediaQuery(context, 15),
                ),
                Text(
                  "ברוך הבא\nבחר אחת מהאפשריות",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ArialNarrow',
                    color: Color(0xfa000000),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(
                  height: ResponsiveScreen().heightMediaQuery(context, 30),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: ResponsiveScreen().widthMediaQuery(context, 20),
                    ),
                    ButtonTheme(
                      minWidth: 143,
                      height: 143,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(90),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchFlower(),
                            ),
                          );
                        },
                        color: Color(0xff19dbee),
                        textColor: Colors.white,
                        child: AutoSizeText(
                          "חיפוש\nצמח\n לפי מיקום",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'ArialNarrow',
                            color: Color(0xfa000000),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ResponsiveScreen().heightMediaQuery(context, 8),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: ResponsiveScreen().widthMediaQuery(context, 110),
                    ),
                    ButtonTheme(
                      minWidth: 160,
                      height: 160,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(90),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScanScreen(),
                            ),
                          );
                        },
                        color: Color(0xff7bb7e1),
                        textColor: Colors.white,
                        child: AutoSizeText(
                          "סרוק את\nהמיקום\nשלי",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'ArialNarrow',
                            color: Color(0xfa000000),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ResponsiveScreen().heightMediaQuery(context, 8),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: ResponsiveScreen().widthMediaQuery(context, 200),
                    ),
                    ButtonTheme(
                      minWidth: 177,
                      height: 177,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(90),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddFlowerScreen(),
                            ),
                          );
                        },
                        color: Color(0xff3772c1),
                        textColor: Colors.white,
                        child: AutoSizeText(
                          "דווח על\nצמח",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'ArialNarrow',
                            color: Color(0xfa000000),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
