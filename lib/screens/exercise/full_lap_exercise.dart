import 'package:exoheal/constants/color_constants.dart';
import 'package:exoheal/constants/fontconstants.dart';
import 'package:exoheal/datamodels/ExerciseModel.dart';
import 'package:exoheal/getxcontrollers/fulllapcontroller.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
class FullLapExercise extends StatelessWidget {
  final List<ExerciseModel>? exerciselist;
  FullLapExercise({this.exerciselist});
  final FullLapController fullLapController = Get.put(FullLapController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return GetBuilder<FullLapController>(
      initState: (v){
        fullLapController.setmessageboxfalse();

        //  fullLapController.reset();
      },
        init: FullLapController(),
        builder: (fulllapcontroller){
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [

          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.arrow_left,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                fulllapcontroller.pagerow(context),
                fulllapcontroller.exercisedetail(context,
               exerciselist![fulllapcontroller.currentexercise]),
          //    fulllapcontroller.timerslider(context),
               fulllapcontroller.loading?fulllapcontroller.connectingcolumn(context):
                fulllapcontroller.notconnectedcolumn(context),
           /*   fulllapcontroller.notconnectedcircle(context),
                fulllapcontroller.timercontrolbuttons(context),
              fulllapcontroller.timerbuttons(context),*/

              ],
            ),
          ),
        ),
      );});
    }

  }

