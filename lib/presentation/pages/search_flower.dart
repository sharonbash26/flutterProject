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
  StreamSubscription<QuerySnapshot>
      _placeSub; // take always information from firebase
  List<Flower> flowers = List(); //crste emty list new list
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
    FlowerAddressModel.address('אבו גווייעד'),
    FlowerAddressModel.address('אבו גוש'),
    FlowerAddressModel.address('אבו סנאן'),
    FlowerAddressModel.address('אבו סריחאן'),
    FlowerAddressModel.address('אבו עבדון'),
    FlowerAddressModel.address('אבו עמאר'),
    FlowerAddressModel.address('אבו עמרה'),
    FlowerAddressModel.address('אבו קורינאת'),
    FlowerAddressModel.address('אבו רובייעה'),
    FlowerAddressModel.address('אבו רוקייק'),
    FlowerAddressModel.address('אבו תלול'),
    FlowerAddressModel.address('אבטין'),
    FlowerAddressModel.address('אבטליון'),
    FlowerAddressModel.address('אביאל'),
    FlowerAddressModel.address('אביבים'),
    FlowerAddressModel.address('אביגדור'),
    FlowerAddressModel.address('אביחיל'),
    FlowerAddressModel.address('אביטל'),
    FlowerAddressModel.address('אביעזר'),
    FlowerAddressModel.address('אבירים'),
    FlowerAddressModel.address('אבן יהודה'),
    FlowerAddressModel.address('אבן מנחם'),
    FlowerAddressModel.address('אבן ספיר'),
    FlowerAddressModel.address('אבן שמואל'),
    FlowerAddressModel.address('אבני איתן'),
    FlowerAddressModel.address('אבני חפץ'),
    FlowerAddressModel.address('אבנת'),
    FlowerAddressModel.address('אבשלום'),
    FlowerAddressModel.address('אדורה'),
    FlowerAddressModel.address('אדירים'),
    FlowerAddressModel.address('אדמית'),
    FlowerAddressModel.address('אדרת'),
    FlowerAddressModel.address('אודים'),
    FlowerAddressModel.address('אודם'),
    FlowerAddressModel.address('אוהד'),
    FlowerAddressModel.address('אום אל-פחם'),
    FlowerAddressModel.address('אום אל-קוטוף'),
    FlowerAddressModel.address('אום בטין'),
    FlowerAddressModel.address('אומן'),
    FlowerAddressModel.address('אומץ'),
    FlowerAddressModel.address('אופקים'),
    FlowerAddressModel.address('אור הגנוז'),
    FlowerAddressModel.address('אור הנר'),
    FlowerAddressModel.address('אור יהודה'),
    FlowerAddressModel.address('אור עקיבא'),
    FlowerAddressModel.address('אורה'),
    FlowerAddressModel.address('אורון'),
    FlowerAddressModel.address('אורות'),
    FlowerAddressModel.address('אורטל'),
    FlowerAddressModel.address('אורים'),
    FlowerAddressModel.address('אורנים'),
    FlowerAddressModel.address('אורנית'),
    FlowerAddressModel.address('אושה'),
    FlowerAddressModel.address('אזור'),
    FlowerAddressModel.address('אילון'),
    FlowerAddressModel.address('אשדוד'),
    FlowerAddressModel.address('אשקלון'),
    FlowerAddressModel.address('באר שבע'),
    FlowerAddressModel.address('בשור'),
    FlowerAddressModel.address('גלילות'),
    FlowerAddressModel.address('גרר'),
    FlowerAddressModel.address('זכרון יעקב'),
    FlowerAddressModel.address('חדרה'),
    FlowerAddressModel.address('חולון'),
    FlowerAddressModel.address('חיפה'),
    FlowerAddressModel.address('חצור'),
    FlowerAddressModel.address('יחיעם'),
    FlowerAddressModel.address('ים המלח'),
    FlowerAddressModel.address('יקנעם'),
    FlowerAddressModel.address('כינרות'),
    FlowerAddressModel.address('כנרות'),
    FlowerAddressModel.address('כרמיאל'),
    FlowerAddressModel.address('לכיש'),
    FlowerAddressModel.address('מודיעין'),
    FlowerAddressModel.address('מלאכי'),
    FlowerAddressModel.address('נהרייה'),
    FlowerAddressModel.address('עכו'),
    FlowerAddressModel.address('פתח תקווה'),
    FlowerAddressModel.address('ראשון לציון'),
    FlowerAddressModel.address('רחובות'),
    FlowerAddressModel.address('רמלה'),
    FlowerAddressModel.address('רמת גן'),
    FlowerAddressModel.address('שפרעם'),
    FlowerAddressModel.address('תל אביב'),
    FlowerAddressModel.address('משגב'),
    FlowerAddressModel.address('אכסאל'),
    FlowerAddressModel.address('אכזיב'),
    FlowerAddressModel.address('אזור תעשייה נעמן(מילואות)'),
    FlowerAddressModel.address('אחווה'),
    FlowerAddressModel.address('אחוזם'),
    FlowerAddressModel.address('אחוזת ברק'),
    FlowerAddressModel.address('אחיהוד'),
    FlowerAddressModel.address('אחיטוב'),
    FlowerAddressModel.address('אחיסמך'),
    FlowerAddressModel.address('אחיעזר'),
    FlowerAddressModel.address('אטרש'),
    FlowerAddressModel.address('איבים'),
    FlowerAddressModel.address('אייל'),
    FlowerAddressModel.address('איילת השחר'),
    FlowerAddressModel.address('אילון'),
    FlowerAddressModel.address('אילון תבור'),
    FlowerAddressModel.address('אילות'),
    FlowerAddressModel.address('אילנייה'),
    FlowerAddressModel.address('אילת'),
    FlowerAddressModel.address('אירוס'),
    FlowerAddressModel.address('איתמר'),
    FlowerAddressModel.address('איתן'),
    FlowerAddressModel.address('איתנים'),
    FlowerAddressModel.address('אכסאל'),
    FlowerAddressModel.address('אל-עזי'),
    FlowerAddressModel.address('אל-עריאן'),
    FlowerAddressModel.address('אל-רום'),
    FlowerAddressModel.address('אח סייד'),
    FlowerAddressModel.address('אלומה'),
    FlowerAddressModel.address('אלומות'),
    FlowerAddressModel.address('אלון הגליל'),
    FlowerAddressModel.address('אלון מורה'),
    FlowerAddressModel.address('אלון שבות'),
    FlowerAddressModel.address('אלוני אבא'),
    FlowerAddressModel.address('אלוני הבשן'),
    FlowerAddressModel.address('אלוני יצחק'),
    FlowerAddressModel.address('אלונים'),
    FlowerAddressModel.address('אלי-עד'),
    FlowerAddressModel.address('אליאב'),
    FlowerAddressModel.address('אליכין'),
    FlowerAddressModel.address('אליפז'),
    FlowerAddressModel.address('אליפלט'),
    FlowerAddressModel.address('אליקים'),
    FlowerAddressModel.address('אלישיב'),
    FlowerAddressModel.address('אלישמע'),
    FlowerAddressModel.address('אלמגור'),
    FlowerAddressModel.address('אלמוג'),
    FlowerAddressModel.address('אלעד'),
    FlowerAddressModel.address('אלעזר'),
    FlowerAddressModel.address('אלפי מנשה'),
    FlowerAddressModel.address('אלקוש'),
    FlowerAddressModel.address('אלקנה'),
    FlowerAddressModel.address('אמונים'),
    FlowerAddressModel.address('אמירים'),
    FlowerAddressModel.address('אמנון'),
    FlowerAddressModel.address('אמציה'),
    FlowerAddressModel.address('אניעם'),
    FlowerAddressModel.address('אסד'),
    FlowerAddressModel.address('אספר'),
    FlowerAddressModel.address('אעבלין'),
    FlowerAddressModel.address('אעצם'),
    FlowerAddressModel.address('אפיניש'),
    FlowerAddressModel.address('אפיק'),
    FlowerAddressModel.address('אפיקים'),
    FlowerAddressModel.address('אפק'),
    FlowerAddressModel.address('אפרת'),
    FlowerAddressModel.address('ארבל'),
    FlowerAddressModel.address('ארגמן'),
    FlowerAddressModel.address('ארז'),
    FlowerAddressModel.address('אריאל'),
    FlowerAddressModel.address('ארסוף'),
    FlowerAddressModel.address('אשבול'),
    FlowerAddressModel.address('אשבל'),
    FlowerAddressModel.address('אשדוד'),
    FlowerAddressModel.address('אשדות יעקב(איחוד)'),
    FlowerAddressModel.address('אשדות יעקב(מאוחד)'),
    FlowerAddressModel.address('אשחר'),
    FlowerAddressModel.address('אשכולות'),
    FlowerAddressModel.address('אשל הנשיא'),
    FlowerAddressModel.address('אשלים'),
    FlowerAddressModel.address('אשקלון'),
    FlowerAddressModel.address('אשרת'),
    FlowerAddressModel.address('אשתאול'),
    FlowerAddressModel.address('באקה אל-גרביה'),
    FlowerAddressModel.address('באר אורה'),
    FlowerAddressModel.address('באר גנים'),
    FlowerAddressModel.address('באר טוביה'),
    FlowerAddressModel.address('באר יעקב'),
    FlowerAddressModel.address('באר מילכה'),
    FlowerAddressModel.address('באר שבע'),
    FlowerAddressModel.address('בארות יצחק'),
    FlowerAddressModel.address('בארותיים'),
    FlowerAddressModel.address('בארי'),
    FlowerAddressModel.address('בוסתן הגליל'),
    FlowerAddressModel.address('בועיינה-נוגידאת'),
    FlowerAddressModel.address('בוקעאתא'),
    FlowerAddressModel.address('בורגתה'),
    FlowerAddressModel.address('בחן'),
    FlowerAddressModel.address('בטחה'),
    FlowerAddressModel.address('מטה אשר'),
    FlowerAddressModel.address('ביצרון'),
    FlowerAddressModel.address('ביר אל-מכסור'),
    FlowerAddressModel.address('ביר הדאג'),
    FlowerAddressModel.address('בירייה'),
    FlowerAddressModel.address('בית אורן'),
    FlowerAddressModel.address('בית אל'),
    FlowerAddressModel.address('בית אלעזרי'),
    FlowerAddressModel.address('בית אלפא'),
    FlowerAddressModel.address('בית אריה'),
    FlowerAddressModel.address('בית ברל'),
    FlowerAddressModel.address('בית גן'),
    FlowerAddressModel.address('בית גוברין'),
    FlowerAddressModel.address('בית גמליאל'),
    FlowerAddressModel.address('בית דגן'),
    FlowerAddressModel.address('בית הגדי'),
    FlowerAddressModel.address('בית הלוי'),
    FlowerAddressModel.address('בית הלל'),
    FlowerAddressModel.address('בית העמק'),
    FlowerAddressModel.address('בית הערבה'),
    FlowerAddressModel.address('בית השיטה'),
    FlowerAddressModel.address('בית זיד'),
    FlowerAddressModel.address('בית זית'),
    FlowerAddressModel.address('בית זרע'),
    FlowerAddressModel.address('בית חולים פוריה'),
    FlowerAddressModel.address('בית חורון'),
    FlowerAddressModel.address('בית חירות'),
    FlowerAddressModel.address('בית חלקיה'),
    FlowerAddressModel.address('בית חנן'),
    FlowerAddressModel.address('בית חנניה'),
    FlowerAddressModel.address('בית חשמונאי'),
    FlowerAddressModel.address('בית יהושע'),
    FlowerAddressModel.address('בית יוסף'),
    FlowerAddressModel.address('בית ינאי'),
    FlowerAddressModel.address('בית יצחק-שער חפר'),
    FlowerAddressModel.address('בית לחם הגלילית'),
    FlowerAddressModel.address('בית מאיר'),
    FlowerAddressModel.address('בית נחמיה'),
    FlowerAddressModel.address('בית ניר'),
    FlowerAddressModel.address('בית נקופה'),
    FlowerAddressModel.address('בית עובד'),
    FlowerAddressModel.address('בית עוזיאל'),
    FlowerAddressModel.address('בית עזרא'),
    FlowerAddressModel.address('בית עריף'),
    FlowerAddressModel.address('בית צבי'),
    FlowerAddressModel.address('בית קמה'),
    FlowerAddressModel.address('בית קשת'),
    FlowerAddressModel.address('בית רבן'),
    FlowerAddressModel.address('בית רימון'),
    FlowerAddressModel.address('בית שאן'),
    FlowerAddressModel.address('בית שמש'),
    FlowerAddressModel.address('בית שערים'),
    FlowerAddressModel.address('בית שקמה'),
    FlowerAddressModel.address('בית אהרן'),
    FlowerAddressModel.address('ביתר עילית'),
    FlowerAddressModel.address('בלפוריה'),
    FlowerAddressModel.address('בן זכאי'),
    FlowerAddressModel.address('בן עמי'),
    FlowerAddressModel.address('בן שמן'),
    FlowerAddressModel.address('בני ברק'),
    FlowerAddressModel.address('בני דקלים'),
    FlowerAddressModel.address('בני דרום'),
    FlowerAddressModel.address('בני דרור'),
    FlowerAddressModel.address('בני יהודה'),
    FlowerAddressModel.address('בני נצרים'),
    FlowerAddressModel.address('בני עטרות'),
    FlowerAddressModel.address('בני עי"ש'),
    FlowerAddressModel.address('בני ציון'),
    FlowerAddressModel.address('בני ראם'),
    FlowerAddressModel.address('בניה'),
    FlowerAddressModel.address('בנימינה-גבעת עדה'),
    FlowerAddressModel.address('בסמ"ה'),
    FlowerAddressModel.address('בסמת טבעון'),
    FlowerAddressModel.address('בענה'),
    FlowerAddressModel.address('בצרה'),
    FlowerAddressModel.address('בצת'),
    FlowerAddressModel.address('בקוע'),
    FlowerAddressModel.address('בקעות'),
    FlowerAddressModel.address('בקעת נטופה'),
    FlowerAddressModel.address('בקעת תירען'),
    FlowerAddressModel.address('בר-לב'),
    FlowerAddressModel.address('בר גיורא'),
    FlowerAddressModel.address('בר יוחאי'),
    FlowerAddressModel.address('ברוכין'),
    FlowerAddressModel.address('ברור חיל'),
    FlowerAddressModel.address('ברוש'),
    FlowerAddressModel.address('ברכה'),
    FlowerAddressModel.address('ברכיה'),
    FlowerAddressModel.address('ברעם'),
    FlowerAddressModel.address('ברק'),
    FlowerAddressModel.address('ברקאי'),
    FlowerAddressModel.address('ברקן'),
    FlowerAddressModel.address('ברקת'),
    FlowerAddressModel.address('בת הדר'),
    FlowerAddressModel.address('בת חן'),
    FlowerAddressModel.address('בת חפר'),
    FlowerAddressModel.address('בת ים'),
    FlowerAddressModel.address('בת עין'),
    FlowerAddressModel.address('בת שלמה'),
    FlowerAddressModel.address('בתי זיקוק-קישון'),
    FlowerAddressModel.address('גדיידה-מכר'),
    FlowerAddressModel.address('גולס'),
    FlowerAddressModel.address('גלגוליה'),
    FlowerAddressModel.address('גנאביב'),
    FlowerAddressModel.address('גסר א-זרקא'),
    FlowerAddressModel.address('גש(גוש חלב)'),
    FlowerAddressModel.address('גת'),
    FlowerAddressModel.address('גאולי תימן'),
    FlowerAddressModel.address('גאולים'),
    FlowerAddressModel.address('גאון הירדן'),
    FlowerAddressModel.address('גאליה'),
    FlowerAddressModel.address('גבולות'),
    FlowerAddressModel.address('גבים'),
    FlowerAddressModel.address('גבע'),
    FlowerAddressModel.address('גבע בנימין'),
    FlowerAddressModel.address('גבע כרמל'),
    FlowerAddressModel.address('גבעולים'),
    FlowerAddressModel.address('גבעון החדשה'),
    FlowerAddressModel.address('גבעות בר'),
    FlowerAddressModel.address('גבעות אבני'),
    FlowerAddressModel.address('גבעות אלה'),
    FlowerAddressModel.address('גבעת ברנר'),
    FlowerAddressModel.address('גבעת השלושה'),
    FlowerAddressModel.address('גבעת זאב'),
    FlowerAddressModel.address('גבעת ח"ן'),
    FlowerAddressModel.address('גבעת חביבה'),
    FlowerAddressModel.address('גבעת חיים(איחוד)'),
    FlowerAddressModel.address('גבעת חיים(מאוחד)'),
    FlowerAddressModel.address('גבעת יואב'),
    FlowerAddressModel.address('גבעת יערים'),
    FlowerAddressModel.address('גבעת ישעיהו'),
    FlowerAddressModel.address('גבעת כ"ח'),
    FlowerAddressModel.address('גבעת ניל"י'),
    FlowerAddressModel.address('גבעת עוז'),
    FlowerAddressModel.address('גבעת שמואל'),
    FlowerAddressModel.address('גבעת שמש'),
    FlowerAddressModel.address('גבעת שפירא'),
    FlowerAddressModel.address('גבעתי'),
    FlowerAddressModel.address('גבעתיים'),
    FlowerAddressModel.address('גברעם'),
    FlowerAddressModel.address('גבת'),
    FlowerAddressModel.address('גדות'),
    FlowerAddressModel.address('גדיש'),
    FlowerAddressModel.address('גדעונה'),
    FlowerAddressModel.address('גדרה'),
    FlowerAddressModel.address('גולן דרומי'),
    FlowerAddressModel.address('גולן צפוני'),
    FlowerAddressModel.address('גונן'),
    FlowerAddressModel.address('גורן'),
    FlowerAddressModel.address('גורנות הגליל'),
    FlowerAddressModel.address('גזית'),
    FlowerAddressModel.address('גזר'),
    FlowerAddressModel.address('גיאה'),
    FlowerAddressModel.address('גיבתון'),
    FlowerAddressModel.address('גיזו'),
    FlowerAddressModel.address('גילון'),
    FlowerAddressModel.address('גילת'),
    FlowerAddressModel.address('גינוסר'),
    FlowerAddressModel.address('גיניגר'),
    FlowerAddressModel.address('גינתון'),
    FlowerAddressModel.address('גיתה'),
    FlowerAddressModel.address('גיתית'),
    FlowerAddressModel.address('גלאון'),
    FlowerAddressModel.address('גלגל'),
    FlowerAddressModel.address('גליל ים'),
    FlowerAddressModel.address('גליל עליון'),
    FlowerAddressModel.address('גליל תחתון'),
    FlowerAddressModel.address('גלעד'),
    FlowerAddressModel.address('גמ"ל מחוז דרום'),
    FlowerAddressModel.address('גמזו'),
    FlowerAddressModel.address('גן הדרום'),
    FlowerAddressModel.address('גן השומרון'),
    FlowerAddressModel.address('גן חיים'),
    FlowerAddressModel.address('גן יאשיה'),
    FlowerAddressModel.address('גן יבנה'),
    FlowerAddressModel.address('גן נר'),
    FlowerAddressModel.address('גן שורק'),
    FlowerAddressModel.address('גן שלמה'),
    FlowerAddressModel.address('גן שמואל'),
    FlowerAddressModel.address('גנות'),
    FlowerAddressModel.address('גנות הדר'),
    FlowerAddressModel.address('גני הדר'),
    FlowerAddressModel.address('גני טל'),
    FlowerAddressModel.address('גני יוחנן'),
    FlowerAddressModel.address('גני מודיעין'),
    FlowerAddressModel.address('גני עם'),
    FlowerAddressModel.address('גני תקווה'),
    FlowerAddressModel.address('געש'),
    FlowerAddressModel.address('געתון'),
    FlowerAddressModel.address('גפן'),
    FlowerAddressModel.address('גרופית'),
    FlowerAddressModel.address('גשור'),
    FlowerAddressModel.address('גשר'),
    FlowerAddressModel.address('גשר הזיו'),
    FlowerAddressModel.address('גת'),
    FlowerAddressModel.address('גת רימון'),
    FlowerAddressModel.address('דאלית אל-כרמל'),
    FlowerAddressModel.address('דבורה'),
    FlowerAddressModel.address('דבורייה'),
    FlowerAddressModel.address('דבירה'),
    FlowerAddressModel.address('דברת'),
    FlowerAddressModel.address('דגניה א'),
    FlowerAddressModel.address('דניה ב'),
    FlowerAddressModel.address('דוב"ב'),
    FlowerAddressModel.address('דולב'),
    FlowerAddressModel.address('דור'),
    FlowerAddressModel.address('דורות'),
    FlowerAddressModel.address('דחי'),
    FlowerAddressModel.address('דייר אל-אסד'),
    FlowerAddressModel.address('דייר חנא'),
    FlowerAddressModel.address('דייר ראפאת'),
    FlowerAddressModel.address('דימונה'),
    FlowerAddressModel.address('דישון'),
    FlowerAddressModel.address('דלייה'),
    FlowerAddressModel.address('דלתון'),
    FlowerAddressModel.address('דמיידה'),
    FlowerAddressModel.address('דן'),
    FlowerAddressModel.address('דפנה'),
    FlowerAddressModel.address('דקל'),
    FlowerAddressModel.address('דרום השרון'),
    FlowerAddressModel.address('דרום יהודה'),
    FlowerAddressModel.address('דריגאת'),
    FlowerAddressModel.address('האון'),
    FlowerAddressModel.address('הבונים'),
    FlowerAddressModel.address('הגושרים'),
    FlowerAddressModel.address('הדר עם'),
    FlowerAddressModel.address('הוד שרון'),
    FlowerAddressModel.address('אשדוד'),
    FlowerAddressModel.address('יבנה'),
    FlowerAddressModel.address('חיפה'),
    FlowerAddressModel.address('קריית שמונה'),
    FlowerAddressModel.address('חצור'),
    FlowerAddressModel.address('יקנעם'),
    FlowerAddressModel.address('באר שבע'),
    FlowerAddressModel.address('אילת'),
    FlowerAddressModel.address('גבעתיים'),
  ];
  FlowerAddressModel _flowerAddressSelected;
  int _pagination = 0; // num of item to display  . always just 5 items

  @override
  void dispose() {
    super.dispose(); //destory app when close

    _placeSub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/back2.png"), fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
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
                            address.address.toLowerCase() ==
                            string.toLowerCase(),
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
                          'חפש צמחים',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ResponsiveScreen().heightMediaQuery(context, 10),
              ),
              Container(
                height: ResponsiveScreen().heightMediaQuery(context, 370),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.separated(
                        itemCount: flowers.length,
                        itemBuilder: (context, i) {
                          return Container(
                            height: ResponsiveScreen()
                                .heightMediaQuery(context, 50),
                            margin: EdgeInsets.only(
                              left: ResponsiveScreen()
                                  .widthMediaQuery(context, 20),
                              right: ResponsiveScreen()
                                  .widthMediaQuery(context, 20),
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, i) {
                          return SizedBox(
                            height: ResponsiveScreen()
                                .heightMediaQuery(context, 10),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ResponsiveScreen().heightMediaQuery(context, 20),
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
                            minWidth: ResponsiveScreen()
                                .widthMediaQuery(context, 150),
                            minHeight: ResponsiveScreen()
                                .heightMediaQuery(context, 45),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'הבא',
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
      _placeSub?.cancel(); //ols search delte if i want new search
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
