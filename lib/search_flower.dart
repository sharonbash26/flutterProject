import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/responsive_screen.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';
import 'model/flower.dart';
import 'model/flower_address_model.dart';

class SearchFlower extends StatefulWidget {
  @override
  _SearchFlowerState createState() => _SearchFlowerState();
}

class _SearchFlowerState extends State<SearchFlower> {
  StreamSubscription<QuerySnapshot> _placeSub;
  List<Flower> flowers = List();
  final _flowerCity = <FlowerAddressModel>[
    FlowerAddressModel.address('ירושלים'),
    FlowerAddressModel.address('נתניה'),
  ];
  FlowerAddressModel _flowerAddressSelected;

  @override
  void dispose() {
    super.dispose();

    _placeSub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SimpleAutocompleteFormField<FlowerAddressModel>(
                decoration: InputDecoration(
                    labelText: 'הכנס שם של עיר', border: OutlineInputBorder()),
                suggestionsHeight: ResponsiveScreen().heightMediaQuery(context, 160),
                itemBuilder: (context, person) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(person.address.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                ),
                onSearch: (search) async => _flowerCity
                    .where((person) => person.address
                        .toLowerCase()
                        .contains(search.toLowerCase()))
                    .toList(),
                itemFromString: (string) => _flowerCity.singleWhere(
                    (person) =>
                        person.address.toLowerCase() == string.toLowerCase(),
                    orElse: () => null),
                onChanged: (value) =>
                    setState(() => _flowerAddressSelected = value),
                onSaved: (value) =>
                    setState(() => _flowerAddressSelected = value),
                validator: (person) =>
                    person == null ? 'העיר לא קיימת' : null,
              ),
              SizedBox(
                height: ResponsiveScreen().heightMediaQuery(context, 20),
              ),
              RaisedButton(
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                onPressed: () => {_search(_flowerAddressSelected.address)},
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF5e7974),
                          Color(0xFF6494ED),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(80.0))),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    'חפש צמח',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: ResponsiveScreen().heightMediaQuery(context, 20),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: flowers.length,
                  itemBuilder: (context, i) {
                    return Center(child: Text(flowers[i].name));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _search(String city) {
    _placeSub?.cancel();
    Stream<QuerySnapshot> _snapshots =
        Firestore.instance.collection(city).snapshots();
    _placeSub = _snapshots.listen((QuerySnapshot snapshot) {
      final List<Flower> flowers = snapshot.documents
          .map((documentSnapshot) => Flower.fromJson(documentSnapshot.data))
          .toList();

      setState(() {
        this.flowers = flowers;
      });
    });
  }
}
