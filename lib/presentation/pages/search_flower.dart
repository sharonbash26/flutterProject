import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/presentation/utils/responsive_screen.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';
import 'package:flutterapp2/data/models/flower.dart';
import 'package:flutterapp2/data/models/flower_address_model.dart';

class SearchFlower extends StatefulWidget {
  @override
  _SearchFlowerState createState() => _SearchFlowerState();
}

class _SearchFlowerState extends State<SearchFlower> {
  StreamSubscription<QuerySnapshot> _placeSub;// take always information from firebase
  List<Flower> flowers = List();//crste emty list new list
  final _flowerCity = <FlowerAddressModel>[
    FlowerAddressModel.address('ירושלים'),
    FlowerAddressModel.address('נתניה'),
    FlowerAddressModel.address('אביחיל'),
    FlowerAddressModel.address('אבו גווייעד'),
    FlowerAddressModel.address('אבו סנאן'),
    FlowerAddressModel.address('גבעת שמואל'),
    FlowerAddressModel.address('רמת גן'),
    FlowerAddressModel.address('בני ברק'),
    FlowerAddressModel.address('תל אביב'),
    FlowerAddressModel.address('קריית אונו'),
    FlowerAddressModel.address('תנובות'),
    FlowerAddressModel.address('טולכרם'),

  ];
  FlowerAddressModel _flowerAddressSelected;
  int _pagination = 0;// num of item to display  . always just 5 items

  @override
  void dispose() {
    super.dispose();//destory app when close

    _placeSub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/back2.png"), fit: BoxFit.fill),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: ResponsiveScreen().heightMediaQuery(context, 60),
            ),
            Container(
              margin: EdgeInsets.only(
                left: ResponsiveScreen().widthMediaQuery(context, 20),
                right: ResponsiveScreen().widthMediaQuery(context, 20),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SimpleAutocompleteFormField<FlowerAddressModel>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(30),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'הכנס שם של עיר'),
                  suggestionsHeight:
                      ResponsiveScreen().heightMediaQuery(context, 160),
                  itemBuilder: (context, address) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address.address.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ]),
                  ),
                  onSearch: (search) async => _flowerCity
                      .where(
                        (address) => address.address.toLowerCase().contains(
                              search.toLowerCase(),
                            ),
                      )
                      .toList(),
                  itemFromString: (string) => _flowerCity.singleWhere(
                      (address) =>
                          address.address.toLowerCase() == string.toLowerCase(),
                      orElse: () => null),
                  onChanged: (value) =>
                      setState(() => _flowerAddressSelected = value),
                  onSaved: (value) =>
                      setState(() => _flowerAddressSelected = value),
                  validator: (address) =>
                      address == null ? 'העיר לא קיימת' : null,
                ),
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
                _search(
                    true,
                    _flowerAddressSelected != null
                        ? _flowerAddressSelected.address
                        : ''),
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
                    minWidth: ResponsiveScreen().widthMediaQuery(context, 150),
                    minHeight: ResponsiveScreen().heightMediaQuery(context, 45),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'חפש צמח',
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
            Container(
              height: ResponsiveScreen().heightMediaQuery(context, 230),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.separated(
                      itemCount: flowers.length,
                      itemBuilder: (context, i) {
                        return Container(
                          height:
                              ResponsiveScreen().heightMediaQuery(context, 50),
                          margin: EdgeInsets.only(
                            left:
                                ResponsiveScreen().widthMediaQuery(context, 20),
                            right:
                                ResponsiveScreen().widthMediaQuery(context, 20),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFFDF2E9),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              flowers[i].name,
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
                        );
                      },
                      separatorBuilder: (context, i) {
                        return SizedBox(
                          height:
                              ResponsiveScreen().heightMediaQuery(context, 10),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ResponsiveScreen().heightMediaQuery(context, 30),
            ),
            _pagination > 0
                ? RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    onPressed: () => {
                      _search(false, _flowerAddressSelected.address),
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
                              'הוסף',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Future _search(bool search, String city) {
    if (city != '') {
      setState(
        () {
          search ? _pagination = 5 : _pagination += 5;
        },
      );
      _placeSub?.cancel();//ols search delte if i want new search
      Stream<QuerySnapshot> _snapshots =
          Firestore.instance.collection(city).limit(_pagination).snapshots();
      _placeSub = _snapshots.listen(
        (QuerySnapshot snapshot) {
          final List<Flower> flowers = snapshot.documents
              .map(
                (documentSnapshot) => Flower.fromJson(documentSnapshot.data),
              )
              .toList();

          setState(
            () {
              this.flowers = flowers;
            },
          );
        },
      );
    }
  }
}
