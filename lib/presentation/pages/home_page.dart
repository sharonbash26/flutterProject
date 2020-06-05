import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp2/presentation/pages/add_flower.dart';
import 'package:flutterapp2/presentation/utils/responsive_screen.dart';
import 'package:flutterapp2/presentation/pages/search_flower.dart';
import 'package:share/share.dart';
import 'scan_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: ResponsiveScreen().widthMediaQuery(context, 10),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.share,
                        size: 30,
                      ),
                      onPressed: () {
                        _share();
                      },
                    ),
                  ],
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

  _share() {
    final RenderBox box = context.findRenderObject();
    Share.share('check out my website https://example.com',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
