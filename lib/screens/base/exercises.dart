import 'package:exoheal/constants/fontconstants.dart';
import 'package:exoheal/getxcontrollers/exercisecontroller.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Exercises extends StatelessWidget {
   Exercises({Key? key}) : super(key: key);
  final ExerciseController exerciseController = Get.put(ExerciseController());
   final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return

      GetBuilder<ExerciseController>(
          initState: (v){
            exerciseController.initscrollcontroller();
          },
          init: ExerciseController(),
          builder: (exercisecontroller){
        return Scaffold(
          key: _key,
          drawer: exercisecontroller.drawer(context),
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,

            leading: IconButton(
                onPressed: () {
                  _key.currentState!.openDrawer();
                },
                icon: Icon(
                  FeatherIcons.menu,
                  size: 20,
                  color: Color(0xff575757),
                )),
            centerTitle: true,
            title: Container(
              child: Text(
                "ExoHeal",
                style: TextStyle(
                    fontFamily: proximanovaregular,
                    fontSize: 18,
                    color: Color(0xff404040)),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              width: screenwidth,
              padding: EdgeInsets.symmetric(vertical: screenwidth*0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  exercisecontroller.exerciserow(context,exercisecontroller.staticexerciselist),
                  exercisecontroller.progressrow(context),
                  FirebaseAuth.instance.currentUser!.email!=testuseremail?
                      exercisecontroller.progressemptystate(context):
                  exercisecontroller.barchart(context),
                ],
              ),
            ),
          ),
        );});
    }
   double getweeklyprogresses(int i){
     switch (i){
       case 0:
         return 1.9;
       case 1:
         return 2.4;
       case 2:
         return 2.4;
       case 3:
         return 1.1;
       case 4:
         return 3.2;
       case 5:
         return 3.6;
       case 6:
         return 3.1;
       default:
         return 3;
     }
   }
  }

