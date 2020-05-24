//model class


import 'package:flutterapp2/model/flower.dart';

class City{
 List<Flower> flowers;

 City(this.flowers);

 factory City.fromJson(Map<String,dynamic> data){
   final flowersMap = data['flowers'] as Map<String,dynamic>;
   List<Flower> flowersData = List();
   flowersMap.values.forEach((element) {
     flowersData.add(Flower.fromJson(element as Map<String,dynamic>));
   });
   return City(flowersData);//object city
 }


}