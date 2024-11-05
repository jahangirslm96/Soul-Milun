
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';

void moveForword(path){
  Get.toNamed(path);
  storge.write('screen', path); 
}