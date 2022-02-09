import 'dart:async';

import 'package:exoheal/constants/color_constants.dart';
import 'package:exoheal/constants/fontconstants.dart';
import 'package:exoheal/datamodels/ExerciseModel.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class FullLapController extends GetxController {
  int currentexercise = 0;
  bool loading=false;

  static const countdownDuration = Duration(minutes: 8);
  Duration duration = Duration();
  Timer? timer;
  bool timerstarted = false;
  List<ExerciseModel> staticexerciselist=[
    ExerciseModel("exohealgreen", "Finger Tip Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min"),
    ExerciseModel("exohealgreen", "Haptic Exercise Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min"),
    ExerciseModel("exohealgreen", "Mirror Therapy",
        "Make sure you have bluetooth on your device turned on", "8 min"),
    ExerciseModel("exohealgreen", "Grabbing Exercise",
        "Make sure you have bluetooth on your device turned on", "8 min"),
  ];
  bool countDown = true;
  String twoDigits(int n) => n.toString().padLeft(2,'0');
  updatet(){
    update();
  }
  setcurrentexerciseindex(int index){
    currentexercise=index;
    update();
  }

  void reset(){
    if (countDown){
      duration = countdownDuration;
      update();
    } else{
      duration = Duration();
      update();
    }
  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1),(_) => addTime());
  }

  void addTime(){
    final addSeconds = countDown ? -1 : 1;
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0){
        timer?.cancel();
      } else{
        duration = Duration(seconds: seconds);

      }
  update();
  }

  void stopTimer({bool resets = true}){
    if (resets){
      reset();
    }
    timer?.cancel();
    update();
  }



  void setcurrentindex(int index) {
    currentexercise = index;
    update();
  }

  Widget pagerow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
        top: screenwidth * 0.096,
      ),
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: screenwidth * 0.0746,
            width: screenwidth * 0.0746,
            decoration: BoxDecoration(
              color: currentexercise >= 0 ? exohealgreen : darkgrey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                child: Text(
                  "1",
                  style: TextStyle(
                      fontFamily: interregular,
                      fontSize: screenwidth * 0.0293,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 2,
            width: screenwidth * 0.106,
            decoration: BoxDecoration(color: Color(0xffEAEAEA)),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: screenwidth * 0.0746,
            width: screenwidth * 0.0746,
            decoration: BoxDecoration(
              color: currentexercise >= 1 ? exohealgreen : darkgrey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                child: Text(
                  "2",
                  style: TextStyle(
                      fontFamily: interregular,
                      fontSize: screenwidth * 0.0293,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 2,
            width: screenwidth * 0.106,
            decoration: BoxDecoration(color: Color(0xffEAEAEA)),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: screenwidth * 0.0746,
            width: screenwidth * 0.0746,
            decoration: BoxDecoration(
              color: currentexercise >= 2 ? exohealgreen : darkgrey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                child: Text(
                  "3",
                  style: TextStyle(
                      fontFamily: interregular,
                      fontSize: screenwidth * 0.0293,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 2,
            width: screenwidth * 0.106,
            decoration: BoxDecoration(color: Color(0xffEAEAEA)),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: screenwidth * 0.0746,
            width: screenwidth * 0.0746,
            decoration: BoxDecoration(
              color: currentexercise >= 3 ? exohealgreen : darkgrey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                child: Text(
                  "4",
                  style: TextStyle(
                      fontFamily: interregular,
                      fontSize: screenwidth * 0.0293,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget timerslider(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenwidth * 0.08),
      child: SleekCircularSlider(
          min: 0,
          max: 100,
          initialValue: ((double.parse(duration.inSeconds.toString())/(8*60))*100),
          appearance: CircularSliderAppearance(

              //      size: screenWidth*screenHeight*0.0005347,
              size: screenwidth * 0.48,
              //size: 190,
              animationEnabled: true,
              spinnerMode: debugInstrumentationEnabled,
              customWidths: CustomSliderWidths(
                  handlerSize: 0, trackWidth: 6, progressBarWidth: 6),
              angleRange: 360,
              startAngle: 135,
              infoProperties: InfoProperties(
                  topLabelText: twoDigits(duration.inMinutes.remainder(60)) +
                      ":" +
    twoDigits(duration.inSeconds.remainder(60)),
                  topLabelStyle: TextStyle(
                      fontFamily: interregular,
                      color: exohealdarkgrey,
                      fontSize: screenwidth * 0.096),
                  mainLabelStyle: TextStyle(
                      fontFamily: proximanovaregular,
                      color: Color(0xffFBE6EE),
                      fontSize: 0)),
              customColors: CustomSliderColors(
                  trackColor: Color(0xffEAEAEA),
                  hideShadow: true,
                  progressBarColors: [
                    exohealgreen,
                    exohealgreen,
                    // Color(0xff00D4BE),
// Color(0xff0017A9)
                  ]))),
    );
  }

  Widget exercisedetail(BuildContext context, ExerciseModel exerciseModel) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenwidth * 0.0853),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              exerciseModel.exercisetype.toString(),
              style: TextStyle(
                  fontFamily: intersemibold,
                  fontSize: screenwidth * 0.04,
                  color: Color(0xff404040)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: screenwidth * 0.032,
                left: screenwidth * 0.1033,
                right: screenwidth * 0.1033),
            child: Text(
              exerciseModel.description.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: intermedium,
                  fontSize: screenwidth * 0.0266,
                  color: Color(0xff989898)),
            ),
          ),
        ],
      ),
    );
  }
  bool showmessagebox=false;

  setmessageboxtrue(){
    showmessagebox=true;
    update();
  }
  setmessageboxfalse(){
    showmessagebox=false;
    update();
  }
  Widget messagebox(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return     Container(
      width: screenwidth,
      margin: EdgeInsets.only(top: screenwidth * 0.0186),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: screenwidth * 0.074),
            child: Text(
              "Cannot find ExoHeal device nearby",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: intermedium,
                  color: Colors.redAccent,
                  fontSize: screenwidth * 0.0293),
            ),
          ),
        ],
      ),
    );
  }
  setloadingfalse(){
    loading=false;
    setmessageboxtrue();
    update();
  }
  Widget notconnectedcolumn(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          notconnectedcircle(context),
          showmessagebox?messagebox(context):
          Container(
            margin: EdgeInsets.only(top: screenwidth*0.032,
            ),
            child: Text(
              "Make sure the bluetooth on your device\n"
                  "remains turned on during the exercise",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: intermedium,
                  fontSize: screenwidth*0.0266,
                  color: Color(0xff989898)),
            ),
          ),

          GestureDetector(
            onTap: (){
              loading=true;
              update();
              Future.delayed(Duration(seconds: 5),setloadingfalse);
            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth * 0.0373),
              width: screenwidth * 0.616,
              padding: EdgeInsets.only(
                  top: screenwidth * 0.0203,
                  bottom: screenwidth * 0.0203,
                  //    left: screenwidth*0.0373,
                  right: screenwidth * 0.0373),
              decoration: BoxDecoration(
                  color: exohealgreen,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0186,
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth * 0.074),
                      child: Text(
                        "Connect to ExoHeal",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.white,
                            fontSize: screenwidth * 0.032),
                      ),
                    ),
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0486,
                        color: Color(0xffECECEC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
  Widget connectedcolumn(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          connectedcircle(context),
          Container(
            margin: EdgeInsets.only(top: screenwidth*0.032,
            ),
            child: Text(
              "Make sure the bluetooth on your device\n"
                  "remains turned on during the exercise",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: intermedium,
                  fontSize: screenwidth*0.0266,
                  color: Color(0xff989898)),
            ),
          ),
          timercontrolbuttons(context),
          timerbuttons(context)

        ],
      ),
    );
  }
  Widget timerrunningcolumn(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          timerslider(context),
          Container(
            margin: EdgeInsets.only(top: screenwidth*0.032,
            ),
            child: Text(
              "Make sure the bluetooth on your device\n"
                  "remains turned on during the exercise",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: intermedium,
                  fontSize: screenwidth*0.0266,
                  color: Color(0xff989898)),
            ),
          ),
          timercontrolbuttons(context),
          GestureDetector(
            onTap: (){
              if(currentexercise==3){
                stopTimer();
                setcurrentindex(0);
                Navigator.pop(context);
              }else{
                stopTimer();
                setcurrentexerciseindex(currentexercise+1);
                reset();
                startTimer();
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth * 0.0373),
              width: screenwidth * 0.616,
              padding: EdgeInsets.only(
                  top: screenwidth * 0.0203,
                  bottom: screenwidth * 0.0203,
                  //    left: screenwidth*0.0373,
                  right: screenwidth * 0.0373),
              decoration: BoxDecoration(
                  color: exohealgreen,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0186,
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth * 0.074),
                      child: Text(
                        currentexercise==3?"End Exercise": "Skip to Next One",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.white,
                            fontSize: screenwidth * 0.032),
                      ),
                    ),
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0486,
                        color: Color(0xffECECEC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              stopTimer();

            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth * 0.0373),
              width: screenwidth * 0.616,
              padding: EdgeInsets.only(
                  top: screenwidth * 0.0203,
                  bottom: screenwidth * 0.0203,
                  //    left: screenwidth*0.0373,
                  right: screenwidth * 0.0373),
              decoration: BoxDecoration(
                  color: exohealdarkgrey,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0186,
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth * 0.074),
                      child: Text(
                        "Stop and Disconnect",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.white,
                            fontSize: screenwidth * 0.032),
                      ),
                    ),
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.square,
                        size: screenwidth * 0.0486,
                        color: Color(0xffECECEC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget connectedcircle(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenwidth * 0.48,
        height: screenwidth * 0.48,
        margin: EdgeInsets.only(top: screenwidth * 0.08),
        child: Stack(children: [
          SvgPicture.asset(
            "assets/images/dualhandhome.svg",
            width: screenwidth * 0.48,
          ),
          Container(
            width: screenwidth * 0.48,
            height: screenwidth * 0.48,
            padding: EdgeInsets.only(bottom: screenwidth * 0.112),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    "Status: Connected",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: exohealgreen,
                        fontSize: screenwidth * 0.0293),
                  ),
                )
              ],
            ),
          )
        ]));
  }
  Widget notconnectedcircle(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenwidth * 0.48,
        height: screenwidth * 0.48,
        margin: EdgeInsets.only(top: screenwidth * 0.08),
        child: Stack(children: [
          SvgPicture.asset(
            "assets/images/robotichandhome.svg",
            width: screenwidth * 0.48,
          ),
          Container(
            width: screenwidth * 0.48,
            height: screenwidth * 0.48,
            padding: EdgeInsets.only(bottom: screenwidth * 0.112),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    "Status: Not Connected",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: exohealdarkgrey,
                        fontSize: screenwidth * 0.0293),
                  ),
                )
              ],
            ),
          )
        ]));
  }
  void timerstarts()async{
    timerstarted=true;
    startTimer();
    update();
  }

  Widget timercontrolbuttons(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    final isRunning = timer == null? false: timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenwidth*0.096),
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isRunning || isCompleted
              ?   GestureDetector(
            onTap: (){
              if(isRunning){
                stopTimer(resets: false);
              }else{
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: screenwidth*0.08),
              height: screenwidth*0.101,width: screenwidth*0.101,
              decoration: BoxDecoration(
                color: exohealdarkgrey,
                shape: BoxShape.circle
              ),
              child: Icon(
                CupertinoIcons.pause_solid,
                size: screenwidth*0.053,
                color: Colors.white,
              ),
            ),
          ): GestureDetector(
            onTap: (){
                startTimer();
            },
            child: Container(
              margin: EdgeInsets.only(right: screenwidth*0.08),
              height: screenwidth*0.101,width: screenwidth*0.101,
              decoration: BoxDecoration(
                  color: exohealdarkgrey,
                  shape: BoxShape.circle
              ),
              child: Icon(
                CupertinoIcons.play_fill,
                size: screenwidth*0.053,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              reset();
            },
            child: Container(
              height: screenwidth*0.101,width: screenwidth*0.101,
              decoration: BoxDecoration(
                  color: exohealdarkgrey,
                  shape: BoxShape.circle
              ),
              child: Icon(
                FeatherIcons.rotateCw,
                size: screenwidth*0.053,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget connectingcolumn(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return   Column(
      children: [
        Container(
            width: screenwidth * 0.48,
            height: screenwidth * 0.48,
            margin: EdgeInsets.only(top: screenwidth * 0.08),
            child:
            Stack(
                children:[
                  SvgPicture.asset(
                    "assets/images/robotichandhome.svg",
                    width: screenwidth * 0.48,
                  ),
                  Container(
                    width: screenwidth * 0.48,
                    height: screenwidth * 0.48,
                    padding: EdgeInsets.only(bottom: screenwidth * 0.112),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Text("Status: Not Connected",style: TextStyle(
                              fontFamily: intermedium,
                              color: exohealdarkgrey,
                              fontSize: screenwidth*0.0293
                          ),),
                        )
                      ],
                    ),
                  )
                ])
        ),
        Container(
          width: screenwidth*0.616,
          margin: EdgeInsets.only(top: screenwidth*0.0586),
          padding: EdgeInsets.symmetric(
              vertical: screenwidth*0.0203),
          decoration: BoxDecoration(
              color: exohealgreen,
              borderRadius: BorderRadius.all(Radius.circular(6))
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenwidth*0.074),
                  child: Text("Searching ExoHeal device",style: TextStyle(
                      fontFamily: intermedium,
                      color: Colors.white,
                      fontSize: screenwidth*0.032
                  ),),
                ),
                Container(
                  margin: EdgeInsets.only(left: screenwidth*0.048),
                  width:  screenwidth*0.0486,
                  height:  screenwidth*0.0486,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    backgroundColor: Colors.white,
                  )
                  ,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget timerbuttons(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
//      margin: EdgeInsets.only(top: screenwidth * 0.12),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              reset();
              startTimer();
            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth * 0.0373),
              width: screenwidth * 0.616,
              padding: EdgeInsets.only(
                  top: screenwidth * 0.0203,
                  bottom: screenwidth * 0.0203,
                  //    left: screenwidth*0.0373,
                  right: screenwidth * 0.0373),
              decoration: BoxDecoration(
                  color: exohealgreen,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0186,
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth * 0.074),
                      child: Text(
                        "Start Exercise",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.white,
                            fontSize: screenwidth * 0.032),
                      ),
                    ),
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0486,
                        color: Color(0xffECECEC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              stopTimer();
            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth * 0.0373),
              width: screenwidth * 0.616,
              padding: EdgeInsets.only(
                  top: screenwidth * 0.0203,
                  bottom: screenwidth * 0.0203,
                  //    left: screenwidth*0.0373,
                  right: screenwidth * 0.0373),
              decoration: BoxDecoration(
                  color: exohealdarkgrey, borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: screenwidth * 0.0186,
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth * 0.074),
                      child: Text(
                        "Cancel and return",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.white,
                            fontSize: screenwidth * 0.032),
                      ),
                    ),
                    Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
                      child: Icon(
                        CupertinoIcons.xmark,
                        size: screenwidth * 0.0486,
                        color: Color(0xffECECEC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget individualbutton(
      BuildContext context, Color color, String buttontext, Icon icon) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenwidth * 0.0373),
      width: screenwidth * 0.616,
      padding: EdgeInsets.only(
          top: screenwidth * 0.0203,
          bottom: screenwidth * 0.0203,
          //    left: screenwidth*0.0373,
          right: screenwidth * 0.0373),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
              child: Icon(
                CupertinoIcons.arrow_right,
                size: screenwidth * 0.0186,
                color: Colors.transparent,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.074),
              child: Text(
                buttontext,
                style: TextStyle(
                    fontFamily: intermedium,
                    color: Colors.white,
                    fontSize: screenwidth * 0.032),
              ),
            ),
            Container(
//                    margin: EdgeInsets.only(left: screenwidth*0.048),
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
}
