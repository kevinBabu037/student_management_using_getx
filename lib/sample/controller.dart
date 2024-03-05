import 'package:get/get.dart';

class MyController extends GetxController{
  List arr=[1,2].obs;
  
  var countt=0.obs;
  

  addFun(count){
      count++;
      arr.add(10);
      update();
      countt=countt+2;
      ever(countt, (callback) =>print('call ever') );  
     once(countt, (callback) => print('call once'));
     debounce(countt, (callback) =>  print('call debounse'),time: Duration(seconds: 2));
     
  }

 

}