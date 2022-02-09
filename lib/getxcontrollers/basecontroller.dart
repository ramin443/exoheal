import 'package:exoheal/screens/base/exercises.dart';
import 'package:exoheal/screens/base/home.dart';
import 'package:exoheal/screens/base/profile.dart';
import 'package:get/get.dart';

class BaseController extends GetxController{
  int selectedindex=0;
  List children=[Home(),Exercises(),Profile()];
  setindex(int index){
    selectedindex=index;
    update();
  }
}