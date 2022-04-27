import 'package:exoheal/constants/fontconstants.dart';
import 'package:exoheal/datamodels/ExerciseModel.dart';
import 'package:exoheal/getxcontrollers/fulllapcontroller.dart';
import 'package:exoheal/screens/exercise/full_lap_exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class IndividualExercise extends StatelessWidget {
  final ExerciseModel? exerciseModel;
   IndividualExercise({this.exerciseModel});
  final FullLapController fullLapController = Get.put(FullLapController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return
      GetBuilder<FullLapController>(
        initState: (v){
          fullLapController.clearData();
          fullLapController.setinitialdocreport();
          fullLapController.stopTimer();
          fullLapController.setmessageboxfalse();
          fullLapController.initstat();
        },
    init: FullLapController(),
        builder: (fulllapcontroller){
        return
      Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [

        ],
        leading: IconButton(
            onPressed: () {
              fulllapcontroller.shutgraph();
              fulllapcontroller.setmirrortherapyfalse();
              fulllapcontroller.settimerfalse();
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
            width: screenwidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                fulllapcontroller.exercisedetail(context,
                    exerciseModel!),
                fulllapcontroller.istimercomplete?
                    fulllapcontroller.exercisecompletedstate(context):
                fulllapcontroller.exerciserunningstate(context),
              //  fulllapcontroller.exerciserunning(context),
     /*           fulllapcontroller.loading?
                    fulllapcontroller.connectingcolumn(context):
                fulllapcontroller.notconnectedcolumn(context)*/
              ],
            ),
          ),
        ),
    );});
  }
}
