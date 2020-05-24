import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/home_page.dart';
import 'package:flutterapp2/model/flower_address_model.dart';
import 'package:intl/intl.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';
import 'dart:math';
import 'model/flower_name_model.dart';

class AddFlowerScreen extends StatefulWidget {
  @override
  _AddFlowerScreenState createState() => _AddFlowerScreenState();
}

class _AddFlowerScreenState extends State<AddFlowerScreen> {
  final _textName = TextEditingController();
  final _textAddress = TextEditingController();
  final _databaseReference = Firestore.instance;
  final _flowerName = <FlowerNameModel>[
    FlowerNameModel.name('נרקיס'),
    FlowerNameModel.name('נילי'),
  ];
  final _flowerCity = <FlowerAddressModel>[
    FlowerAddressModel.address('ירושלים'),
    FlowerAddressModel.address('יקנעם'),
  ];
  FlowerNameModel _flowerNameSelected;
  FlowerAddressModel _flowerAddressSelected;

  @override
  void dispose() {
    super.dispose();

    _textName.dispose();
    _textAddress.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    String formattedDate = DateFormat('MM').format(now);
    int myMonth = int.parse(formattedDate);

    var rng = Random();

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SimpleAutocompleteFormField<FlowerNameModel>(
                decoration: InputDecoration(
                    labelText: 'הכנס שם של צמח', border: OutlineInputBorder()),
                suggestionsHeight: 80.0,
                itemBuilder: (context, person) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(person.name.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                ),
                onSearch: (search) async => _flowerName
                    .where((person) => person.name
                        .toLowerCase()
                        .contains(search.toLowerCase()))
                    .toList(),
                itemFromString: (string) => _flowerName.singleWhere(
                    (person) =>
                        person.name.toLowerCase() == string.toLowerCase(),
                    orElse: () => null),
                onChanged: (value) =>
                    setState(() => _flowerNameSelected = value),
                onSaved: (value) => setState(() => _flowerNameSelected = value),
                validator: (person) =>
                    person == null ? 'Invalid person.' : null,
              ),
              SizedBox(
                height: 20,
              ),
              SimpleAutocompleteFormField<FlowerAddressModel>(
                decoration: InputDecoration(
                    labelText: 'הכנס שם של עיר', border: OutlineInputBorder()),
                suggestionsHeight: 80.0,
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
                    person == null ? 'Invalid person.' : null,
              ),
              RaisedButton(
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                onPressed: () async => {
                  await _databaseReference
                      .collection(_flowerAddressSelected.address)
                      .document(rng.nextInt(1000000000).toString())
                      .setData({
                    "date": myMonth,
                    "name": _flowerNameSelected.name
                  }).then((value) => {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text("תודה רבה!"),
                                content: Text("הדיווח עבר בהצלחה!"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("בשמחה רבה!"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomePage(),
                                          ));
                                    },
                                  ),
                                ],
                              ),
                            )
                          })
                },
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
                    'הוסף צמח',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
